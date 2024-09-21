import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AmbulanceDetailsScreen extends StatelessWidget {
  const AmbulanceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // In a real app, you'd fetch the ambulance ID from the route
    // and use it to get the ambulance details from your data source
   
    return Scaffold(
      appBar: AppBar(
        title: Text('Ambulance Details', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF4CD964),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Icon(
                  Icons.local_hospital,
                  size: 100,
                  color: Color(0xFF4CD964),
                ),
              ),
              const SizedBox(height: 24),
              _buildInfoRow('Ambulance Number', 'AMB-'),
              _buildInfoRow('Registration Number', 'REG-'),
              _buildInfoRow('Model', 'Emergency Response Vehicle 2023'),
              _buildInfoRow('Capacity', '2 patients'),
              _buildInfoRow('Status', 'Available'),
              _buildInfoRow('Last Maintenance', '2023-05-15'),
              _buildInfoRow('Next Scheduled Maintenance', '2023-08-15'),
              const SizedBox(height: 24),
              Text(
                'Current Assignment',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Driver: John Doe',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Shift: 08:00 AM - 04:00 PM',
                        style: GoogleFonts.poppins(),
                      ),
                      Text(
                        'Area: Downtown',
                        style: GoogleFonts.poppins(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Recent Trips',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        'Trip #',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        'Date: ',
                        style: GoogleFonts.poppins(),
                      ),
                      trailing: Text(
                        '15 km',
                        style: GoogleFonts.poppins(color: Colors.grey[600]),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to edit ambulance screen
                      },
                      icon: const Icon(Icons.edit),
                      label: Text('Edit', style: GoogleFonts.poppins()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CD964),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Show maintenance log
                      },
                      icon: const Icon(Icons.build),
                      label: Text('Maintenance Log', style: GoogleFonts.poppins()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.poppins(),
            ),
          ),
        ],
      ),
    );
  }
}