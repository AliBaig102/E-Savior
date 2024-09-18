import 'package:e_savior/presentation/pages/user_home_screen.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _obscureText = true;
  var borderr = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: Colors.green),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IconButton(
              //   icon: Icon(Icons.arrow_back, color: Colors.grey[600]),
              //   onPressed: () {
              //     // Handle back button press
              //   },
              // ),
              const SizedBox(height: 24),
              const Text(
                'Sign In',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Lorem Ipsum is simply dummy text of the Lorem Ipsum has been the industry\'s',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
              const SizedBox(height: 32),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Example@gmail.com',
                  prefixIcon:
                      const Icon(Icons.email_outlined, color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.green),
                  ),
                  enabledBorder: borderr,
                  focusedBorder: borderr,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  prefixIcon:
                      const Icon(Icons.lock_outline, color: Colors.green),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(8),
                  //   borderSide: const BorderSide(color: Colors.green),
                  // ),
                  enabledBorder: borderr,
                  focusedBorder: borderr,
                ),
              ),
              const SizedBox(height: 16),
               Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: (){},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.green),
                    ),
                    // 'Forgot Password?',
                    // style: TextStyle(color: Colors.green),
                  )),
              const SizedBox(height: 24),
              ElevatedButton(
                child: const Text('Sign In', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Handle sign in
                },
              ),
              const SizedBox(height: 24),
              const Center(child: Text('Or Sign in with')),
              const SizedBox(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // _socialButton('assets/google_icon.png'),
                  // const SizedBox(width: 16),
                  // _socialButton('assets/facebook_icon.png'),
                  // const SizedBox(width: 16),
                  // _socialButton('assets/reddit_icon.png'),
                ],
              ),
              const Spacer(),
              Center(
                child: RichText(
                  text: const TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String assetName) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: Image.asset(assetName, width: 24, height: 24),
    );
  }
}
