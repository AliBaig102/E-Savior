import 'package:cloud_firestore/cloud_firestore.dart';

class DriverModel {
  String driverId;
  String name;
  String email;
  String authId; // Unique identifier for authentication
  String? mobileNumber; // Optional
  String? address; // Optional
  String? area; // Optional
  String status; // Default: "Available"
  String? latitude; // Optional
  String? longitude; // Optional
  String? avatarUrl; // Optional URL or path to the driver's avatar image
  Timestamp createdAt;
  Timestamp updatedAt;

  DriverModel({
    required this.driverId,
    required this.name,
    required this.email,
    required this.authId, // Initialize authId
    this.mobileNumber, // Optional
    this.address, // Optional
    this.area, // Optional
    String? status, // Optional with default value
    this.latitude, // Optional
    this.longitude, // Optional
    this.avatarUrl, // Optional
    required this.createdAt,
    required this.updatedAt,
  }) : status = status ?? 'Available'; // Default value for status

  // Convert a DriverModel instance to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'authId': authId,
      'mobileNumber': mobileNumber ?? '',
      'address': address ?? '',
      'area': area ?? '',
      'status': status ?? 'Available',
      'latitude': latitude ?? '',
      'longitude': longitude ?? '',
      'avatarUrl': avatarUrl ?? '',
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Create a DriverModel instance from a Map
  factory DriverModel.fromMap(Map<String, dynamic> map, String driverId) {
    return DriverModel(
      driverId: driverId,
      name: map['name'],
      email: map['email'],
      authId: map['authId'],
      mobileNumber: map['mobileNumber'],
      address: map['address'],
      area: map['area'],
      status: map['status'] ?? 'Available', // Default value if not present
      latitude: map['latitude'],
      longitude: map['longitude'],
      avatarUrl: map['avatarUrl'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }
}