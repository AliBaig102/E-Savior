import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText = true;
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
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
                  'Sign Up',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Lorem Ipsum is simply dummy text of the Lorem Ipsum has been the industry\'s',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
                const SizedBox(height: 32),
                _buildTextField('Enter User Name ', Icons.person_outline),
                const SizedBox(height: 16),
                _buildTextField('Enter User Gmail', Icons.email_outlined),
                const SizedBox(height: 16),
                _buildTextField('Enter Password', Icons.lock_outline, isPassword: true),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _agreeToTerms,
                      onChanged: (value) {
                        setState(() {
                          _agreeToTerms = value!;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                    Expanded(
                      child: Text(
                        'I agree to the terms & conditions',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  child: const Text('Sign Up', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Handle sign up
                  },
                ),
                const SizedBox(height: 24),
                const Center(child: Text('Or Sign up with')),
                const SizedBox(height: 24),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     _socialButton('assets/google_icon.png'),
                //     const SizedBox(width: 16),
                //     _socialButton('assets/facebook_icon.png'),
                //     const SizedBox(width: 16),
                //     _socialButton('assets/reddit_icon.png'),
                //   ],
                // ),
                const SizedBox(height: 24),
                Center(
                  child: RichText(
                    text: const TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Sign In',
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
      ),
    );
  }

  Widget _buildTextField(String hintText, IconData icon, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword ? _obscureText : false,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.green),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.green),
        ),
        filled: true,
        fillColor: Colors.grey[200],
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