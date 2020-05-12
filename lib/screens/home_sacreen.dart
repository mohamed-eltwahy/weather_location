import 'package:flutter/material.dart';
import 'package:location/screens/city_screen.dart';
import 'package:location/utilities/constants.dart';
import 'package:location/services/weather.dart';

class HomeScreen extends StatefulWidget {
  final locationweather;
  HomeScreen({this.locationweather});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherModel _weatherModel = WeatherModel();
  double temprature;
  String weathericon;
  String cityname;
  String weatherMessage;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationweather);
  }

  void updateUI(dynamic weatherDecode) {
    setState(() {
      if (weatherDecode == null) {
        temprature = 0;
        weathericon = 'Not Found';
        cityname = '';
        weatherMessage = 'Unable to get weather data';
        return;
      }
      //double temp;
      temprature = weatherDecode['main']['temp'].toInt();
      // temprature = temp.toInt();
      weatherMessage = _weatherModel.getMessage(temprature);
      var condition = weatherDecode['weather'][0]['id'];
      weathericon = _weatherModel.getWeatherIcon(condition);
      cityname = weatherDecode['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData =
                          await _weatherModel.gellocationweather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedname = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                      if (typedname != null) {
                        var weatherData =
                            await _weatherModel.getcityweather(typedname);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temprature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathericon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  " $weatherMessage in $cityname!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
