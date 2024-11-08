import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String? pharmacyId;

  List<AddressModel> addresses = [];

  @override
  void initState() {
    super.initState();
    _fetchPharmacyId();
    _fetchAddresses();
  }

  void _fetchPharmacyId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      pharmacyId = prefs.getString('pharmacyId');
    });
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
        pharmacyId: pharmacyId
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
        backgroundColor: AppColor.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                _buildInputField('User Name', 'Addressee Name',
                    onSave: (value) => addresseeName = value),
                _buildInputField('Building Name', 'Building Name or Number',
                    onSave: (value) => buildingNameOrNumber = value),
                _buildInputField('Street Name', 'Street Name or Number',
                    onSave: (value) => streetNameOrNumber = value),
                _buildInputField('Area', 'Area or Neighborhood',
                    onSave: (value) => areaOrNeighborhood = value),
                _buildInputField('City', 'City',
                    onSave: (value) => city = value),
                _buildInputField('Emirate', 'Emirate',
                    onSave: (value) => emirate = value),
                _buildInputField('Postal Code', 'Postal Code',
                    onSave: (value) => postalCode = value),
                _buildInputField('P.O. Box', 'P.O. Box',
                    onSave: (value) => poBox = value),
                _buildInputField('Country', 'Country',
                    onSave: (value) => country = value),
                _buildInputField('Phone Number', 'Phone Number',
                    keyboardType: TextInputType.phone,
                    onSave: (value) => phoneNumber = value),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitAddress,
                    child: const Text('Submit Address'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint,
      {TextInputType keyboardType = TextInputType.text,
      required Function(String?) onSave}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const Gap(8),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onSaved: onSave,
          keyboardType: keyboardType,
          validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
        ),
        const Gap(16),
      ],
    );
  }
}
