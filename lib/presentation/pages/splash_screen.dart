import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_savior/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'dart:async';

import '../../core/my_assets.dart';
import '../widgets/logo.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late SequenceAnimation sequenceAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    // Initialize the sequence animation
    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
          animatable: Tween<double>(begin: 0.0, end: 1.0),
          from: Duration.zero,
          to: const Duration(seconds: 1),
          tag: "fade",
          curve: Curves.easeIn,
        )
        .addAnimatable(
          animatable: Tween<double>(begin: 0.0, end: 1.0),
          from: const Duration(milliseconds: 500),
          to: const Duration(seconds: 2),
          tag: "scale",
          curve: Curves.easeIn,
        )
        .animate(_controller);

    // Start the animation
    _controller.forward();

    // Navigate to the next screen after 5 seconds
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          duration: const Duration(seconds: 1),
          // child: OnboardingScreen(),
          child: OnboardingScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            FadeTransition(
              opacity: sequenceAnimation['fade']
                  .drive(CurveTween(curve: Curves.elasticInOut)),
              child: ScaleTransition(
                scale: sequenceAnimation['scale']
                    .drive(CurveTween(curve: Curves.elasticInOut)),
                child: const Logo(height: 200, width: 200),
              ),
            ),
            const Spacer(),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Ambulance Booking App',
                  textStyle:Theme.of(context).textTheme.bodyLarge,
                  speed: const Duration(milliseconds: 200),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SpinKitWave(
              color: Colors.yellow,
              size: 30,
              itemCount: 5,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen")),
      body: const Center(child: Text("Welcome to the Home Screen!")),
    );
  }
}
