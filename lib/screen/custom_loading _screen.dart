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
      "https://lottie.host/8e87a7a0-57a8-404b-ac5f-5604cbbbfe1e/9yrq9FhjMN.json",
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder<LottieComposition>(
          future: _composition,
          builder: (context, snapshot) {
            var composition = snapshot.data;
            if (composition != null) {
              return Lottie(composition: composition);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
