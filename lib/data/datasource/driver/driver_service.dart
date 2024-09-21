import 'package:cloud_firestore/cloud_firestore.dart';

class AmbulanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new ambulance
  Future<void> addAmbulance(String ambulanceId, Map<String, dynamic> ambulanceData) async {
    try {
      await _firestore.collection('ambulances').doc(ambulanceId).set(ambulanceData);
      print('Ambulance added successfully');
    } catch (e) {
      print('Error adding ambulance: $e');
    }
  }

  // Fetch all ambulances
  Future<List<Map<String, dynamic>>> getAllAmbulances() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('ambulances').get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error fetching all ambulances: $e');
      return [];
    }
  }

  // Fetch a single ambulance by ambulance ID
  Future<Map<String, dynamic>?> getAmbulanceById(String ambulanceId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('ambulances').doc(ambulanceId).get();
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
  Future<void> updateAmbulance(String ambulanceId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('ambulances').doc(ambulanceId).update(updatedData);
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