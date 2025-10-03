class Current {
  String time;
  double temperature2m;
  double windSpeed10m;
  double precipitation;
  int relativeHumidity2m;
  int isDay;

  Current({
    required this.time,
    required this.temperature2m,
    required this.windSpeed10m,
    required this.precipitation,
    required this.relativeHumidity2m,
    required this.isDay,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      time: json['time'],
      temperature2m: (json['temperature_2m'] as num).toDouble(),
      windSpeed10m: (json['wind_speed_10m'] as num).toDouble(),
      precipitation: (json['precipitation'] as num).toDouble(),
      relativeHumidity2m: json['relative_humidity_2m'],
      isDay: json['is_day'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature_2m': temperature2m,
      'wind_speed_10m': windSpeed10m,
      'precipitation': precipitation,
      'relative_humidity_2m': relativeHumidity2m,
      'is_day': isDay,
    };
  }
}
