import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../model/WeatherModel.dart';

class WeatherRepo {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<WeatherModel> weatherDataApi(double latitude, double longitude) async {
    try {
      String url =
          'https://api.open-meteo.com/v1/forecast'
          '?latitude=$latitude&longitude=$longitude'
          '&daily=temperature_2m_max,temperature_2m_min,sunrise,sunset'
          '&hourly=temperature_2m,relative_humidity_2m,precipitation,rain,showers,wind_speed_10m,wind_direction_10m'
          '&current=temperature_2m,wind_speed_10m,precipitation,relative_humidity_2m,is_day'
          '&timezone=auto';

      dynamic response = await _apiServices.getApiResponse(url);
      return WeatherModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
