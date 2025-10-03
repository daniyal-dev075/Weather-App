import 'hourly_units.dart';
import 'hourly.dart';
import 'current.dart';
import 'daily.dart';
import 'daily_units.dart';

class WeatherModel {
  double latitude;
  double longitude;
  double generationtimeMs;
  int utcOffsetSeconds;
  String timezone;
  String timezoneAbbreviation;
  double elevation;
  HourlyUnits hourlyUnits;
  Hourly hourly;
  Current current;
  DailyUnits dailyUnits;
  Daily daily;

  WeatherModel({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.hourlyUnits,
    required this.hourly,
    required this.current,
    required this.dailyUnits,
    required this.daily,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      generationtimeMs: (json['generationtime_ms'] as num).toDouble(),
      utcOffsetSeconds: json['utc_offset_seconds'],
      timezone: json['timezone'],
      timezoneAbbreviation: json['timezone_abbreviation'],
      elevation: (json['elevation'] as num).toDouble(),
      hourlyUnits: HourlyUnits.fromJson(json['hourly_units']),
      hourly: Hourly.fromJson(json['hourly']),
      current: Current.fromJson(json['current']),
      dailyUnits: DailyUnits.fromJson(json['daily_units']),
      daily: Daily.fromJson(json['daily']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'generationtime_ms': generationtimeMs,
      'utc_offset_seconds': utcOffsetSeconds,
      'timezone': timezone,
      'timezone_abbreviation': timezoneAbbreviation,
      'elevation': elevation,
      'hourly_units': hourlyUnits.toJson(),
      'hourly': hourly.toJson(),
      'current': current.toJson(),
      'daily_units': dailyUnits.toJson(),
      'daily': daily.toJson(),
    };
  }
}
