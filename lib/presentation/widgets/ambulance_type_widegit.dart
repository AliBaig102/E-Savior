import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_savior/core/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../pages/booking_details_screen.dart';
import '../provider/emergency_provider.dart';

class AmbulanceTypesWidget extends StatelessWidget {
  const AmbulanceTypesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _fetchAmbulanceTypes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No ambulance types found.'));
        }

        List<String> ambulanceTypes = snapshot.data!;

        return Container(
          padding: EdgeInsets.all(16),
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Ambulance Type:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: ambulanceTypes.map((type) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        _showBookingDialog(context, type);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            _getAmbulanceIcon(type),
                            SizedBox(width: 10),
                            Text(type),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<List<String>> _fetchAmbulanceTypes() async {
    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('ambulances').get();
    final Set<String> uniqueTypes = {};
    for (var doc in snapshot.docs) {
      uniqueTypes.add(doc['type']);
    }
    return uniqueTypes.toList();
  }

  Widget _getAmbulanceIcon(String type) {
    switch (type) {
      case 'Basic':
        return Icon(Icons.local_hospital);
      case 'Advanced':
        return Icon(Icons.medical_services);
      case 'ICU':
        return Icon(Icons.monitor_heart);
      case 'Air Ambulance':
        return Icon(Icons.airplanemode_active);
      default:
        return Icon(Icons.help);
    }
  }

  void _showBookingDialog(BuildContext context, String ambulanceType) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Searching for a Driver'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: MyColors.primaryColor(context),),
              SizedBox(height: 20),
              Text('Please wait while we find a driver for your $ambulanceType request.'),
            ],
          ),
        );
      },
    );

    _searchForDriver(ambulanceType, context).then((driverFound) {
      Navigator.of(context).pop(); // Close the dialog

      if (driverFound) {
        Navigator.of(context).push(
          PageTransition(
            type: PageTransitionType.fade,
            child: BookingDetailsScreen(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('No driver available at the moment. Please try again later.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  Future<bool> _searchForDriver(String ambulanceType, BuildContext context) async {
    await Future.delayed(Duration(seconds: 3)); // Simulate search delay
    bool driverAccepted = await _waitForDriverAcceptance(ambulanceType, context);
    return driverAccepted;
  }

  Future<bool> _waitForDriverAcceptance(String ambulanceType, BuildContext context) async {
    await Future.delayed(const Duration(seconds: 5)); // Simulate driver acceptance time
    String bookingId = await _createBooking(ambulanceType, context);
    await _updateBookingAcceptance(bookingId, context.read<EmergencyProvider>().driverId!); // Replace with actual driver ID
    return true;
  }

  Future<String> _createBooking(String ambulanceType, BuildContext context) async {
    final emergencyProvider = Provider.of<EmergencyProvider>(context, listen: false);
    DocumentReference bookingRef = await FirebaseFirestore.instance.collection('bookings').add({
      'ambulanceType': ambulanceType,
      'timestamp': FieldValue.serverTimestamp(),
      'isEmergency': emergencyProvider.isEmergency,
      'isAccepted': false,
      // Add additional booking details as needed
    });
    return bookingRef.id;
  }

  Future<void> _updateBookingAcceptance(String bookingId, String driverId) async {
    await FirebaseFirestore.instance.collection('bookings').doc(bookingId).update({
      'isAccepted': true,
      'driverId': driverId, // Add the driver's ID to the booking
    });
  }
}