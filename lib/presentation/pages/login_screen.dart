import 'package:e_savior/presentation/provider/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../core/my_assets.dart';
import '../../core/my_colors.dart';
import '../../data/datasource/auth/auth_service.dart';
import '../../data/datasource/user/user_service.dart';
import 'onboarding_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService authService = AuthService();
  UserService userService = UserService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
      // Handle login logic
      String email = _emailController.text;
      String password = _passwordController.text;
      authenticationProvider.login(email, password, context);
      // if (context.read<AuthenticationProvider>().isLoggedIn) {
      //   Navigator.pushReplacement(
      //     context,
      //     PageTransition(
      //       type: PageTransitionType.rightToLeft,
      //       child: OnboardingScreen(),
      //     ),
      //   );
      // }
      // authController.login(email, password);
      //
      // if (authController.isLoggedIn.value) {
      //   // Show success message
      //   showTopSnackBar(
      //     snackBarPosition: SnackBarPosition.bottom,
      //     Overlay.of(context),
      //     const CustomSnackBar.success(
      //       message: "You have successfully logged in!",
      //     ),
      //   );
      //   // Navigate to the OnboardingScreen
      //   Get.off(
      //     () => OnboardingScreen(),
      //     transition: Transition.rightToLeft,
      //   );
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
                    child: SvgPicture.asset(MyAssets.signupSvg),
                  ),
                ),
                SizedBox(height: 15),

                // Title
                Text(
                  'Login',
                  style: TextStyle(
                    color: MyColors.primaryColor(context),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),

                // Subtitle
                Text(
                  'Please Sign in to continue.',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: 20),

                // Email field with validation
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
                    // Simple email validation
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Password field with toggle and validation
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
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Sign In button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _login(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'Sign In',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text('OR'),
                SizedBox(height: 15),

                // Login with Google button
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticationProvider>().googleLogin(context);
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: OnboardingScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.accentColor(context),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Iconify(Mdi.google, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Login with Google',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),

                // Sign Up link
                GestureDetector(
                  onTap: () {
                    // Navigate to sign up page
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(seconds: 1),
                        child: SignupScreen(),
                      ),
                    );
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      "Don't have an account? Sign Up",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: MyColors.textColor(context),
                        decoration: TextDecoration.underline,
                      ),
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
