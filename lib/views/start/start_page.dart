// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:zneempharmacy/views/start/get_startpage.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/421ba76e-d968-4697-a446-d6649d3d4678 1.png',
              fit: BoxFit.contain,
            ),
          ),
          const Gap(20),
          const Text(
            'Medicine at Your Doorstep',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const Text('Anytime',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const Text('From our Pharmacy to Your front Door'),
          const Gap(80),
          ElevatedButton(
            onPressed: () {
          
              Get.to(() => GetStartPage());
            },
           
            style: ElevatedButton.styleFrom(fixedSize: const Size(360, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
            backgroundColor: Colors.green),
            child: const Text(
              'start',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
