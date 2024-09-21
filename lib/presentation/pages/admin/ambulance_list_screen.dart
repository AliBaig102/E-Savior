import 'package:e_savior/presentation/pages/admin/add_ambulance_screen.dart';
import 'package:e_savior/presentation/pages/admin/ambulance_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AmbulanceListScreen extends StatelessWidget {
  const AmbulanceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ambulances', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF4CD964),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with actual ambulance count
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.local_hospital,
                color: const Color(0xFF4CD964), size: 36),
            title: Text('Ambulance #${1001 + index}',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            subtitle: Text(
              index % 2 == 0 ? 'Available' : 'On Duty',
              style: GoogleFonts.poppins(
                color: index % 2 == 0 ? Colors.green : Colors.orange,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AmbulanceDetailsScreen(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddAmbulanceScreen(
              details: {"mode": "Create"},
            ),
          ),
        ),
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF4CD964),
      ),
    );
  }
}
