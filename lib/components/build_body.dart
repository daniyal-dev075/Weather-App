import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/components/section_title.dart';
import 'package:weather_app/components/stat_card.dart';

import '../model/WeatherModel.dart';
import 'daily_card.dart';

import 'hourly_card.dart';

Widget buildBody(WeatherModel weather, List<int> remainingTodayIndices, double currentPrecip) {
  return SingleChildScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    child: Column(
      children: [
        sectionTitle("Today"),
        SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: remainingTodayIndices.length,
            itemBuilder: (context, index) {
              final i = remainingTodayIndices[index];
              return hourlyCard(
                weather.hourly.temperature2m[i],
                weather.hourly.time[i],
                weather.hourly.rain[i],
                weather.hourly.showers[i],
              );
            },
          ),
        ),
        sectionTitle("Next 7 Days"),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: List.generate(
              weather.daily.time.length,
                  (index) => dailyCard(
                weather.daily.time[index],
                weather.daily.temperature2mMax[index],
                weather.daily.temperature2mMin[index],
              ),
            ),
          ),
        ),
        sectionTitle("Weather Conditions"),
        Row(
          children: [
            Expanded(
              child: statCard(
                "Precipitation",
                "${currentPrecip.toStringAsFixed(1)} mm",
                icon: Icons.water_drop,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: statCard(
                "Humidity",
                "${weather.current.relativeHumidity2m}%",
                icon: Icons.water_drop,
                color: Colors.blue,
              ),
            ),
            Expanded(
              child: statCard(
                "Sunrise / Sunset",
                "${weather.daily.sunrise[0].substring(11, 16)} / ${weather.daily.sunset[0].substring(11, 16)}",
                icon: Icons.wb_twilight,
                color: Colors.amber.shade600,
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
      ],
    ),
  );
}