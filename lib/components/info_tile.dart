import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget infoTile(IconData icon, String label, String value) {
  return Column(
    children: [
      Icon(
        icon,
        color: Colors.white,
        size: 20.sp, // responsive icon size
      ),
      SizedBox(height: 4.h), // responsive spacing

      // Value text
      Text(
        value,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14.sp, // responsive font
        ),
      ),

      // Label text
      Text(
        label,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 12.sp, // responsive font
        ),
      ),
    ],
  );
}
