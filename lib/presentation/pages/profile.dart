import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_picture.png'),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'John Doe',
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'johndoe@example.com',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Booking History'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Implement booking history
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Implement settings
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help & Support'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Implement help & support
              },
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                child: Text('Log Out'),
                onPressed: () {
                  // TODO: Implement log out functionality
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}