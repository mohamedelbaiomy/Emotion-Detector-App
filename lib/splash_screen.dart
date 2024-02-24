import 'package:flutter/material.dart';
import 'package:emotion_detector/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Emotion Detector",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "powered by Mohamed Elbaiomy",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 100),
            CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
