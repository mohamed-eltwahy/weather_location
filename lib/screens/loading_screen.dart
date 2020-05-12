import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/screens/home_sacreen.dart';
import 'package:location/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getlocation();
  }

  void getlocation() async {
    var weatherData = await WeatherModel().gellocationweather();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          locationweather: weatherData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SpinKitRipple(
          color: Colors.blue.shade400,
          size: 100,
        ),
      ),
    );
  }
}
