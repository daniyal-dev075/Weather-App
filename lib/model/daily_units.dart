class DailyUnits {
  String time;
  String temperature2mMax;
  String temperature2mMin;
  String sunrise;
  String sunset;

  DailyUnits({
    required this.time,
    required this.temperature2mMax,
    required this.temperature2mMin,
    required this.sunrise,
    required this.sunset,
  });

  factory DailyUnits.fromJson(Map<String, dynamic> json) {
    return DailyUnits(
      time: json['time'],
      temperature2mMax: json['temperature_2m_max'],
      temperature2mMin: json['temperature_2m_min'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
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
