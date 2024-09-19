import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/book_ride.dart';

class CarSearchingScreen extends StatelessWidget {
  const CarSearchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(40.7128, -74.0060), // New York coordinates
              zoom: 14,
            ),
            markers: {
              const Marker(
                markerId: MarkerId('user_location'),
                position: LatLng(40.7128, -74.0060),
              ),
            },
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    'Searching for nearby cars...',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text('This may take a few seconds'),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // Handle cancel search
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                  TextButton(onPressed: (){
                     Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>  const BookRide(),
                          ),);
                  }, child: const Text("for developer"))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}