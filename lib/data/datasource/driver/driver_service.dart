import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/drivers/driver_model.dart';

class DriverService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Method to get all drivers
  Future<List<DriverModel?>> getAllDriver() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('drivers').get();
      return snapshot.docs
          .map((doc) => DriverModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error fetching all drivers: $e');
      return [];
    }
  }

  // Method to get a driver by driver ID
  Future<DriverModel?> getDriverById(String driverId) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('drivers').doc(driverId).get();
      if (snapshot.exists) {
        return DriverModel.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id);
      }
    } catch (e) {
      print('Error fetching driver: $e');
    }
    return null;
  }

  // Method to get a driver by auth user ID
  Future<DriverModel?> getDriverByAuthUserId(String authUserId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('drivers')
          .where('authId', isEqualTo: authUserId)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return DriverModel.fromMap(snapshot.docs.first.data() as Map<String, dynamic>, snapshot.docs.first.id);
      }
    } catch (e) {
      print('Error fetching driver: $e');
    }
    return null;
  }
  // Method to add a new driver
  Future<void> addDriver(DriverModel driver) async {
    try {
      await _firestore.collection('drivers').add(driver.toMap());
    } catch (e) {
      print('Error adding driver: $e');
      throw Exception('Failed to add driver: $e');
    }
  }

  // Method to update driver information
  Future<void> updateDriver(DriverModel driver) async {
    try {
      await _firestore.collection('drivers').doc(driver.driverId).update(driver.toMap());
    } catch (e) {
      print('Error updating driver: $e');
      throw Exception('Failed to update driver: $e');
    }
  }

  // Method to delete a driver
  Future<void> deleteDriver(String driverId) async {
    try {
      await _firestore.collection('drivers').doc(driverId).delete();
    } catch (e) {
      print('Error deleting driver: $e');
      throw Exception('Failed to delete driver: $e');
    }
  }
  // Method to add an image (avatar)
  Future<String> addImage(String driverId, String filePath) async {
    try {
      File file = File(filePath);
      String fileName = 'avatars/$driverId/${DateTime.now().millisecondsSinceEpoch}.png';
      UploadTask uploadTask = _storage.ref(fileName).putFile(file);
      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();
      await _firestore.collection('drivers').doc(driverId).update({'avatarUrl': downloadUrl});
      return downloadUrl;
    } catch (e) {
      print('Error adding image: $e');
      throw Exception('Failed to add image: $e');
    }
  }

  // Method to update the driver's image
  Future<String> updateImage(String driverId, String filePath) async {
    try {
      // Optionally delete the old image before uploading a new one
      // You might want to implement a method to get the current avatar URL and delete it here

      return await addImage(driverId, filePath); // Reuse addImage to handle upload
    } catch (e) {
      print('Error updating image: $e');
      throw Exception('Failed to update image: $e');
    }
  }

  // Method to delete the driver's image
  Future<void> deleteImage(String driverId) async {
    try {
      // Retrieve the current avatar URL from Firestore
      DocumentSnapshot snapshot = await _firestore.collection('drivers').doc(driverId).get();
      String? avatarUrl = (snapshot.data() as Map<String, dynamic>)['avatarUrl'];

      if (avatarUrl != null) {
        // Extract the image path from the URL
        String filePath = avatarUrl.split('?')[0]; // Remove query parameters if present
        await _storage.refFromURL(filePath).delete();

        // Optionally remove the avatarUrl from Firestore
        await _firestore.collection('drivers').doc(driverId).update({'avatarUrl': FieldValue.delete()});
      }
    } catch (e) {
      print('Error deleting image: $e');
      throw Exception('Failed to delete image: $e');
    }
  }

  // Method to get the driver's location
  Future<Map<String, String>?> getLocation(String driverId) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('drivers').doc(driverId).get();
      if (snapshot.exists) {
        return {
          'latitude': snapshot.get('latitude'),
          'longitude': snapshot.get('longitude'),
        };
      }
    } catch (e) {
      print('Error getting location: $e');
      throw Exception('Failed to get location: $e');
    }
    return null;
  }

  // Method to set the driver's location
  Future<void> setLocation(String driverId, String latitude, String longitude) async {
    try {
      await _firestore.collection('drivers').doc(driverId).update({
        'latitude': latitude,
        'longitude': longitude,
      });
    } catch (e) {
      print('Error setting location: $e');
      throw Exception('Failed to set location: $e');
    }
  }
}