import 'dart:developer';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zneempharmacy/model/cart model/cart_model.dart';
import 'package:zneempharmacy/services/checkout service/checkout_service.dart';
import 'package:zneempharmacy/views/driver_screen/driver_screen.dart';
import '../../model/address model/address_model.dart';
import '../../model/pharmcay model/pharmacy_model.dart';
import '../order screen/order_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalPrice;
  final int totalitems;
  final AddressModel selectedAddress;
  final CartModel cartdetails;

  const CheckoutScreen({
    super.key,
    required this.totalPrice,
    required this.totalitems,
    required this.selectedAddress,
    required this.cartdetails,
  });

  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {
  String? _selectedPaymentMethod = 'credit_card';
  double offset = 0.0;
  final CheckoutService service = CheckoutService();

  PharmacyModel? _selectedPharmacy;

  @override
  void initState() {
    super.initState();
    _fetchPharmacy();
  }

  Future<void> _fetchPharmacy() async {
    try {
      List<PharmacyModel> pharmacies = await service.fetchPharmacies();
      setState(() {
        _selectedPharmacy = pharmacies.isNotEmpty ? pharmacies[0] : null;
      });
    } catch (e) {
      log("Error fetching pharmacy: $e");
    }
  }

  void _slideToRight() {
    setState(() {
      offset = 200.0;
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        offset = 0.0;
      });
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const DriverListPage(),
      ));
    });
  }

  void _navigateToOrderScreen(String phoneNumber) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => OrderScreen(
          phoneNumber: phoneNumber,
        ),
      ),
    );
  }

  Future<void> checkout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');

    if (token == null) {
      log("No auth token found. Please log in.");
      return;
    }
    log("Token: $token");
    log("Cart ID: ${widget.cartdetails.cartId}");
    log("Phone Number: ${widget.selectedAddress.phoneNumber}");
    log("Address id: ${widget.selectedAddress.addresseeName}");
    log("Pharmacy ID: ${_selectedPharmacy?.id}");
    log("Payment Method: $_selectedPaymentMethod");

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';

      Response response = await dio.post(
        'http://192.168.1.124:8081/master/order/checkout',
        data: {
          "cart_id": widget.cartdetails.cartId,
          "phone_number": widget.selectedAddress.phoneNumber,
          "address_id": widget.selectedAddress.adressid,
          "pharmacy_id": _selectedPharmacy?.addressId,
          "payment_method": _selectedPaymentMethod,
        },
      );

      if (response.statusCode == 200 &&
          response.data['responseStatus'] == "Success") {
        log("Checkout successful!");
        _navigateToOrderScreen(widget.selectedAddress.phoneNumber);
      } else {
        log("Checkout failed: ${response.data['responseDescription'] ?? response.statusMessage}");
      }
    } catch (e) {
      log("Error during checkout: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Order Details',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                dashPattern: [6, 3],
                strokeWidth: 1.2,
                color: Colors.grey,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Price (${widget.totalitems} items)',
                              style: const TextStyle(fontSize: 16)),
                          Text('AED ${widget.totalPrice}',
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Delivery Fee', style: TextStyle(fontSize: 16)),
                          Text('AED 0', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Amount',
                              style: TextStyle(fontSize: 16)),
                          Text('AED ${widget.totalPrice}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Delivered to',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.black),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.selectedAddress.addresseeName,
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 5),
                      const Text(
                        '1234 Street, Block A, Health City,\nMedVille, State 58789',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Find Driver',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _slideToRight(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[300],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    transform: Matrix4.translationValues(offset, 0, 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Find your Driver',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_ios,
                              color: Colors.white, size: 14),
                          Icon(Icons.arrow_forward_ios,
                              color: Colors.white, size: 14),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Payment Method',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const Text('Credit Card'),
                leading: Radio<String>(
                  value: 'credit_card',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Cash'),
                leading: Radio<String>(
                  value: 'cash_on_delivery',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    checkout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[300],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Confirm Order',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
