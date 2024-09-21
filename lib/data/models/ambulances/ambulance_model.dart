import 'package:cloud_firestore/cloud_firestore.dart';

class AmbulanceModel {
  String ambulanceId;
  String hospitalName;
  String driverId; // ID of the assigned driver
  String type; // e.g., "Basic Life Support" or "Advanced Life Support"
  String status; // Available/Unavailable
  Timestamp createdAt;
  Timestamp updatedAt;

  AmbulanceModel({
    required this.ambulanceId,
    required this.hospitalName,
    required this.driverId,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert an AmbulanceModel instance to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'hospitalName': hospitalName,
      'driverId': driverId,
      'type': type,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Create an AmbulanceModel instance from a Map
  factory AmbulanceModel.fromMap(Map<String, dynamic> map, String ambulanceId) {
    return AmbulanceModel(
      ambulanceId: ambulanceId,
      hospitalName: map['hospitalName'],
      driverId: map['driverId'] ?? '', // Default to empty string if not provided
      type: map['type'],
      status: map['status'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }
}