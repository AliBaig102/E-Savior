import 'package:e_savior/presentation/pages/admin/create_driver_screen.dart';
import 'package:e_savior/presentation/pages/driver/diver_profile-screen.dart';
import 'package:e_savior/presentation/pages/driver/driver_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DriversListScreen extends StatelessWidget {
  const DriversListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drivers', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF4CD964),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with actual driver count
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage('/placeholder.svg?height=40&width=40'),
            ),
            title: Text('Driver ${index + 1}', style: GoogleFonts.poppins()),
            subtitle: Text('Ambulance #${1000 + index}', style: GoogleFonts.poppins()),
            onTap: () {Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DriverDetailsScreen(),
                      ),
                    );
                    },
                    trailing: ElevatedButton.icon(onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const DriverProfileScreen(),
                        ),
                      );
                    }, label: const Icon(Icons.person_pin_circle,)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreateDriverScreen(),
                      ),
                    ),
        backgroundColor: const Color(0xFF4CD964),
        child: const Icon(Icons.add),
      ),
    );
  }
}