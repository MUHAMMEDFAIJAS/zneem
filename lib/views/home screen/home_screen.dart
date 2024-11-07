import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:zneempharmacy/views/medicine%20screen/medicine_screen.dart';
import 'package:zneempharmacy/utils/app_color.dart';
import 'package:zneempharmacy/widgets/category.dart';
import '../../model/address model/address_model.dart';
import '../cart screen/user_address.dart';
import '../search screen/search_screen.dart';

class HomeScreen extends StatefulWidget {
  final AddressModel? selectedAddress;
  final ValueChanged<AddressModel?>? onAddressSelected;
  const HomeScreen({super.key, this.selectedAddress, this.onAddressSelected});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AddressModel? currentAddress;

  @override
  void initState() {
    super.initState();
    currentAddress = widget.selectedAddress;

  }

  void selectAddress(AddressModel address) {
    setState(() {
      currentAddress = address;
    });
    widget.onAddressSelected
        ?.call(address); 
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 180,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, left: 15.0, right: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.storefront_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Mawjood pharmacy LLC',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.notifications_none_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          Get.to(() =>
                              SearchScreen(selectedAddress: currentAddress));
                        },
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: 'Search for medicines',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Lottie.asset(
                          'assets/animation/bannerjs.json',
                          fit: BoxFit.fill,
                          height: 175,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Iconsax.category5,
                          size: 20,
                        ),
                        const Gap(5),
                        const Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Get.to(() => MedicineScreen());
                          },
                          child: const Text(
                            'View All',
                            style: TextStyle(
                              color: AppColor.floatingcolor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 160,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CategoryCard().categoryCard(
                            'assets/images/category images.png',
                            'General',
                            () {}),
                        CategoryCard().categoryCard(
                            'assets/images/vitamins.png', 'Vitamins', () {}),
                        CategoryCard().categoryCard(
                            'assets/images/body care.png', 'Body Care', () {}),
                        CategoryCard().categoryCard(
                            'assets/images/body care.png',
                            'Supplements',
                            () {}),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'General Medicines',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'View All',
                            style: TextStyle(
                              color: AppColor.floatingcolor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CategoryCard().generalmedicineCard(
                            'assets/images/pharmacy img.png',
                            'General',
                            '200',
                            () {}),
                        CategoryCard().generalmedicineCard(
                            'assets/images/pharmacy img.png',
                            'Syringe',
                            '400',
                            () {}),
                        CategoryCard().generalmedicineCard(
                            'assets/images/pharmacy img.png',
                            'Bandage Care',
                            '140',
                            () {}),
                        CategoryCard().generalmedicineCard(
                            'assets/images/pharmacy img.png',
                            'Knee Cap',
                            '289',
                            () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const UserAddress())!.then((result) {
            if (result is AddressModel) {
              setState(() {
                currentAddress = result;
                log('Selected Address: ${currentAddress?.addresseeName}, ${currentAddress?.addresseeName}, ${currentAddress?.phoneNumber}');
              });
            }
          });
        },
        backgroundColor: AppColor.floatingcolor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
