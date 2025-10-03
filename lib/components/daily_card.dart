import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget dailyCard(String day, double max, double min) {
  return Column(
    children: [
      ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        leading: Icon(CupertinoIcons.thermometer_sun, color: Colors.red),
        title: Text(
          day,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        trailing: Text(
          "$max° / $min°",
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
        ),
      ),
      Divider(
        indent: 30,
        endIndent: 30,
        color: Colors.grey.shade500,
        thickness: 1,
        height: 4.h,
      ),
    ],
  );
}
