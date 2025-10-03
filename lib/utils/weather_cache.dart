import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/WeatherModel.dart';

class WeatherCache {
  static const String _cacheKey = "weather_cache";

  /// Save WeatherModel to cache
  static Future<void> saveWeather(WeatherModel weather) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(weather.toJson());
    await prefs.setString(_cacheKey, jsonString);
  }

  /// Load WeatherModel from cache
  static Future<WeatherModel?> loadWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_cacheKey);
    if (jsonString != null) {
      final jsonData = jsonDecode(jsonString);
      return WeatherModel.fromJson(jsonData);
    }
    return null;
  }

  /// Clear cache
  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
  }
}
