import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_savior/data/datasource/user/user_service.dart';
import 'package:e_savior/data/models/users/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:page_transition/page_transition.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../core/my_assets.dart';
import '../../core/my_colors.dart';
import '../../data/datasource/auth/auth_service.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  AuthService authService = AuthService();
  UserService userService = UserService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      final User? userData = await authService.signUp(
          _emailController.text, _passwordController.text);
      if (userData != null) {
        UserModel user = UserModel(
            userId: userData.uid,
            email: _emailController.text,
            username: _usernameController.text,
            authId: userData.uid,
            createdAt: Timestamp.now(),
            updatedAt: Timestamp.now());
        await userService.addUser(user);
        showTopSnackBar(
          snackBarPosition: SnackBarPosition.bottom,
          Overlay.of(context),
          const CustomSnackBar.success(
            message: "You have successfully signed up! You can now log in.",
          ),
        );
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: LoginScreen(),
          ),
        );
      }

      // Handle signup logic here
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Signing up...')),
      // );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo or illustration placeholder
                Container(
                  height: 180,
                  width: double.infinity,
                  child: Center(
                    child: SvgPicture.asset(
                      MyAssets.signupSvg,
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // Title
                Text(
                  'Sign Up',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: MyColors.primaryColor(context),
                  ),
                ),
                SizedBox(height: 10),

                // Subtitle
                Text(
                  'Create an account to get started.',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 20),

                // Username field
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: MyColors.bgSecondaryColor(context),
                    hintText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: MyColors.primaryColor(context),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Email field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: MyColors.bgSecondaryColor(context),
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: MyColors.primaryColor(context),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Password field with toggle
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: MyColors.bgSecondaryColor(context),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: MyColors.primaryColor(context),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: MyColors.primaryColor(context),
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Confirm Password field with toggle
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: MyColors.bgSecondaryColor(context),
                    hintText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: MyColors.primaryColor(context),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: MyColors.primaryColor(context),
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Sign Up button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primaryColor(context),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text('OR'),
                SizedBox(height: 15),
// Login with Google button
                ElevatedButton(
                  onPressed: () {
                    // Handle Google login
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.accentColor(context),
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Iconify(Mdi.google, color: MyColors.textColor(context)),
                      SizedBox(width: 10),
                      Text(
                        'Signup with Google',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: MyColors.textColor(context),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                // Login link
                GestureDetector(
                  onTap: () {
                    // Navigate to login page
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(seconds: 1),
                        child: LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: MyColors.textColor(context),
                      decoration: TextDecoration.underline,
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
}
