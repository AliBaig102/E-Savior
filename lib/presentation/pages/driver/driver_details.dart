import 'package:flutter/material.dart';

class DriverDetailsScreen extends StatelessWidget {
  const DriverDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Details'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://example.com/driver_image.jpg'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Amir Hassan',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Text('New York, United States'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoCard(context, '130+', 'Trips'),
                _buildInfoCard(context, '10', 'Years'),
                _buildInfoCard(context, '4.9', 'Rating'),
              ],
            ),
            const SizedBox(height: 24),
            _buildTabBar(context),
            const SizedBox(height: 16),
            const Text(
              'About',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer...',
            ),
            TextButton(
              onPressed: () {
                // Handle read more
              },
              child: const Text('Read More'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Car Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            _buildCarDetailRow('Car Model', 'Hyundai Verna'),
            _buildCarDetailRow('Car Number', 'GR-678 UVWY'),
            _buildCarDetailRow('Car Color', 'White'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String value, String label) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!, width: 2),
        ),
      ),
      child: Row(
        children: [
          _buildTab(context, 'About', isSelected: true),
          _buildTab(context, 'Review'),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, String label, {bool isSelected = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Theme.of(context).primaryColor : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCarDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}