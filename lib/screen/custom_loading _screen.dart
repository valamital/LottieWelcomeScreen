import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingScreen extends StatefulWidget {
  const CustomLoadingScreen({super.key});

  @override
  State<CustomLoadingScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CustomLoadingScreen> {
  late final Future<LottieComposition> _composition;

  @override
  void initState() {
    super.initState();
    _loadLottieAnimation();
  }

  Future<void> _loadLottieAnimation() async {
    _composition = NetworkLottie(
      "https://lottie.host/0ad73d36-6d68-448c-89d7-b9a920dc353b/uVPc78A6Rj.json",
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<LottieComposition>(
              future: _composition,
              builder: (context, snapshot) {
                var composition = snapshot.data;
                if (composition != null) {
                  return Lottie(composition: composition, width: 250, // Set your desired width
                      height: 250);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
