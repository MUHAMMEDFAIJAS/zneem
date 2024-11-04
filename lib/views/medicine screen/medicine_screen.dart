import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zneempharmacy/model/address model/address_model.dart';
import 'package:zneempharmacy/services/address service/address_service.dart';
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
  AddressModel? selectedAddress; // Variable to hold the selected address

  final List<String> fallbackImages = [
    'assets/images/hair accesories.png',
    'assets/images/Delivery-man-in-protective-medical-face-mask-with-a-box-in-his-hands-on-transparent-background-PNG 1.png',
    'assets/images/pharmacy img.png',
    'assets/images/herbal.png',
    'assets/images/cosmetics.png',
  ];

  String getRandomFallbackImage() {
    final randomIndex = Random().nextInt(fallbackImages.length);
    return fallbackImages[randomIndex];
  }

  @override
  void initState() {
    super.initState();
    fetchAddress(); // Call to fetch address in initState
  }

  void fetchAddress() async {
    // Fetching address using a safe async approach
    selectedAddress = widget.selectedAddress ?? await getSavedAddress();
    setState(() {}); // Trigger rebuild after fetching
  }

  Future<AddressModel?> getSavedAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedAddresses = prefs.getStringList('currentAddresses');

    if (savedAddresses != null && savedAddresses.isNotEmpty) {
      // Parse the first address from saved addresses
      return AddressModel.fromJson(json.decode(savedAddresses[0]));
    }
    return null; // Return null if no address is found
  }

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
                        } else if (_categoryController
                            .errorMessage.isNotEmpty) {
                          return Center(
                              child:
                                  Text(_categoryController.errorMessage.value));
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
                                    if (selectedAddress != null) {
                                      Get.to(() => ProductPage(
                                            categoryId: data.id,
                                            selectedAddress: selectedAddress!,
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
                                            getRandomFallbackImage(),
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
