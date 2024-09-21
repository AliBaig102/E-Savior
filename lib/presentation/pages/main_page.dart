// import 'package:e_savior/presentation/pages/user/home_screen.dart';
// import 'package:e_savior/presentation/pages/user/user_home_page.dart';
import 'package:e_savior/presentation/pages/user/user_home_page.dart';
import 'package:e_savior/presentation/pages/user_profile.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;
  // userHomePage title =userHomePage(title: "Home",)
  List<Widget> page = const [userHomePage(), UserProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedPage,
        children: page,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        currentIndex: selectedPage, // use passed current index
        // selectedItemColor: Theme.of(context).primaryColor,
        // unselectedItemColor: Colors.grey,
        onTap: (value) {
          selectedPage = value;
          setState(() {});
        }, // Call the onTap function passed from the parent widget
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          // BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
          // BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
