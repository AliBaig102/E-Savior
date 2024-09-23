import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../provider/emergency_provider.dart';
import '../widgets/ambulance_type_widegit.dart';

class ConfirmMapScreen extends StatefulWidget {
  const ConfirmMapScreen({super.key});

  @override
  _ConfirmMapScreenState createState() => _ConfirmMapScreenState();
}

class _ConfirmMapScreenState extends State<ConfirmMapScreen> {
  Set<Polyline> _polylines = {};
  late LatLng _pickupLocation;
  late LatLng _dropoffLocation;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<EmergencyProvider>(context, listen: false);
    _pickupLocation =
        LatLng(provider.pickupLatitude!, provider.pickupLongitude!);
    _dropoffLocation =
        LatLng(provider.dropoffLatitude!, provider.dropoffLongitude!);
    _getDirections();
  }

  Future<void> _getDirections() async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_pickupLocation.latitude},${_pickupLocation.longitude}&destination=${_dropoffLocation.latitude},${_dropoffLocation.longitude}&key=AIzaSyDGFbuRBGsEmSKFvLlQ_yEqJRf-inXF4lY' // Replace with your key
        );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          _createPolylines(data);
        } else {
          print('Error: ${data['status']}');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _createPolylines(data) {
    List<LatLng> points = [];
    for (var step in data['routes'][0]['legs'][0]['steps']) {
      points.add(LatLng(
        step['end_location']['lat'],
        step['end_location']['lng'],
      ));
    }

    setState(() {
      _polylines.add(Polyline(
        polylineId: PolylineId('route'),
        points: points,
        width: 4,
        color: Colors.blue,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmergencyProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Drop Off'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _pickupLocation,
                zoom: 14,
              ),
              polylines: <Polyline>{
                Polyline(
                  polylineId: PolylineId('route'),
                  points: [
                    _pickupLocation,
                    _dropoffLocation,
                  ],
                  color: Colors.blue,
                  width: 4,
                )
              },
              markers: {
                Marker(
                  markerId: MarkerId('pickup'),
                  position: _pickupLocation,
                  infoWindow: InfoWindow(
                      title: 'Pickup Location',
                      snippet: provider.pickupAddress),
                ),
                Marker(
                  markerId: MarkerId('dropoff'),
                  position: _dropoffLocation,
                  infoWindow: InfoWindow(
                      title: 'Drop-off Location',
                      snippet: provider.dropoffAddress),
                ),
              },
            ),
          ),
          _buildAmbulanceTypes(),
        ],
      ),
    );
  }

  Widget _buildAmbulanceTypes() {
      return const AmbulanceTypesWidget(); // Include the AmbulanceTypesWidget
  }
}
