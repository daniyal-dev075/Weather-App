import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget hourlyCard(double temp, String time, double rain, double showers) {
  // Combine rain + showers probability
  final double chanceOfRain = rain + showers;
  final bool willRain = chanceOfRain > 0.0;

  return Container(
    width: 70.w, // responsive width
    margin: EdgeInsets.only(left: 12.w),
    padding: EdgeInsets.all(8.w),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(12.r), // responsive radius
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          willRain ? CupertinoIcons.cloud_rain : Icons.wb_sunny,
          color: willRain ? Colors.blue : Colors.orange,
          size: 22.sp, // responsive icon size
        ),
        SizedBox(height: 6.h),

        Text(
          "${temp.toStringAsFixed(0)}°",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.sp, // responsive font size
          ),
        ),

        // Hour
        Text(
          time.substring(11, 16), // "2025-10-01T14:00" -> "14:00"
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black54,
          ),
        ),

        // Rain % (only if raining)
        if (willRain)
          Text(
            "${(chanceOfRain * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.blueGrey,
            ),
          ),
      ],
    ),
  );
}
