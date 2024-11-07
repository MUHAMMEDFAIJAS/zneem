

// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import '../../controller/address_controller.dart';
// import '../../controller/cart_controller.dart'; 
// import '../../model/address model/address_model.dart';
// import '../add userpage/add_user_address.dart';
// import '../cart screen/cart_screen.dart';

// class DetailsPage extends StatefulWidget {
//   final String categoryName;
//   final String description;
//   final String imageUrl;
//   final int companyId;
//   final int productId;

//   const DetailsPage({
//     super.key,
//     required this.categoryName,
//     required this.description,
//     required this.imageUrl,
//     required this.companyId,
//     required this.productId,
//   });

//   @override
//   DetailsPageState createState() => DetailsPageState();
// }

// class DetailsPageState extends State<DetailsPage> {
//   final AddressController addressController = Get.put(AddressController());
//   final CartController cartController =
//       Get.put(CartController()); 
//   AddressModel? selectedAddress;

//   Future<void> _addToCart(BuildContext context) async {
//     if (selectedAddress == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please select an address.")),
//       );
//       return;
//     }

//     await cartController.addToCart(
//       widget.productId,
//       selectedAddress!.phoneNumber,
//       selectedAddress!,
//     );

//     Get.to(CartScreen(selectedAddress: selectedAddress!));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Gap(100),
//             SizedBox(
//               height: 400,
//               width: 400,
//               child: Image.network(widget.imageUrl, fit: BoxFit.cover),
//             ),
//             const Gap(8),
//             Text(
//               widget.categoryName,
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const Gap(4),
//             Text(widget.description),
//             const Gap(8),
//             const Text(
//               'Select Address',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Obx(() {
//               if (addressController.isLoading.value) {
//                 return const CircularProgressIndicator();
//               }

//               return DropdownButton<AddressModel>(
//                 value: selectedAddress,
//                 hint: const Text('Select Address'),
//                 items: addressController.addresses.map((address) {
//                   return DropdownMenuItem<AddressModel>(
//                     value: address,
//                     child: Text(address.addresseeName),
//                   );
//                 }).toList(),
//                 onChanged: (AddressModel? value) {
//                   setState(() {
//                     selectedAddress = value;
//                   });
//                 },
//               );
//             }),
//             const Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => _addToCart(context),
//                   style: ElevatedButton.styleFrom(
//                     fixedSize: const Size(180, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     backgroundColor: Colors.green[400],
//                   ),
//                   child: const Text('Add to Cart'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Get.to(const AddUserAddressPage());
//                   },
//                   style: ElevatedButton.styleFrom(
//                     fixedSize: const Size(180, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     backgroundColor: Colors.green[400],
//                   ),
//                   child: const Text('Add Address'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
