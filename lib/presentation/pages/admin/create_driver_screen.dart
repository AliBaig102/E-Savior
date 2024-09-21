import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateDriverScreen extends StatelessWidget {
  const CreateDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Driver', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF4CD964),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: GoogleFonts.poppins(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: GoogleFonts.poppins(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'License Number',
                labelStyle: GoogleFonts.poppins(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Assign Ambulance',
                labelStyle: GoogleFonts.poppins(),
              ),
              items: ['Ambulance #1001', 'Ambulance #1002', 'Ambulance #1003']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: GoogleFonts.poppins()),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Handle ambulance assignment
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Create driver logic
                Navigator.pop(context);
              },
              child: Text('Create Driver', style: GoogleFonts.poppins()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CD964),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}