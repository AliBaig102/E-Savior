import 'package:flutter/material.dart';

class EmergencyProvider with ChangeNotifier {
  bool _isEmergency = false;
  String _pickupAddress = 'No pickup address selected';
  String _dropoffAddress = 'No dropoff address selected';
  double? _pickupLatitude;
  double? _pickupLongitude;
  double? _dropoffLatitude;
  double? _dropoffLongitude;

  // Driver location properties
  String _driverAddress = 'No driver location selected';
  double? _driverLatitude;
  double? _driverLongitude;

  // Driver ID property
  String? _driverId; // Add driver ID

  bool get isEmergency => _isEmergency;
  String get pickupAddress => _pickupAddress;
  String get dropoffAddress => _dropoffAddress;
  double? get pickupLatitude => _pickupLatitude;
  double? get pickupLongitude => _pickupLongitude;
  double? get dropoffLatitude => _dropoffLatitude;
  double? get dropoffLongitude => _dropoffLongitude;

  // Driver location getters
  String get driverAddress => _driverAddress;
  double? get driverLatitude => _driverLatitude;
  double? get driverLongitude => _driverLongitude;
  String? get driverId => _driverId; // Getter for driver ID

  void toggleEmergency() {
    _isEmergency = !_isEmergency;
    notifyListeners();
  }

  void updatePickupLocation(String address, double latitude, double longitude) {
    _pickupAddress = address;
    _pickupLatitude = latitude;
    _pickupLongitude = longitude;
    notifyListeners();
  }

  void updateDropoffLocation(String address, double latitude, double longitude) {
    _dropoffAddress = address;
    _dropoffLatitude = latitude;
    _dropoffLongitude = longitude;
    notifyListeners();
  }

  // Methods to update driver's location
  void updateDriverLocation(String address, double latitude, double longitude) {
    _driverAddress = address;
    _driverLatitude = latitude;
    _driverLongitude = longitude;
    notifyListeners();
  }

  // Method to update driver ID
  void updateDriverId(String driverId) {
    _driverId = driverId;
    notifyListeners();
  }
}