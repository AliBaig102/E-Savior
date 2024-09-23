import 'package:e_savior/presentation/pages/dropoff_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../provider/emergency_provider.dart';

import '../../core/my_colors.dart'; // Adjust based on your project structure

class PickupMapScreen extends StatefulWidget {
  @override
  _PickupMapScreenState createState() => _PickupMapScreenState();
}

class _PickupMapScreenState extends State<PickupMapScreen> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  LatLng _pickedLocation = LatLng(0, 0);
  final String _apiKey = 'AIzaSyDGFbuRBGsEmSKFvLlQ_yEqJRf-inXF4lY'; // Replace with your Google API key

  Marker? _userMarker;
  Marker? _locationMarker;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _pickedLocation = LatLng(position.latitude, position.longitude);
      _userMarker = Marker(
        markerId: MarkerId('userLocation'),
        position: _pickedLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _locationMarker = Marker(
        markerId: MarkerId('pickedLocation'),
        position: _pickedLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      );
    });
    _getAddressFromLatLng(_pickedLocation);
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$_apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      String address = data['results'][0]['formatted_address'];
      Provider.of<EmergencyProvider>(context, listen: false).updatePickupLocation(
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
      _locationMarker = Marker(
        markerId: const MarkerId('pickedLocation'),
        position: _pickedLocation,
        icon: BitmapDescriptor.defaultMarker,
      );
    });
    // Update location in provider
    Provider.of<EmergencyProvider>(context, listen: false).updatePickupLocation(
      address,
      newLocation.latitude,
      newLocation.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _pickedLocation,
              zoom: 14,
            ),
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            markers: {
              _userMarker!,
              if (_locationMarker != null) _locationMarker!,
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
              child: Iconify(Mdi.map_marker, color: MyColors.primaryColor(context), size: 50),
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
        hintText: 'Search Location',
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
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => provider.toggleEmergency(),
                    child: Card(
                      color: provider.isEmergency ? Colors.red[200] : Colors.white,
                      child: ListTile(
                        title: Text('Emergency'),
                        leading: Icon(Icons.warning, color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => provider.toggleEmergency(),
                    child: Card(
                      color: !provider.isEmergency ? Colors.green[200] : Colors.white,
                      child: ListTile(
                        title: Text('Non-Emergency'),
                        leading: Icon(Icons.local_hospital, color: Colors.green),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(child: DropOffMapScreen(), type: PageTransitionType.rightToLeft),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text('Drop Off', style: TextStyle(fontSize: 20)),
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
                Text('Selected Location:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(provider.pickupAddress,maxLines: 1,overflow: TextOverflow.ellipsis,),
              ],
            ),
          ),
        );
      },
    );
  }
}