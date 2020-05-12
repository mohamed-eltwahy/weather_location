import 'package:location/services/location.dart';
import 'package:location/services/networking.dart';

const kapiKey = 'b1690fd2ab9d8b89c5d6693604a6ed5f';
const url = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getcityweather(String cityname) async {
    NetworkHelper networkHelper =
        NetworkHelper('$url?q=$cityname&appid=$kapiKey&units=metric');
    var weathreData = await networkHelper.getData();
    return weathreData;
  }

  Future<dynamic> gellocationweather() async {
    Location loc = Location();
    await loc.getcurrentlocation();
    NetworkHelper helper = NetworkHelper(
        '$url?lat=${loc.latitude}&lon=${loc.longitude}&appid=$kapiKey&units=metric');

    var weatherData = await helper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(double temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
