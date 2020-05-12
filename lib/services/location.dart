import 'package:geolocator/geolocator.dart';
class Location{
  double latitude,longitude;

   Future <void> getcurrentlocation() async
  {
    try{ Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    latitude=position.latitude;
    longitude=position.longitude;
    print("lat:$latitude");
    print("long:$longitude");
    
    }catch(e)
    {
      print(e.message);
    }
   

  }
}