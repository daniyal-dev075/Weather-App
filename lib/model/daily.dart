class Daily {
  List<String> time;
  List<double> temperature2mMax;
  List<double> temperature2mMin;
  List<String> sunrise;
  List<String> sunset;

  Daily({
    required this.time,
    required this.temperature2mMax,
    required this.temperature2mMin,
    required this.sunrise,
    required this.sunset,
  });

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      time: List<String>.from(json['time']),
      temperature2mMax: List<double>.from(json['temperature_2m_max'].map((x) => (x as num).toDouble())),
      temperature2mMin: List<double>.from(json['temperature_2m_min'].map((x) => (x as num).toDouble())),
      sunrise: List<String>.from(json['sunrise']),
      sunset: List<String>.from(json['sunset']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature_2m_max': temperature2mMax,
      'temperature_2m_min': temperature2mMin,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }
}
