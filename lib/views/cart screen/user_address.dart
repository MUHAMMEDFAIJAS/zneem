// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:zneempharmacy/views/add%20userpage/add_user_address.dart';
// import 'package:zneempharmacy/views/cart%20screen/cart_screen.dart';

// import '../../model/address model/address_model.dart';
// import '../../services/address service/address_service.dart';

// class UserAddress extends StatefulWidget {
//   const UserAddress({super.key});

//   @override
//   State<UserAddress> createState() => _UserAddressState();
// }

// class _UserAddressState extends State<UserAddress> {
//   List<AddressModel> addresses = [];
//   final AddressService addressService = AddressService();

//   Future<void> _fetchAddresses() async {
//     try {
//       final fetchedAddresses = await addressService.fetchAddresses();
//       setState(() {
//         addresses = fetchedAddresses;
//       });
//     } catch (e) {
//       log('Error fetching addresses: $e');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchAddresses();
//   }

//   @override
//   Widget build(BuildContext context) {
//     log('CartScreen2 loaded with ${addresses.length} addresses');
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select Address'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Search',
//                 prefixIcon: const Icon(Icons.search),
//               ),
//             ),
//           ),
//           Expanded(
//             child: addresses.isNotEmpty
//                 ? ListView.builder(
//                     itemCount: addresses.length,
//                     itemBuilder: (context, index) {
//                       final address = addresses[index];
//                       return GestureDetector(
//                         onTap: () {
//                           _showUserDetailsDialog(context, address);
//                         },
//                         child: Container(
//                           height: 120,
//                           child: Card(
//                             elevation: 5,
//                             margin: const EdgeInsets.symmetric(
//                                 vertical: 10, horizontal: 16),
//                             child: ListTile(
//                               contentPadding: const EdgeInsets.all(16.0),
//                               title: Text(address.addresseeName),
//                               subtitle: Text(
//                                   'Phone: ${address.phoneNumber}\nAddress: ${address.country}'),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   )
//                 : const Center(child: CircularProgressIndicator()),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => AddUserAddressPage(),
//           ));
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   void _showUserDetailsDialog(BuildContext context, AddressModel address) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Address Details'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Name: ${address.addresseeName}'),
//               const SizedBox(height: 10),
//               Text('Phone: ${address.phoneNumber}'),
//               const SizedBox(height: 10),
//               Text('Address: ${address.country}'),
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               style: ElevatedButton.styleFrom(
//                 fixedSize: const Size(400, 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(color: Colors.black, fontSize: 16),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(
//                     builder: (context) => CartScreen(selectedAddress: address),
//                   ),
//                 );
//                 // Show Snackbar after navigating
//                 Get.snackbar(
//                   'Cart Created',
//                   'Selected address cart created successfully!',
//                   snackPosition: SnackPosition.BOTTOM,
//                   backgroundColor: Colors.green.withOpacity(0.8),
//                   colorText: Colors.white,
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 fixedSize: const Size(400, 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 backgroundColor: Colors.green[400],
//               ),
//               child: const Text(
//                 'Confirm',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zneempharmacy/views/add%20userpage/add_user_address.dart';
import 'package:zneempharmacy/views/cart%20screen/cart_screen.dart';
import 'package:zneempharmacy/views/medicine%20screen/medicine_screen.dart';

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
            builder: (context) => AddUserAddressPage(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _selectAddress(AddressModel address)async {
    setState(() {
      selectedAddress = address;
    });
     SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> savedAddresses = prefs.getStringList('currentAddresses') ?? [];
   if (!savedAddresses.contains(json.encode(address.toJson()))) {
    savedAddresses.add(json.encode(address.toJson()));
    await prefs.setStringList('currentAddresses', savedAddresses);
  }
    Get.back(result: selectedAddress);
  }

   Future<List<AddressModel>> getSavedAddresses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedAddresses = prefs.getStringList('currentAddresses');

    if (savedAddresses != null) {
      return savedAddresses.map((addressJson) => AddressModel.fromJson(json.decode(addressJson))).toList();
    }
    
    return [];
  }
}
