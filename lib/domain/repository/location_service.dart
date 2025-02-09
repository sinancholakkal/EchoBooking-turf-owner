
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:nominatim_geocoding/nominatim_geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationRepo {
  static Future<Position> getingPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  static Future<void> openInGoogleMap(String current) async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$current";
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      log("cannot launch");
      
    }
  }

  static Future<Map<String,String>> getStreatNames(double latitude, double longitude) async {
    Coordinate coordinate =
        Coordinate(latitude: latitude, longitude: longitude);
    Geocoding geocoding =
        await NominatimGeocoding.to.reverseGeoCoding(coordinate);
        
        log(geocoding.address.toString());
        print("==============================");
        return {
          "state":geocoding.address.state,
          "country":geocoding.address.country
        };
        
  }

  // static Future<Placemark> getStreatNames(
  //     double latitude, double longitude) async {
  //        print("============================================");
  //   // List<String>latAndLong = current.split(",");
  //   List<Placemark> place = [];
  //   try {
  //     place = await placemarkFromCoordinates(latitude, longitude);
  //     if (place.isNotEmpty) {
  //       print(place[0]);

  //     }
  //   } catch (e) {
  //     log(e.toString() as num);
  //   }
  //   return place[0];
  // }
}
