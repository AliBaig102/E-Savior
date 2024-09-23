import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_savior/data/datasource/driver/driver_service.dart';
import 'package:e_savior/data/models/ambulances/ambulance_model.dart';

import '../../models/drivers/driver_model.dart';

class AmbulanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new ambulance
  Future<void> addAmbulance(AmbulanceModel ambulanceData) async {
    try {
      await _firestore.collection('ambulances').add(ambulanceData.toMap());
      print('Ambulance added successfully');
    } catch (e) {
      print('Error adding ambulance: $e');
    }
  }

  // Fetch all ambulances
  Future<List<AmbulanceModel>> getAllAmbulances() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('ambulances').get();
      return snapshot.docs
          .map<AmbulanceModel>((doc) => AmbulanceModel.fromMap(
              doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error fetching all ambulances: $e');
      return [];
    }
  }

  Future<List<AmbulanceModel>> getAllAmbulancesWithDrivers() async {
    try {
      // Fetch the ambulances
      QuerySnapshot ambulanceSnapshot =
          await _firestore.collection('ambulances').get();

      // Create a list of AmbulanceModels
      List<AmbulanceModel> ambulances = ambulanceSnapshot.docs
          .map<AmbulanceModel>((doc) => AmbulanceModel.fromMap(
              doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      // Fetch driver IDs from ambulances and retrieve driver data
      List<String> driverIds =
          ambulances.map((ambulance) => ambulance.driverId).toList();
      for (var i = 0; i < driverIds.length; i++) {
        DriverModel? driver = await DriverService().getDriverById(driverIds[i]);
        if (driver != null) {
          ambulances[i].driver = driver;
        }
      }

      return ambulances;
    } catch (e) {
      print('Error fetching all ambulances: $e');
      return [];
    }
  }

  Future<List<DriverModel>> getDriversByIds(List<String> driverIds) async {
    if (driverIds.isEmpty) return [];

    try {
      QuerySnapshot driverSnapshot = await _firestore
          .collection('drivers')
          .where(FieldPath.documentId, whereIn: driverIds)
          .get();
      return driverSnapshot.docs
          .map<DriverModel>((doc) =>
              DriverModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error fetching drivers: $e');
      return [];
    }
  }

// Fetch a single ambulance by ambulance ID
  Future<Map<String, dynamic>?> getAmbulanceById(String ambulanceId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('ambulances').doc(ambulanceId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        print('Ambulance not found');
      }
    } catch (e) {
      print('Error fetching ambulance: $e');
    }
    return null;
  }

// Update ambulance details
  Future<void> updateAmbulance(String ambulanceId, AmbulanceModel updatedData) async {
    try {
      await _firestore
          .collection('ambulances')
          .doc(ambulanceId)
          .update(updatedData.toMap());
      print('Ambulance updated successfully');
    } catch (e) {
      print('Error updating ambulance: $e');
    }
  }

// Delete an ambulance
  Future<void> deleteAmbulance(String ambulanceId) async {
    try {
      await _firestore.collection('ambulances').doc(ambulanceId).delete();
      print('Ambulance deleted successfully');
    } catch (e) {
      print('Error deleting ambulance: $e');
    }
  }
}
