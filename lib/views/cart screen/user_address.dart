import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zneempharmacy/views/add%20userpage/add_user_address.dart';
import 'package:zneempharmacy/views/cart%20screen/cart_screen.dart';
import 'package:zneempharmacy/utils/app_color.dart';
import '../../model/address model/address_model.dart';
import '../../services/address service/address_service.dart';

class UserAddress extends StatefulWidget {
  const UserAddress({super.key});

  @override
  State<UserAddress> createState() => _UserAddressState();
}

class _UserAddressState extends State<UserAddress> {
  List<AddressModel> addresses = [];
  AddressModel? selectedAddress;
  final AddressService addressService = AddressService();

  Future<void> _fetchAddresses() async {
    try {
      final fetchedAddresses = await addressService.fetchAddresses();
      setState(() {
        addresses = fetchedAddresses;
      });
      print(
          'Fetched Addresses: ${addresses.map((addr) => addr.addresseeName).toList()}');
    } catch (e) {
      log('Error fetching addresses: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAddresses();
  }

  @override
  Widget build(BuildContext context) {
    log('UserAddress loaded with ${addresses.length} addresses');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Address'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: addresses.isNotEmpty
                ? ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      return GestureDetector(
                        onTap: () {
                          _selectAddress(address);
                        },
                        child: Container(
                          height: 120,
                          child: Card(
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            color: selectedAddress == address
                                ? Colors.blue[100]
                                : Colors.white,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16.0),
                              title: Text(address.addresseeName),
                              subtitle: Text(
                                'Phone: ${address.phoneNumber}\nAddress: ${address.country}',
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => CartScreen(
                                        selectedAddress: address,
                                      ),
                                    ));
                                  },
                                  icon: Icon(Icons.store)),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddUserAddressPage(),
          ));
        },
        backgroundColor: AppColor.floatingcolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _selectAddress(AddressModel address) async {
    setState(() {
      selectedAddress = address;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedAddress', json.encode(address.toJson()));

    Get.back(result: selectedAddress);
  }
}
