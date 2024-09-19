import 'package:flutter/material.dart';
import 'package:myapp/car/plan_your_ride_screen.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background map view (you would use your own map package here)
          Container(
            color: Colors.grey[300], // Placeholder color for the map
            child: Center(child: Text('Map goes here', style: theme.textTheme.bodyLarge)),
          ),

          // Profile picture at the top-left
          const Positioned(
            top: 40,
            left: 20,
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/profile_picture.png'), // Replace with your asset
            ),
          ),

          // Floating cars icons
          const Positioned(
            top: 100,
            left: 80,
            child: Icon(Icons.directions_car, color: Colors.black, size: 32),
          ),
          const Positioned(
            top: 150,
            left: 200,
            child: Icon(Icons.directions_car, color: Colors.black, size: 32),
          ),
          const Positioned(
            top: 180,
            left: 120,
            child: Icon(Icons.directions_car, color: Colors.black, size: 32),
          ),

          // Destination selection panel at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Where To?',
                        style: theme.textTheme.titleLarge,
                      ),
                      TextButton(
                        onPressed: () {
                          // Show the allow location popup
                          _showAllowLocationPopup(context);
                        },
                        child: Text(
                          'Customize',
                          style: theme.textTheme.bodyLarge?.copyWith(color: theme.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on, color: theme.primaryColor),
                            hintText: 'Enter Destination',
                            contentPadding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildLocationOption(
                        context,
                        icon: Icons.home,
                        label: 'Home',
                        details: '25km, 20min',
                      ),
                      _buildLocationOption(
                        context,
                        icon: Icons.work,
                        label: 'Office',
                        details: '15km, 10min',
                      ),
                      _buildLocationOption(
                        context,
                        icon: Icons.place,
                        label: 'Destination',
                        details: 'Enter Destination',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationOption(BuildContext context, {required IconData icon, required String label, required String details}) {
    final theme = Theme.of(context);

    return Column(
      children: [
        CircleAvatar(
          backgroundColor: theme.primaryColor.withOpacity(0.1),
          child: Icon(icon, color: theme.primaryColor),
        ),
        const SizedBox(height: 8),
        Text(label, style: theme.textTheme.titleSmall),
        const SizedBox(height: 4),
        Text(details, style: theme.textTheme.bodySmall),
      ],
    );
  }

  // Function to show the popup
  void _showAllowLocationPopup(BuildContext context) {
  final theme = Theme.of(context);

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Allow Your Location',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Lorem Ipsum is simply dummy text of the Lorem Ipsum has been the industry\'s',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the popup
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PlanYourRideScreen()),
                );
              },
              child: const Text('Ok, sure'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the popup
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PlanYourRideScreen()),
                );
              },
              child: const Text('Not Now'),
            ),
          ],
        ),
      );
    },
  );
}

}
