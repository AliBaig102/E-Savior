import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAmbulanceScreen extends StatefulWidget {
  final Map details;
  const AddAmbulanceScreen({Key? key, required this.details})
      : super(key: key);

  @override
  _AddAmbulanceScreenState createState() => _AddAmbulanceScreenState();
}

class _AddAmbulanceScreenState extends State<AddAmbulanceScreen> {
  final _formKey = GlobalKey<FormState>();
  String _ambulanceNumber = '';
  String _registrationNumber = '';
  String _model = '';
  String _capacity = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Ambulance', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF4CD964),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Ambulance Number',
                    labelStyle: GoogleFonts.poppins(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an ambulance number';
                    }
                    return null;
                  },
                  onSaved: (value) => _ambulanceNumber = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Registration Number',
                    labelStyle: GoogleFonts.poppins(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a registration number';
                    }
                    return null;
                  },
                  onSaved: (value) => _registrationNumber = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Model',
                    labelStyle: GoogleFonts.poppins(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the ambulance model';
                    }
                    return null;
                  },
                  onSaved: (value) => _model = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Capacity',
                    labelStyle: GoogleFonts.poppins(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the ambulance capacity';
                    }
                    return null;
                  },
                  onSaved: (value) => _capacity = value!,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Add Ambulance', style: GoogleFonts.poppins()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CD964),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Here you would typically send the data to your backend
      // For now, we'll just print the data and navigate back
      print('Ambulance Number: $_ambulanceNumber');
      print('Registration Number: $_registrationNumber');
      print('Model: $_model');
      print('Capacity: $_capacity');
      Navigator.pop(context);
    }
  }
}
