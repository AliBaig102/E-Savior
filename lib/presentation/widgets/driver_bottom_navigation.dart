import 'package:e_savior/presentation/pages/driver/diver_profile-screen.dart';
import 'package:e_savior/presentation/pages/driver/driver_home_screen.dart';
import 'package:e_savior/presentation/pages/driver/trip_history_screen.dart';
import 'package:flutter/material.dart';

class DriverBottomNavigation extends StatelessWidget {
  const DriverBottomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.home, color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DriverHomeScreen(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.history, color: Colors.grey),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TripsHistoryScreen(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.person, color: Colors.grey),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DriverProfileScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
