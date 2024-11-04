// // ignore_for_file: avoid_unnecessary_containers

// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:zneempharmacy/views/login/login_screen.dart';
// import 'package:zneempharmacy/views/signup/signup_screen.dart';

// class GetStartPage extends StatefulWidget {
//   const GetStartPage({super.key});

//   @override
//   State<GetStartPage> createState() => _GetStartPageState();
// }

// class _GetStartPageState extends State<GetStartPage> {
//   final PageController _pageController = PageController();

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: PageView(
//               controller: _pageController,
//               children: [
//                 Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       // ignore: prefer_const_constructors
//                       SizedBox(
//                         height: 160,
//                       ),
//                       Image.asset(
//                           'assets/images/Delivery-man-in-protective-medical-face-mask-with-a-box-in-his-hands-on-transparent-background-PNG 1.png'),
//                       const Gap(30),
//                       const Text(
//                         'Home delivery of medicines',
//                         style: TextStyle(
//                           fontSize: 34,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const Gap(20),
//                       const Text(
//                         'Order any medicine or health product at',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       const Text(
//                         'a discount and have it delivered right to your',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       const Text(
//                         'doorstep',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const Gap(130),
//                       Image.asset('assets/images/smiling-womanlaptop.png'),
//                       const Gap(60),
//                       const Text(
//                         'Know your medicines',
//                         style: TextStyle(
//                             fontSize: 34, fontWeight: FontWeight.bold),
//                       ),
//                       const Gap(20),
//                       const Text(
//                         'Get authentic information on any medicine',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       const Text(
//                         'side effects, safety advice, substitutes and more',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SmoothPageIndicator(
//             controller: _pageController,
//             count: 2,
//             effect: const SlideEffect(
//               activeDotColor: Colors.green,
//               dotHeight: 10,
//               dotWidth: 10,
//               spacing: 10,
//             ),
//           ),
//           const Gap(100),
//           const Column(
//             children: [
//               Text('Get started Login or signup to continue'),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const LoginScreen(),
//                     ));
//                   },
//                   style: ButtonStyle(
//                     fixedSize: const WidgetStatePropertyAll(Size(160, 50)),
//                     shape: WidgetStatePropertyAll(RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(14))),
//                     backgroundColor: const WidgetStatePropertyAll(Colors.green),
//                   ),
//                   child: const Text(
//                     'Login',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 const Gap(40),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const SignupScreen(),
//                     ));
//                   },
//                   style: ButtonStyle(
//                     fixedSize: const WidgetStatePropertyAll(Size(160, 50)),
//                     shape: WidgetStatePropertyAll(RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(14))),
//                     backgroundColor: const WidgetStatePropertyAll(Colors.green),
//                   ),
//                   child: const Text(
//                     'Sign up',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Gap(50)
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zneempharmacy/views/login/login_screen.dart';
import 'package:zneempharmacy/views/signup/signup_screen.dart';

class GetStartPage extends StatefulWidget {
  const GetStartPage({super.key});

  @override
  State<GetStartPage> createState() => _GetStartPageState();
}

class _GetStartPageState extends State<GetStartPage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                // Page 1
                buildPage(
                  'assets/images/Delivery-man-in-protective-medical-face-mask-with-a-box-in-his-hands-on-transparent-background-PNG 1.png',
                  'Home delivery of medicines',
                  'Order any medicine or health product at a discount and have it delivered right to your doorstep.',
                ),
                // Page 2
                buildPage(
                  'assets/images/smiling-womanlaptop.png',
                  'Know your medicines',
                  'Get authentic information on any medicine side effects, safety advice, substitutes and more',
                ),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: _pageController,
            count: 2,
            effect: const SlideEffect(
              activeDotColor: Colors.green,
              dotHeight: 10,
              dotWidth: 10,
              spacing: 10,
            ),
          ),
          const Gap(100),
          const Text('Get started Login or signup to continue'),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const LoginScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(160, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Gap(40),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const SignupScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(160, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const Gap(50),
        ],
      ),
    );
  }

  Widget buildPage(String imagePath, String title, String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 160),
        Image.asset(imagePath),
        const Gap(30),
        Text(
          title,
          style: const TextStyle(fontSize: 34),
          textAlign: TextAlign.center,
        ),
        const Gap(20),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}