import 'package:flutter/material.dart';

import '../../core/my_assets.dart';

class Logo extends StatelessWidget {
  final double width;
  final double height;
  const Logo({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return  Image.asset(
      isDarkMode ? MyAssets.logoWhite : MyAssets.logoBlack, // Replace with your logo path
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
  }
}
