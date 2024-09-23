import 'package:e_savior/core/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';

import '../widgets/logo.dart';
import 'pickup_map_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> imgList = [
    'https://cdn.pixabay.com/photo/2015/10/25/08/24/ambulance-1005433_1280.jpg',
    'https://cdn.pixabay.com/photo/2015/10/25/08/24/ambulance-1005433_1280.jpg',
    'https://cdn.pixabay.com/photo/2015/10/25/08/24/ambulance-1005433_1280.jpg',
  ];

  final List<Map<String, dynamic>> pages = [
    {'title': 'Ambulance Booking', 'icon': Icons.local_hospital},
    {'title': 'Planned Booking', 'icon': Icons.calendar_today},
    {'title': 'Feedback Form', 'icon': Icons.feedback},
    {'title': 'About Us', 'icon': Icons.info},
    {'title': 'Contact Us', 'icon': Icons.contact_mail},
    {'title': 'Ambulance Type Info', 'icon': Icons.directions_car},
    {'title': 'Ambulance Costs Info', 'icon': Icons.attach_money},
    {'title': 'Driver List', 'icon': Icons.people},
    {'title': 'Image Gallery', 'icon': Icons.photo},
    {'title': 'Help/FAQ', 'icon': Icons.help},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Logo(width: 50, height: 50),
            SizedBox(width: 10),
            Text('Home Page'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Slider
          CarouselSlider(
            options: CarouselOptions(autoPlay: true, height: 200),
            items: imgList.map((item) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(item),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          // Cards Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: InkWell(
                    onTap: () {
                      // Handle navigation to the respective page here
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child:  PickupMapScreen()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(pages[index]['icon'], size: 50),
                        SizedBox(height: 10),
                        Text(
                          pages[index]['title'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: MyColors.primaryColor(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
