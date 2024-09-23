import 'package:e_savior/presentation/pages/welcome_screen.dart';
import 'package:e_savior/presentation/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../provider/authentication_provider.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Welcome to the Ambulance Booking App',
      'image': 'assets/image1.png', // Replace with your image path
    },
    {
      'title': 'Get Help Anytime, Anywhere',
      'image': 'assets/image2.png', // Replace with your image path
    },
    {
      'title': 'Fast and Reliable Service',
      'image': 'assets/image3.png', // Replace with your image path
    },
  ];

  @override
  Widget build(BuildContext context) {
    // final authenticationProvider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          // Logo at the top
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Logo(width: 100, height: 100),
          ),
          // Image and text in the center
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   _onboardingData[index]['image']!,
                    //   height: 250,
                    //   fit: BoxFit.cover,
                    // ),
                    Consumer<AuthenticationProvider>(
                      builder: (context, authenticationProvider, child) {
                        return authenticationProvider.isLoggedIn
                            ? Text(
                                'Logged in as: ${authenticationProvider.user?.email}')
                            : Text('Not logged in');
                      },
                    ),
                    // Text(authenticationProvider.isLoggedIn ? 'Logged in' : 'Not logged in'),
                    // Text(context.watch<AuthenticationProvider>().isLoggedIn ? 'Logged in' : 'Not logged in'),
                    const SizedBox(height: 20),
                    Text(
                      _onboardingData[index]['title']!,
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),
          // Indicators and buttons at the bottom
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  // Navigate to the home screen or next screen
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(seconds: 1),
                      child: WelcomeScreen(),
                    ),
                  );
                },
                child: Text(
                  'Skip',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Row(
                children: List.generate(
                  _onboardingData.length,
                  (index) => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: 10,
                    width: _currentPage == index ? 25 : 10,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_currentPage < _onboardingData.length - 1) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  } else {
                    // Navigate to the home screen or next screen
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(seconds: 1),
                        child: WelcomeScreen(),
                      ),
                    );
                  }
                },
                child: Text(
                    _currentPage == _onboardingData.length - 1
                        ? 'Done'
                        : 'Next',
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
