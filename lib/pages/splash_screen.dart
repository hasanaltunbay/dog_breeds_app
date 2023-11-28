import 'package:dog_breeds_app/pages/home_page.dart';
import 'package:dog_breeds_app/service/dog_service.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Map<String, List<String>> dogData;
  late Map<String, String> dogImages;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      dogData = await DogService.fetchDogData();

      dogImages = await DogService.fetchDogImages(dogData);

      await precacheImages();

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(dogImages: dogImages)));

    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> precacheImages() async {
    await Future.forEach(dogImages.values, (imageUrl) async {
      await precacheImage(CachedNetworkImageProvider(imageUrl), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset("assets/dog-photo.png")
          ),
    );
  }
}
