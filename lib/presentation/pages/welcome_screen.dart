import 'package:e_savior/core/my_assets.dart';
import 'package:e_savior/presentation/pages/login_screen.dart';
import 'package:e_savior/presentation/pages/signup_screen.dart';
import 'package:e_savior/presentation/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Illustration at the top
              Column(
                children: [
                  SvgPicture.asset(
                    MyAssets.signupSvg,
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 40), // Space between the image and buttons
                  Text("Welcome to eSavior!", style: Theme.of(context).textTheme.titleLarge),
                  Text("Let's get started", style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              // Login Button
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to Login Screen
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(seconds: 1),
                            child: LoginScreen(),
                          ),
                        );
                      },
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 16), // Space between buttons
                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to Sign Up Screen
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(seconds: 1),
                            child: SignupScreen(),
                          ),
                        );
                      },
                      child: Text('Sign Up'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 16), // Space between buttons
                  // Login as a Driver Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to Driver Login Screen
                        Navigator.pushNamed(context, '/driverLogin');
                      },
                      child: Text('Login as a Driver'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}