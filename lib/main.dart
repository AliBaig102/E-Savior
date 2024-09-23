import 'package:e_savior/presentation/pages/admin/admin_home_screen.dart';
import 'package:e_savior/presentation/pages/home_screen.dart';
import 'package:e_savior/presentation/pages/login_screen.dart';
import 'package:e_savior/presentation/pages/pickup_map_screen.dart';
import 'package:e_savior/presentation/pages/splash_screen.dart';
import 'package:e_savior/presentation/pages/welcome_screen.dart';
import 'package:e_savior/presentation/provider/emergency_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/my_theme.dart';
import 'firebase_options.dart';
import 'presentation/provider/authentication_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => EmergencyProvider()),
      ],
      child: const MyApp(),
    ),
  );
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Savior',
      theme: MyTheme.light(),
      // Set the light theme
      darkTheme: MyTheme.dark(),
      // Set the dark theme
      themeMode: ThemeMode.light,
      home: SplashScreen(),
    );
  }
}
