import 'package:flutter/material.dart';
import 'package:myapp/car/car_selection.dart';


class PlanYourRideScreen extends StatefulWidget {
  const PlanYourRideScreen({super.key});

  @override
  _PlanYourRideScreenState createState() => _PlanYourRideScreenState();
}

class _PlanYourRideScreenState extends State<PlanYourRideScreen> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _pickoffController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Plan Your Ride',
          style:
              theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Handle back navigation
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildOptionButton(context,
                    label: 'Pickup Now', icon: Icons.schedule),
                _buildOptionButton(context,
                    label: 'For Me', icon: Icons.person),
              ],
            ),
            const SizedBox(height: 24),
            _buildLocationFields(),
            const SizedBox(height: 32),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text(
                'Saved Places',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing:
                  Icon(Icons.arrow_forward_ios, color: theme.primaryColor),
            ),
            const SizedBox(height: 16),
            _buildSavedPlace(context,
                label: 'Home', address: '521 Thornridge Cir, Syracuse, C...'),
            _buildSavedPlace(context,
                label: 'Home', address: '626 Ryan Park Rdge Cir, Syracuse...'),
            _buildSavedPlace(context,
                label: 'Work', address: '339 North Garden Level'),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context,
      {required String label, required IconData icon}) {
    final theme = Theme.of(context);

    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: theme.primaryColor),
      label: Text(
        label,
        style: theme.textTheme.labelLarge?.copyWith(color: theme.primaryColor),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: theme.primaryColor),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    );
  }

  Widget _buildLocationFields() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLocationInput(
          context,
          controller: _pickupController,
          label: 'Pickup Point',
          hintText: 'Enter pickup location',
        ),
        const SizedBox(height: 16),
        _buildLocationInput(
          context,
          controller: _pickoffController,
          label: 'Pickoff Point',
          hintText: 'Enter dropoff location',
        ),
        const SizedBox(height: 20,),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>  const CarSelectionScreen(),
                          ),
                        );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 20),
          ),
          child: Text(
            "Next",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationInput(BuildContext context,
      {required TextEditingController controller,
      required String label,
      required String hintText}) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.location_on, color: theme.primaryColor),
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSavedPlace(BuildContext context,
      {required String label, required String address}) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: theme.primaryColor.withOpacity(0.1),
            child: Icon(Icons.home, color: theme.primaryColor),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                address,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
