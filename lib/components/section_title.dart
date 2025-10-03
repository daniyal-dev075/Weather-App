import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget sectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 16.w, // responsive horizontal padding
      vertical: 12.h,   // responsive vertical padding
    ),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.sp, // responsive font size
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
