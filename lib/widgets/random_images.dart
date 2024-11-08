import 'dart:math';

class RandomImages {
  
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
}