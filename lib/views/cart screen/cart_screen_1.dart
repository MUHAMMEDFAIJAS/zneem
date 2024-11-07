import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zneempharmacy/views/cart%20screen/user_address.dart';

class CartScreen1 extends StatelessWidget {
  const CartScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    log('cart screen 1');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cartsss'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cart Items:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Review your selections before checkout',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 300),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UserAddress(),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(400, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Colors.green[400],
                ),
                child: const Text(
                  'select user',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
