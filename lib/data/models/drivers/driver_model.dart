import 'package:cloud_firestore/cloud_firestore.dart';

class DriverModel {
  String driverId;
  String name;
  String email;
  String mobileNumber;
  String address;
  String area;
  String idCard;
  String status; // Available/Unavailable
  String assignedAmbulanceId; // ID of assigned ambulance
  String latitude; // Current location latitude
  String longitude; // Current location longitude
  Timestamp createdAt;
  Timestamp updatedAt;

  DriverModel({
    required this.driverId,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.address,
    required this.area,
    required this.idCard,
    required this.status,
    required this.assignedAmbulanceId,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert a DriverModel instance to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'address': address,
      'area': area,
      'idCard': idCard,
      'status': status,
      'assignedAmbulanceId': assignedAmbulanceId,
      'location': {
        'latitude': latitude,
        'longitude': longitude,
      },
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
      mobileNumber: map['mobileNumber'],
      address: map['address'],
      area: map['area'],
      idCard: map['idCard'],
      status: map['status'],
      assignedAmbulanceId: map['assignedAmbulanceId'] ?? '',
      latitude: map['location']['latitude'] ?? '',
      longitude: map['location']['longitude'] ?? '',
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }
}