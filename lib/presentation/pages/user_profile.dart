// import 'package:e_savior/presentation/pages/main_page.dart';
// import 'package:e_savior/presentation/widgets/user_bottom_bar.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  // final title;
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    NetworkImage('https://example.com/user_image.jpg'),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Ayan Zayd',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            _buildProfileOption(context, 'My Profile', Icons.person),
            _buildProfileOption(context, 'Manage Address', Icons.location_on),
            _buildProfileOption(context, 'Notification', Icons.notifications),
            _buildProfileOption(context, 'Payment Methods', Icons.payment),
            _buildProfileOption(context, 'Settings', Icons.settings),
            _buildProfileOption(context, 'Help Center', Icons.help),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
      BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Theme.of(context).primaryColor),
      ),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Handle option tap
      },
    );
  }
}
