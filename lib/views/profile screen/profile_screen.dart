import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zneempharmacy/views/order%20screen/order_screen.dart';

import '../../services/authentication services/auth_service.dart';
import '../login/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    color: Colors.green[300],
                    child: const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Text(
                        'M',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mawjood Pharmacy LLC',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '1234 Street, Block A, Health CityMedVille,\n State 58789',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    _buildListItem(
                      icon: Icons.shopping_bag_outlined,
                      text: 'Orders',
                      onTap: () {
                        Get.to(
                            () => const OrderScreen(phoneNumber: '9946233225'));
                      },
                    ),
                    _buildListItem(
                      icon: Icons.notifications_outlined,
                      text: 'Notifications',
                      onTap: () {},
                    ),
                    _buildListItem(
                      icon: Icons.edit_outlined,
                      text: 'Edit Profile',
                      onTap: () {},
                    ),
                    _buildListItem(
                      icon: Icons.location_on_outlined,
                      text: 'Manage your Address',
                      onTap: () {},
                    ),
                    _buildListItem(
                      icon: Icons.help_outline,
                      text: 'Need Help',
                      onTap: () {},
                    ),
                    _buildListItem(
                      icon: Icons.lock_outline,
                      text: 'Privacy policy',
                      onTap: () {},
                    ),
                    _buildListItem(
                      icon: Icons.article_outlined,
                      text: 'Terms and conditions',
                      onTap: () {},
                    ),
                    _buildListItem(
                      icon: Icons.logout,
                      text: 'Logout',
                      onTap: () async {
                        await _handleLogout(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(
      {required IconData icon,
      required String text,
      required Function() onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title:
          Text(text, style: const TextStyle(fontSize: 16, color: Colors.black)),
      trailing: const Icon(Icons.chevron_right, color: Colors.black),
      onTap: onTap,
    );
  }
}

Future<void> _handleLogout(BuildContext context) async {
  await AuthService().logout();
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => const LoginScreen()),
    (Route<dynamic> route) => false,
  );
}
