// lib/view_model/home_view_model.dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

import '../model/WeatherModel.dart';
import '../repository/weather_repo.dart';
import '../view_model/services/location_service.dart';
import '../data/response/api_response.dart';
import '../utils/weather_cache.dart';

class HomeViewModel with ChangeNotifier {
  final _myrepo = WeatherRepo();

  ApiResponse<WeatherModel> weatherData = ApiResponse.loading();
  String? locationName;

  // ---------- Precomputed / cached formatting fields ----------
  /// parsed hourly DateTimes (local)
  List<DateTime> hourlyDateTimes = [];

  /// formatted hourly time strings (e.g. "2:00 PM")
  List<String> hourlyTimeStrings = [];

  /// parsed daily DateTimes (local)
  List<DateTime> dailyDateTimes = [];

  /// formatted daily strings (e.g. "Thu, 02 Oct")
  List<String> dailyDateStrings = [];

  /// formatted last-updated time (e.g. "2:00 PM")
  String lastUpdatedFormatted = '';

  // ---------- helpers ----------
  void setWeatherData(ApiResponse<WeatherModel> response) {
    weatherData = response;
    notifyListeners();
  }

  /// called whenever we have a WeatherModel -> prepares parsed dates + strings
  void _prepareFormattedData(WeatherModel w) {
    // use local timezone for display
    final timeFormatter = DateFormat('h:mm a'); // 12hr format with AM/PM
    final dateFormatter = DateFormat('EEE, dd MMM'); // e.g. "Thu, 02 Oct"

    // Hourly times (safe parse)
    hourlyDateTimes = w.hourly.time.map((t) {
      try {
        return DateTime.parse(t).toLocal();
      } catch (_) {
        return DateTime.now();
      }
    }).toList();

    hourlyTimeStrings = hourlyDateTimes.map((dt) => timeFormatter.format(dt)).toList();

    // Daily times (API may provide just date 'yyyy-MM-dd' — still parse)
    dailyDateTimes = w.daily.time.map((t) {
      try {
        return DateTime.parse(t).toLocal();
      } catch (_) {
        return DateTime.now();
      }
    }).toList();

    dailyDateStrings = dailyDateTimes.map((dt) => dateFormatter.format(dt)).toList();

    // Last updated (from current time field)
    try {
      final dt = DateTime.parse(w.current.time).toLocal();
      lastUpdatedFormatted = timeFormatter.format(dt);
    } catch (_) {
      lastUpdatedFormatted = '';
    }
  }

  /// Returns list of indices in hourlyDateTimes that belong to *today* and are after now
  List<int> getRemainingTodayIndices() {
    final List<int> indices = [];
    if (hourlyDateTimes.isEmpty) return indices;
    final now = DateTime.now();
    for (var i = 0; i < hourlyDateTimes.length; i++) {
      final dt = hourlyDateTimes[i];
      if (dt.year == now.year && dt.month == now.month && dt.day == now.day && dt.isAfter(now)) {
        indices.add(i);
      }
    }
    return indices;
  }

  /// ---------- Main fetch flow: load cache -> get location -> fetch -> save ----------
  Future<void> FetchWeatherData() async {
    try {
      // 1) Load cached weather (if any) and show it immediately
      final cachedWeather = await WeatherCache.loadWeather();
      if (cachedWeather != null) {
        weatherData = ApiResponse.completed(cachedWeather);
        _prepareFormattedData(cachedWeather);
        notifyListeners();
      }

      // 2) Set status to LOADING before fetching fresh data
      weatherData = ApiResponse.loading(); // <-- always set loading
      notifyListeners();

      // 3) Get location (may throw)
      Position position = await LocationService.getCurrentLocation();
      final lat = position.latitude;
      final lon = position.longitude;

      // 4) Convert to human-readable location
      try {
        final placemarks = await placemarkFromCoordinates(lat, lon);
        if (placemarks.isNotEmpty) {
          final p = placemarks.first;
          locationName = "${p.locality ?? ''}, ${p.country ?? ''}".trim();
        } else {
          locationName = "Unknown Location";
        }
      } catch (_) {
        locationName = "Unknown Location";
      }
      notifyListeners();

      // 5) Fetch fresh data
      final fresh = await _myrepo.weatherDataApi(lat, lon);

      // 6) Prepare formatting and update state + cache
      _prepareFormattedData(fresh);
      weatherData = ApiResponse.completed(fresh);
      await WeatherCache.saveWeather(fresh);
      notifyListeners();
    } catch (e) {
      // If error and we have cached data: keep it. Otherwise expose error.
      if (weatherData.data != null) {
        // keep existing completed state (cached)
      } else {
        setWeatherData(ApiResponse.error(e.toString()));
      }
    }
  }
}
