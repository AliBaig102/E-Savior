import 'package:e_savior/data/datasource/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/my_colors.dart';
import '../../../data/datasource/driver/driver_service.dart';
import '../../../data/models/drivers/driver_model.dart';
import '../../widgets/my_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverListScreen extends StatefulWidget {
  const DriverListScreen({super.key});

  @override
  State<DriverListScreen> createState() => _DriverListScreenState();
}

class _DriverListScreenState extends State<DriverListScreen> {
  final DriverService driverService = DriverService();
  final AuthService authService = AuthService();
  List<DriverModel?> drivers = [];
  bool isLoading = true; // Loading state
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController =
      TextEditingController(); // New address controller

  @override
  void initState() {
    super.initState();
    _fetchDrivers(); // Fetch drivers on initialization
  }

  void _fetchDrivers() async {
    setState(() {
      isLoading = true; // Start loading
    });

    drivers = await driverService.getAllDriver(); // Fetch drivers
    setState(() {
      isLoading = false; // Stop loading
    });
  }

  void _deleteDriver(String driverId) {
    driverService.deleteDriver(driverId); // Use service to delete
    _fetchDrivers(); // Refresh the driver list
  }

  void _addDriver() async {
    if (_formKey.currentState!.validate()) {
      User? user = await authService.signUp(
          _emailController.text, _passwordController.text);
      final newDriver = DriverModel(
        driverId: '',
        name: _nameController.text,
        email: _emailController.text,
        area: _areaController.text,
        mobileNumber: _phoneController.text,
        address: _addressController.text,
        authId: user!.uid,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

      driverService.addDriver(newDriver).then((_) {
        _fetchDrivers(); // Refresh after adding
        _clearFields();
        Navigator.of(context).pop(); // Close the dialog
      });
    }
  }

  void _clearFields() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _areaController.clear();
    _phoneController.clear();
    _addressController.clear(); // Clear address field
  }

  void _showAddDriverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Driver'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyInput(
                  controller: _nameController,
                  iconData: Icons.person,
                  hintText: 'Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the driver\'s name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                MyInput(
                  controller: _emailController,
                  iconData: Icons.email,
                  hintText: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                MyInput(
                  controller: _passwordController,
                  iconData: Icons.lock,
                  hintText: 'Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                MyInput(
                  controller: _areaController,
                  iconData: Icons.location_city,
                  hintText: 'Area',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the area';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                MyInput(
                  controller: _phoneController,
                  iconData: Icons.phone,
                  hintText: 'Phone Number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                      return 'Please enter a valid 11-digit phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                MyInput(
                  controller: _addressController, // New address input
                  iconData: Icons.home,
                  hintText: 'Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              onPressed: _addDriver,
              child: const Text('Add Driver'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Drivers'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: MyColors.primaryColor(context)))
          : ListView.builder(
              itemCount: drivers.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.all(8.0),
                  color: MyColors.bgSecondaryColor(context),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/images/avatars/${(index % 5) + 1}.png"),
                    ),
                    title: Text(
                      drivers[index]!.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      '${drivers[index]?.email}\n${drivers[index]?.address}',
                      // Display address
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteDriver(
                          drivers[index]!.driverId), // Use driver ID
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primaryColor(context),
        onPressed: _showAddDriverDialog,
        tooltip: 'Add Driver',
        child: const Icon(Icons.add),
      ),
    );
  }
}
