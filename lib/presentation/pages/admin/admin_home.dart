import 'package:e_savior/presentation/pages/admin/ambulance_list_screen.dart';
import 'package:e_savior/presentation/pages/admin/driver_list_screen.dart';
import 'package:e_savior/presentation/pages/admin/user_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdimnHomePage extends StatelessWidget {
  const AdimnHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF4CD964),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCard(
              context,
              'Users',
              Icons.people,
              () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const UsersListScreen(),
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            _buildCard(
              context,
              'Drivers',
              Icons.drive_eta,
              () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DriversListScreen(),
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            _buildCard(
              context,
              'Ambulance',
              Icons.emergency,
              () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AmbulanceListScreen(),
                      ),
                    ),
            ),
          ],
        ),
      ),
     
    );

  }
  Widget _buildCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 48, color: const Color(0xFF4CD964)),
              const SizedBox(height: 8),
              Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}