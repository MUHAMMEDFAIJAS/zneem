import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zneempharmacy/model/address model/address_model.dart';
import 'package:zneempharmacy/widgets/random_images.dart';
import '../../controller/cart_controller.dart';
import '../../controller/category_controller.dart';
import '../product page/product_page.dart';

class MedicineScreen extends StatefulWidget {
  final AddressModel? selectedAddress;

  MedicineScreen({super.key, this.selectedAddress});

  @override
  State<MedicineScreen> createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  final CategoryController _categoryController = Get.put(CategoryController());
  final CartController cartController = Get.put(CartController());
  AddressModel? currentAddress;

  @override
  void initState() {
    super.initState();
    fetchSelectedAddress();
  }

  void fetchSelectedAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? addressJson = prefs.getString('selectedAddress');

    if (addressJson != null) {
      currentAddress = AddressModel.fromJson(json.decode(addressJson));
      print(
          'Fetched Address from SharedPreferences: ${currentAddress?.toJson()}');
    } else {
      currentAddress = widget.selectedAddress;
      print(
          'No address found in SharedPreferences. Using passed address: ${currentAddress?.toJson()}');
    }
    setState(() {});
  }

  // Future<AddressModel?> getSavedAddress() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? savedAddresses = prefs.getStringList('currentAddresses');

  //   if (savedAddresses != null && savedAddresses.isNotEmpty) {
  //     return AddressModel.fromJson(json.decode(savedAddresses[0]));
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(width: double.infinity),
          Card(
            elevation: 5,
            margin: EdgeInsets.zero,
            child: Image.asset(
              'assets/images/medicine screen.png',
              fit: BoxFit.cover,
              height: 240,
              width: double.infinity,
            ),
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              height: MediaQuery.of(context).size.height - 250,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    const Text(
                      'Shop by category',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(5),
                    const Text(
                      'Browse our wide range of medicines',
                      style: TextStyle(fontSize: 15),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Obx(() {
                        if (_categoryController.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 4,
                            childAspectRatio: 2 / 3,
                          ),
                          itemCount: _categoryController.categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = _categoryController.categories[index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (currentAddress != null) {
                                      Get.to(() => ProductPage(
                                            categoryId: data.id,
                                            selectedAddress: currentAddress!,
                                            productId: data.id,
                                          ));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Please select an address first!'),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 4,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        data.imageUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 120,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            RandomImages()
                                                .getRandomFallbackImage(),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: 120,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  data.categoryName,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
