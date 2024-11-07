import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:zneempharmacy/utils/app_color.dart';
import '../../model/address model/address_model.dart';
import '../../services/address service/address_service.dart';

class AddUserAddressPage extends StatefulWidget {
  const AddUserAddressPage({super.key});

  @override
  AddUserAddressPageState createState() => AddUserAddressPageState();
}

class AddUserAddressPageState extends State<AddUserAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final AddressService addressService = AddressService();

  String? addresseeName;
  String? buildingNameOrNumber;
  String? streetNameOrNumber;
  String? areaOrNeighborhood;
  String? city;
  String? emirate;
  String? postalCode;
  String? poBox;
  String? country;
  String? phoneNumber;
  int? addressid;

  List<AddressModel> addresses = [];

  @override
  void initState() {
    super.initState();
    _fetchAddresses();
  }

  Future<void> _fetchAddresses() async {
    try {
      addresses = await addressService.fetchAddresses();
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load addresses: $e')),
      );
    }
  }

  Future<void> _submitAddress() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      AddressModel address = AddressModel(
        adressid: addressid,
        addresseeName: addresseeName!,
        buildingNameOrNumber: buildingNameOrNumber!,
        streetNameOrNumber: streetNameOrNumber!,
        areaOrNeighborhood: areaOrNeighborhood!,
        city: city!,
        emirate: emirate!,
        postalCode: postalCode!,
        poBox: poBox!,
        country: country!,
        phoneNumber: phoneNumber!,
      );

      try {
        await addressService.addUserAddress(address);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Address added successfully!')),
        );

        await _fetchAddresses();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add address: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Add User',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        backgroundColor: AppColor.appbar,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(10),
                    const Text('User Name'),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Addressee Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (value) => addresseeName = value,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter the addressee name' : null,
                    ),
                    const Gap(10),
                    const Text('Building Name'),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Building Name or Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (value) => buildingNameOrNumber = value,
                      validator: (value) => value!.isEmpty
                          ? 'Enter building name or number'
                          : null,
                    ),
                    const Gap(10),
                    const Text('Street Name'),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Street Name or Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (value) => streetNameOrNumber = value,
                      validator: (value) => value!.isEmpty
                          ? 'Enter the street name or number'
                          : null,
                    ),
                    const Gap(10),
                    const Text('Area'),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Area or Neighborhood',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (value) => areaOrNeighborhood = value,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter area or neighborhood' : null,
                    ),
                    const Gap(10),
                    const Text('City'),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'City',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (value) => city = value,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter the city' : null,
                    ),
                    const Gap(10),
                    const Text('Emirate'),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Emirate',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (value) => emirate = value,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter the emirate' : null,
                    ),
                    const Gap(10),
                    const Text('Postal code'),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Postal Code',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (value) => postalCode = value,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter the postal code' : null,
                    ),
                    const Gap(10),
                    const Text('Country'),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'P.O. Box',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (value) => poBox = value,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter the P.O. Box' : null,
                    ),
                    const Gap(10),
                    const Text('Country'),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Country',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (value) => country = value,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter the country' : null,
                    ),
                    const Gap(10),
                    const Text('Phone Number'),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (value) => phoneNumber = value,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter the phone number' : null,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _submitAddress,
                          child: const Text('Submit Address'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
