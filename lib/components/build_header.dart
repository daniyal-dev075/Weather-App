import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/WeatherModel.dart';
import '../utils/utils.dart';
import '../view_model/home_view_model.dart';
import 'info_tile.dart';
import '../components/build_loading_ui.dart';
import '../data/response/status.dart';

Widget buildHeader(
    WeatherModel weather,
    HomeViewModel viewModel,
    Color topTextColor,
    Color subTextColor,
    Color fadedTextColor,
    ) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(bottom: 50.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Last updated: ${Utils().formatTime(weather.current.time)}",
              style: TextStyle(color: subTextColor, fontSize: 12.sp),
            ),
            IconButton(
              onPressed: () async {
                await viewModel.FetchWeatherData();
              },
              icon: Icon(Icons.refresh, size: 20.sp, color: subTextColor),
            ),
            Text(
              viewModel.locationName ?? "Fetching location...",
              style: TextStyle(
                fontSize: 27.sp,
                color: topTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "${weather.current.temperature2m.toStringAsFixed(0)}°",
              style: TextStyle(
                fontSize: 70.sp,
                fontWeight: FontWeight.bold,
                color: topTextColor,
              ),
            ),
            Text(
              Utils().getTemperatureCondition(weather.current.temperature2m),
              style: TextStyle(color: topTextColor, fontSize: 20.sp),
            ),
            Text(
              "Feels like ${(weather.current.temperature2m - 2).toStringAsFixed(0)}°",
              style: TextStyle(color: topTextColor, fontSize: 16.sp),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                infoTile(Icons.air, "Wind", "${weather.current.windSpeed10m} km/h"),
                infoTile(Icons.water_drop, "Humidity", "${weather.current.relativeHumidity2m}%"),
              ],
            ),
          ],
        ),
      ),

      // Show loading overlay when status is LOADING
      if (viewModel.weatherData.status == Status.LOADING)
        Container(
          color: Colors.black.withOpacity(0.3),
          child: Center(child: buildLoadingUI()),
        ),
    ],
  );
}
