import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zneempharmacy/views/cart%20screen/cart_screen.dart';
import 'package:zneempharmacy/views/medicine%20screen/medicine_screen.dart';
import 'package:zneempharmacy/views/profile%20screen/profile_screen.dart';
import '../cart screen/cart_screen_1.dart';
import '../cart screen/user_address.dart';
import '../home screen/home_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentindex = 0;
  List screens = [
    const HomeScreen(),
    MedicineScreen(),
    const CartScreen1(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        elevation: 4,
        currentIndex: currentindex,
        onTap: (newindex) {
          setState(() {
            currentindex = newindex;
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
            label: 'cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.profile_circle),
            label: 'profile',
          )
        ],
      ),
    );
  }
}
