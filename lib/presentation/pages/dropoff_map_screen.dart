import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import '../provider/emergency_provider.dart';

import '../../core/my_colors.dart';
import 'confrim_map_screen.dart'; // Adjust based on your project structure

class DropOffMapScreen extends StatefulWidget {
  @override
  _DropOffMapScreenState createState() => _DropOffMapScreenState();
}

class _DropOffMapScreenState extends State<DropOffMapScreen> {
  GoogleMapController? _mapController;
  LatLng _pickedLocation = LatLng(0, 0);
  final String _apiKey = 'AIzaSyDGFbuRBGsEmSKFvLlQ_yEqJRf-inXF4lY'; // Replace with your Google API key

  Marker? _dropOffMarker;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Get the pickup location from the provider
    EmergencyProvider provider = Provider.of<EmergencyProvider>(context, listen: false);
    _pickedLocation = LatLng(provider.pickupLatitude!, provider.pickupLongitude!);
    _dropOffMarker = Marker(
      markerId: MarkerId('pickupLocation'),
      position: _pickedLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: 'Pickup Location', snippet: provider.pickupAddress),
    );
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$_apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      String address = data['results'][0]['formatted_address'];
      Provider.of<EmergencyProvider>(context, listen: false).updateDropoffLocation(
        address,
        position.latitude,
        position.longitude,
      );
    }
  }

  Future<void> _moveToSelectedLocation(LatLng newLocation, String address) async {
    _mapController?.animateCamera(CameraUpdate.newLatLng(newLocation));
    setState(() {
      _pickedLocation = newLocation;
      _dropOffMarker = Marker(
        markerId: const MarkerId('dropOffLocation'),
        position: _pickedLocation,
        icon: BitmapDescriptor.defaultMarker,
      );
    });

    // Update location in provider
    Provider.of<EmergencyProvider>(context, listen: false).updateDropoffLocation(
      address,
      newLocation.latitude,
      newLocation.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _pickedLocation,
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            markers: {
              if (_dropOffMarker != null) _dropOffMarker!,
            },
            onCameraMove: (CameraPosition position) {
              setState(() {
                _pickedLocation = position.target;
                _getAddressFromLatLng(_pickedLocation);
              });
            },
          ),
          Positioned(
            top: 50,
            left: 15,
            right: 15,
            child: _buildGoogleSearchWidget(),
          ),
          Positioned(
            bottom: 0,
            left: 15,
            right: 15,
            child: Column(
              children: [
                _buildBottomCards(),
                const SizedBox(height: 10),
                _buildLocationInfo(),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 50,
            left: MediaQuery.of(context).size.width / 2 - 25,
            child: Center(
              child: Icon(Icons.location_on, color: MyColors.primaryColor(context), size: 50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleSearchWidget() {
    return GooglePlaceAutoCompleteTextField(
      textEditingController: _searchController,
      googleAPIKey: _apiKey,
      inputDecoration: InputDecoration(
        hintText: 'Search Drop-off Location',
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      debounceTime: 600,
      countries: const ['PK'], // Set your preferred country
      isLatLngRequired: true,
      getPlaceDetailWithLatLng: (prediction) {
        _moveToSelectedLocation(
          LatLng(double.parse(prediction.lat!), double.parse(prediction.lng!)),
          prediction.description!,
        );
      },
      itemClick: (prediction) {
        _moveToSelectedLocation(
          LatLng(double.parse(prediction.lat!), double.parse(prediction.lng!)),
          prediction.description!,
        );
      },
    );
  }

  Widget _buildBottomCards() {
    return Consumer<EmergencyProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: ConfirmMapScreen(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text('Confirm Drop Off', style: TextStyle(fontSize: 20)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLocationInfo() {
    return Consumer<EmergencyProvider>(
      builder: (context, provider, child) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Drop-off Location:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(provider.dropoffAddress, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        );
      },
    );
  }
}