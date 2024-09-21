import 'package:e_savior/presentation/pages/admin/admin_home.dart';
import 'package:e_savior/presentation/pages/admin/driver_list_screen.dart';
import 'package:e_savior/presentation/pages/admin/user_list_screen.dart';
// import 'package:e_savior/presentation/pages/driver/driver_details.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class AdminHomeScreen extends StatefulWidget {
  
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int selectedPage=0;
// AdimnHomePage
    List<Widget> page = [const AdimnHomePage(), const UsersListScreen(),const DriversListScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedPage,
        children: page,
      ),

       bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.drive_eta), label: 'Drivers'),
        ],
        // selectedItemColor: const Color(0xFF4CD964),
        onTap: (value) {
          selectedPage=value;
          setState(() {
            
          });
          // if (index == 1) {
          //   Navigator.pushNamed(context, '/users');
          // } else if (index == 2) {
          //   Navigator.pushNamed(context, '/drivers');
          // }
        },
      ),
    ) ;
     }
}