import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget statCard(String title, String value,
    {required IconData icon, required Color color}) {
  return Container(
    margin: EdgeInsets.all(8.w),
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
          size: 28.sp,
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
