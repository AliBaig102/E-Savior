import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AmbulanceBookingScreen extends StatefulWidget {
  const AmbulanceBookingScreen({super.key});

  @override
  State<AmbulanceBookingScreen> createState() => _AmbulanceBookingScreenState();
}

class _AmbulanceBookingScreenState extends State<AmbulanceBookingScreen> {
  String pickupLocation = "Fetching location..."; // Default pickup location
  String? selectedHospital;
  String selectedAmbulanceType = "Basic"; // Default ambulance type

  final List<String> hospitals = [
    "City Hospital",
    "General Hospital",
    "Health Center",
  ];

  final List<String> ambulanceTypes = [
    "Basic",
    "Advanced",
    "Pediatric",
  ];

  final TextEditingController pickupController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      setState(() {
        pickupLocation = "${placemarks.first.name}, ${placemarks.first.locality}";
        pickupController.text = pickupLocation; // Set default pickup location
      });
    }
  }

  void _onNext() {
    // Handle the Next button action
    print("Pickup: ${pickupController.text}");
    print("Hospital: $selectedHospital");
    print("Ambulance Type: $selectedAmbulanceType");
    // Navigate to the next screen or perform any action
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Pickup and Hospital'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: pickupController,
              decoration: InputDecoration(
                labelText: 'Pickup Location',
                border: OutlineInputBorder(),
                hintText: 'Enter pickup location',
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedHospital,
              hint: Text('Select Hospital'),
              items: hospitals.map((hospital) {
                return DropdownMenuItem<String>(
                  value: hospital,
                  child: Text(hospital),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedHospital = value;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedAmbulanceType,
              items: ambulanceTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedAmbulanceType = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Ambulance Type',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onNext,
              child: Text('Next'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}