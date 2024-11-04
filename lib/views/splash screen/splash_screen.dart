// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../bottom bar/bottom_bar.dart';
// import '../login/login_screen.dart';
// import '../start/start_page.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     checkLoginStatus();
//   }

//   Future<void> checkLoginStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

//     if (isLoggedIn) {
//       Get.offAll(() => const BottomBar());
//       // Navigator.of(context).pushReplacement(
//       //   MaterialPageRoute(builder: (context) => const BottomBar()),
//       // );
//     } else {
//       // Navigator.of(context).pushReplacement(
//       //   MaterialPageRoute(builder: (context) => const LoginScreen()),
//       // );
//       Get.offAll(() => const LoginScreen());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(const Duration(seconds: 4), () {
//       // Navigator.of(context).pushReplacement(
//       //   MaterialPageRoute(
//       //     builder: (context) => const StartPage(),
//       //   ),
//       // );
//        Get.offAll(() => const StartPage());
//     });

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             alignment: Alignment.center,
//             height: 200,
//             child: Image.asset(
//               'assets/images/Screenshot 2024-09-13 194838 1.png',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bottom bar/bottom_bar.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), checkLoginStatus);
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Get.offAll(() => const BottomBar()); 
    } else {
      Get.offAll(() =>
          const LoginScreen()); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 200,
            child: Image.asset(
              'assets/images/Screenshot 2024-09-13 194838 1.png',
            ),
          ),
        ],
      ),
    );
  }
}
