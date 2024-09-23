import 'package:e_savior/data/datasource/driver/driver_service.dart';
import 'package:e_savior/data/datasource/user/user_service.dart';
import 'package:e_savior/data/models/drivers/driver_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../data/datasource/auth/auth_service.dart';
import '../../data/models/users/user_model.dart';
import '../pages/admin/admin_home_screen.dart';
import '../pages/driver/driver_location_map_screen.dart';
import '../pages/home_screen.dart';

class AuthenticationProvider with ChangeNotifier {
  AuthService authService = AuthService();
  UserService userService = UserService();
  DriverService driverService = DriverService();
  UserModel? _user;
  DriverModel? _driver;
  bool _isLoggedIn = false;
  bool _isAdmin = false;
  bool _isDriver = false;

  UserModel? get user => _user;

  DriverModel? get driver => _driver;
  bool get isLoggedIn => _isLoggedIn;

  bool get isAdmin => _isAdmin;

  bool get isDriver => _isDriver;

  // Method to log in the user
  void login(String email, String password, BuildContext context) async {
    // Here you can implement your login logic, e.g., API call
    // _user = UserModel(id: '1', email: email); // Simulated user data
    final User? userData = await authService.login(email, password);
    if (userData != null) {
      showTopSnackBar(
        snackBarPosition: SnackBarPosition.bottom,
        Overlay.of(context),
        const CustomSnackBar.success(
          message: "You have successfully logged in!",
        ),
      );
        // fetch firstore data based on id
      final UserModel? firstoreData=await userService.getUserByAuthUserId(userData.uid);
      if (firstoreData != null) {
        _user = firstoreData;
      }
      if(firstoreData?.role=="admin"){
        _isAdmin = true;
      }
      _isLoggedIn = true;
      notifyListeners(); // Notify listeners about changes
      if (isLoggedIn && !isAdmin) {
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            duration: const Duration(seconds: 1),
            child: HomeScreen(),
          ),
        );
      }else{
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            duration: const Duration(seconds: 1),
            child: const AdminHomeScreen(),
          ),
        );
      }
    }
  }

  // Method to log in the user with Google
  void googleLogin(BuildContext context) async {
    // Call the signInWithGoogle method from the AuthService
    final User? userData = await authService.signInWithGoogle();

    // Check if the user data is not null
    if (userData != null) {
      // Show a success message
      showTopSnackBar(
        snackBarPosition: SnackBarPosition.bottom,
        Overlay.of(context),
        const CustomSnackBar.success(
          message: "You have successfully logged in with Google!",
        ),
      );

      // Convert the user data to a UserModel
      _user = UserModel.fromMap(userData as Map<String, dynamic>, userData.uid);

      // Set the isLoggedIn flag to true
      _isLoggedIn = true;

      // Navigate to the OnboardingScreen
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          duration: const Duration(seconds: 1),
          child: HomeScreen(),
        ),
      );
      // Notify the listeners about the changes
      notifyListeners();
    } else {
      // Show an error message if the user data is null
      showTopSnackBar(
        snackBarPosition: SnackBarPosition.bottom,
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Failed to login with Google!",
        ),
      );
    }
  }

  // Method to log in the driver
  void loginDriver(String email, String password, BuildContext context) async {
    // Call the login method from the AuthService
    final User? userData = await authService.login(email, password);

    // Check if the user data is not null
    if (userData != null) {
      // Show a success message
      showTopSnackBar(
        snackBarPosition: SnackBarPosition.bottom,
        Overlay.of(context),
        const CustomSnackBar.success(
          message: "You have successfully logged in as a driver!",
        ),
      );

      // Fetch firstore data based on id
      final DriverModel? firstoreData=await driverService.getDriverByAuthUserId(userData.uid);
      if (firstoreData != null) {
        _driver = firstoreData;
      }

      // Set the isAdmin flag to false
      _isAdmin = false;

      // Set the isDriver flag to true
      _isDriver = true;

      // Navigate to the OnboardingScreen
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          duration: const Duration(seconds: 1),
          child: DriverLocationMapScreen(),
        ),
      );
      // Notify the listeners about the changes
      notifyListeners();
    } else {
      // Show an error message if the user data is null
      showTopSnackBar(
        snackBarPosition: SnackBarPosition.bottom,
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Failed to login as a driver!",
        ),
      );
    }
  }

  // Method to log out the user
  void logout() {
    _user = null; // Clear user data
    _isLoggedIn = false;
    _isAdmin = false;
    _isDriver = false;
    notifyListeners(); // Notify listeners about changes
  }
}