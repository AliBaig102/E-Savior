import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../provider/emergency_provider.dart';

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({Key? key}) : super(key: key);

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  late GoogleMapController _mapController;
  late LatLng _dropOffLocation;
  late LatLng _driverLocation;
  String driverId = '';
  String driverName = '';
  String estimatedArrival = '5 mins'; // Placeholder for estimated time

  @override
  void initState() {
    super.initState();
    final emergencyProvider = Provider.of<EmergencyProvider>(context, listen: false);

    // Get drop-off location
    _dropOffLocation = LatLng(emergencyProvider.dropoffLatitude ?? 0, emergencyProvider.dropoffLongitude ?? 0);

    // Fetch driver details
    driverId = emergencyProvider.driverId!; // Get driver ID from the provider
    _fetchDriverDetails(driverId);
    _listenToDriverLocation(driverId);
  }

  Future<void> _fetchDriverDetails(String driverId) async {
    DocumentSnapshot driverSnapshot = await FirebaseFirestore.instance.collection('drivers').doc(driverId).get();
    if (driverSnapshot.exists) {
      setState(() {
        driverName = driverSnapshot['name'];
        // Assuming initial driver location is stored in the driver document
        _driverLocation = LatLng(driverSnapshot['latitude'], driverSnapshot['longitude']);
      });
    }
  }

  void _listenToDriverLocation(String driverId) {
    // Listen for real-time updates on the driver's location
    FirebaseFirestore.instance.collection('drivers').doc(driverId).snapshots().listen((driverSnapshot) {
      if (driverSnapshot.exists) {
        setState(() {
          _driverLocation = LatLng(driverSnapshot['latitude'], driverSnapshot['longitude']);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: _dropOffLocation,
              zoom: 14,
            ),
            markers: {
              Marker(
                markerId: MarkerId('dropoff'),
                position: _dropOffLocation,
                infoWindow: InfoWindow(title: 'Drop-off Location'),
              ),
              Marker(
                markerId: MarkerId('driver'),
                position: _driverLocation,
                infoWindow: InfoWindow(title: 'Driver Location'),
              ),
            },
            myLocationEnabled: true,
          ),
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: _buildDriverStatusCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverStatusCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Driver is on the way!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text('Driver Name: $driverName'),
          Text('Estimated Arrival: $estimatedArrival'),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.5, // Example progress value (50%)
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          SizedBox(height: 8),
          Text('Tracking Driver Location...'),
        ],
      ),
    );
  }
}