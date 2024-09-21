import 'package:e_savior/presentation/pages/admin/create_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF4CD964),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with actual user count
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage('/placeholder.svg?height=40&width=40'),
            ),
            title: Text('User ${index + 1}', style: GoogleFonts.poppins()),
            subtitle: Text('user${index + 1}@example.com', style: GoogleFonts.poppins()),
            onTap: () {
              // Navigate to user details
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreateUserScreen(),
                      ),
                    ),
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF4CD964),
      ),
    );
  }
}