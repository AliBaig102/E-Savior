// import 'package:e_savior/presentation/pages/driver/driver_details.dart';
import 'package:flutter/material.dart';

class RateDriverScreen extends StatefulWidget {
  const RateDriverScreen({super.key});

  @override
  _RateDriverScreenState createState() => _RateDriverScreenState();
}

class _RateDriverScreenState extends State<RateDriverScreen> {
  int _rating = 0;
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate driver'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage:
                    NetworkImage('https://example.com/driver_image.jpg'),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Amir Hassan',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Center(
              child: Text('Driver'),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Thanks You!',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const Center(
              child: Text('Please rate your trip'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Hey Amir!',
                labelText: 'Write your message here...',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            const Text(
              'Add Tips',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTipButton(1),
                _buildTipButton(2),
                _buildTipButton(3),
                _buildTipButton(4),
              ],
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () {
                  // Handle custom tip amount
                },
                child: const Text('Enter Custom Amount'),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle submit rating and tip

                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (context) => const DriverDetailsScreen(),
                  //   ),
                  // );
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipButton(int amount) {
    return ElevatedButton(
      onPressed: () {
        // Handle tip selection
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: amount == 3 ? Colors.white : Colors.black,
        backgroundColor:
            amount == 3 ? Theme.of(context).primaryColor : Colors.grey[200],
      ),
      child: Text('\$$amount'),
    );
  }
}
