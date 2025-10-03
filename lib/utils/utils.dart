import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

class Utils {
  String getTemperatureCondition(double temp) {
    if (temp <= 5) {
      return "Very Cold";
    } else if (temp > 5 && temp <= 15) {
      return "Cold";
    } else if (temp > 15 && temp <= 25) {
      return "Moderate";
    } else if (temp > 25 && temp <= 30) {
      return "Fair";
    } else if (temp > 30 && temp <= 35) {
      return "Hot";
    } else {
      return "Very Hot";
    }
  }

  Future<String> getPlaceName(double lat, double lon) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return "${place.locality}, ${place.country}";
      }
    } catch (e) {
      print("Error in geocoding: $e");
    }
    return "Unknown Location";
  }
  String formatTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString).toLocal();
      // Format: 2:00 PM
      return DateFormat('h:mm a').format(dateTime);
    } catch (e) {
      return dateTimeString; // fallback if parsing fails
    }
  }

}