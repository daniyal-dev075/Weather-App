class HourlyUnits {
  String time;
  String temperature2m;
  String relativeHumidity2m;
  String precipitation;
  String rain;
  String showers;
  String windSpeed10m;
  String windDirection10m;

  HourlyUnits({
    required this.time,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.precipitation,
    required this.rain,
    required this.showers,
    required this.windSpeed10m,
    required this.windDirection10m,
  });

  factory HourlyUnits.fromJson(Map<String, dynamic> json) {
    return HourlyUnits(
      time: json['time'],
      temperature2m: json['temperature_2m'],
      relativeHumidity2m: json['relative_humidity_2m'],
      precipitation: json['precipitation'],
      rain: json['rain'],
      showers: json['showers'],
      windSpeed10m: json['wind_speed_10m'],
      windDirection10m: json['wind_direction_10m'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature_2m': temperature2m,
      'relative_humidity_2m': relativeHumidity2m,
      'precipitation': precipitation,
      'rain': rain,
      'showers': showers,
      'wind_speed_10m': windSpeed10m,
      'wind_direction_10m': windDirection10m,
    };
  }
}
