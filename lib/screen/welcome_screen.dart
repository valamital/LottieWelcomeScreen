import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  bool isAnimationPlaying = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    /// You can skip this code if you don't want to check reverse, forward, pause, and loop functionality.
    _controller = AnimationController(vsync: this)
      ..value = 0.5
      ..addStatusListener((status) {
        setState(() {
          if (kDebugMode) {
            print("status $status");
          }
        });
      });
  }

  @override
  void dispose() {
    /// You can skip this code if you don't want to check reverse, forward, pause, and loop functionality.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            _buildLottieAnimation(),
            const SizedBox(height: 30.0),
            _buildTitle(),
            const SizedBox(height: 10.0),
            _buildTagline(),
            const SizedBox(height: 20.0),
            _buildAuthButton('Sign In', () {}),
            const SizedBox(height: 20.0),
            _buildAuthButton('Sign Up', () {}),

            /// You can skip this code if you don't want to check reverse, forward, pause, and loop functionality.
            _reverseStopForwardLoop(),
          ],
        ),
      ),
    );
  }

  Widget _buildLottieAnimation() {
    return LottieBuilder.asset(
      "assets/animations/travelling_animation.json",
      frameRate: FrameRate.composition,

      /// You can skip this code if you don't want to check reverse, forward, pause, and loop functionality.
      controller: _controller,
      onLoaded: (composition) {
        setState(() {
          _controller.duration = composition.duration;
        });
      },
    );
  }

  Widget _buildTitle() {
    return const Text(
      "Let's Travel",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: Colors.pink,
      ),
    );
  }

  Widget _buildTagline() {
    return const Text(
      "Navigate the world with TourTonic and turn every destination into an unforgettable experience.",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.black,
      ),
    );
  }

  /// You can skip this code if you don't want to check reverse, forward, pause, and loop functionality.
  Widget _reverseStopForwardLoop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildEventButton(const Icon(Icons.arrow_left), () {
          _controller.reverse();
        }),
        _buildEventButton(const Icon(Icons.pause), () {
          _controller.stop();
        }),
        _buildEventButton(const Icon(Icons.arrow_right), () {
          _controller.forward();
        }),
        _buildEventButton(const Icon(Icons.loop), () {
          var start = 0.1;
          var stop = 0.5;
          _controller.repeat(
            min: start,
            max: stop,
            reverse: true,
            period: _controller.duration! * (stop - start),
          );
        }),
      ],
    );
  }

  Widget _buildEventButton(Icon eventIcon, VoidCallback onPressedCallback) {
    return IconButton(
      icon: eventIcon,
      color: Colors.pink,
      onPressed: onPressedCallback,
    );
  }

  Widget _buildAuthButton(String label, VoidCallback onPressedCallback) {
    return ElevatedButton(
      onPressed: onPressedCallback,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        side: const BorderSide(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 0,
      ),
      child: Text(
        label,
        style: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}
