import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zneempharmacy/views/medicine%20screen/medicine_screen.dart';
import 'package:zneempharmacy/views/profile%20screen/profile_screen.dart';
import '../cart screen/cart_screen_1.dart';
import '../home screen/home_screen.dart';
import '../../model/address model/address_model.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;
  AddressModel? currentAddress; // Store current address here

  @override
  void initState() {
    super.initState();
    // Initially load the HomeScreen and set the address if needed
    currentAddress = null; // Initialize or fetch initial address if needed
  }

  // Update the list of screens with the current address
  List<Widget> get screens => [
        HomeScreen(
          selectedAddress: currentAddress,
          onAddressSelected: (AddressModel? address) {
            setState(() {
              currentAddress = address;
            });
          },
        ),
        MedicineScreen(selectedAddress: currentAddress), // Pass current address
        const CartScreen1(),
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
          setState(() {
            currentIndex = newIndex;
          });
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
