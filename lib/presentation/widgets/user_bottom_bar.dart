import 'package:flutter/material.dart';

class UserBottomBar extends StatefulWidget {
  const UserBottomBar(
      {super.key, required this.currentIndex, required this.onTap});

  final int currentIndex; // Current selected index
  final Function(int) onTap; // Function to handle taps on BottomNavigationBar

  @override
  _UserBottomBarState createState() => _UserBottomBarState();
}

class _UserBottomBarState extends State<UserBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.currentIndex, // use passed current index
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      onTap:
          widget.onTap, // Call the onTap function passed from the parent widget
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
