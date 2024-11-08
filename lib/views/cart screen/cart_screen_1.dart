// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:zneempharmacy/views/cart%20screen/user_address.dart';

// import '../../model/address model/address_model.dart';

// class CartScreen1 extends StatelessWidget {
//   final AddressModel? selectedAddress;
//   const CartScreen1({super.key, this.selectedAddress});

//   @override
//   Widget build(BuildContext context) {
//     log('cart screen 1');
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Cart'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Cart Items:',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'Review your selections before checkout',
//               style: TextStyle(fontSize: 14),
//             ),
//             const SizedBox(height: 300),
//             // Check if selectedAddress is passed
//             if (selectedAddress != null)
//               Text(
//                 'Selected Address: ${selectedAddress!.addresseeName}',
//                 style: const TextStyle(fontSize: 16),
//               ),
//             const SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (selectedAddress != null) {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const UserAddress(),
//                     ));
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   fixedSize: const Size(400, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   backgroundColor: Colors.green[400],
//                 ),
//                 child: const Text(
//                   'Select Address',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
