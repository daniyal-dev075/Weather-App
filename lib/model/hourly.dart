class Hourly {
  List<String> time;
  List<double> temperature2m;
  List<int> relativeHumidity2m;
  List<double> precipitation;
  List<double> rain;
  List<double> showers;
  List<double> windSpeed10m;
  List<int> windDirection10m;

  Hourly({
    required this.time,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.precipitation,
    required this.rain,
    required this.showers,
    required this.windSpeed10m,
    required this.windDirection10m,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
      time: List<String>.from(json['time']),
      temperature2m: List<double>.from(json['temperature_2m']),
      relativeHumidity2m: List<int>.from(json['relative_humidity_2m']),
      precipitation: List<double>.from(json['precipitation']),
      rain: List<double>.from(json['rain']),
      showers: List<double>.from(json['showers']),
      windSpeed10m: List<double>.from(json['wind_speed_10m']),
      windDirection10m: List<int>.from(json['wind_direction_10m']),
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
