import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zneempharmacy/views/cart%20screen/user_address.dart';
import 'package:zneempharmacy/views/medicine%20screen/medicine_screen.dart';
import 'package:zneempharmacy/views/profile%20screen/profile_screen.dart';
import '../cart screen/cart_screen.dart';
import '../cart screen/cart_screen_1.dart';
import '../home screen/home_screen.dart';
import '../../model/address model/address_model.dart';

class BottomBar extends StatefulWidget {
  final AddressModel? selectedAddress;
  const BottomBar({super.key, this.selectedAddress});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;
  AddressModel? selectedAddress;

  @override
  void initState() {
    super.initState();
    selectedAddress =
        widget.selectedAddress ?? null; // Initialize with passed address
  }

  List<Widget> get screens => [
        HomeScreen(
          selectedAddress: selectedAddress,
        ),
        MedicineScreen(selectedAddress: selectedAddress),
        CartScreen(selectedAddress: selectedAddress), // Directly navigate to CartScreen
        const ProfileScreen()
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        elevation: 4,
        currentIndex: currentIndex,
        onTap: (newIndex) {
          if (newIndex == 2 && selectedAddress == null) {
            Get.to(() => UserAddress())?.then((result) {
              if (result != null && result is AddressModel) {
                setState(() {
                  selectedAddress = result;
                  currentIndex = 2;
                });
              }
            });
          } else {
            setState(() {
              currentIndex = newIndex;
            });
          }
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.hospital),
            label: 'Medicines',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.shopping_bag),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.profile_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
