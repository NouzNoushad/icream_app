import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/widgets/dialog_box.dart';
import '../utils/constants.dart';

class LocationProvider extends ChangeNotifier {
  late SharedPreferences sharedPreferences;
  String place = '';

  Future<bool> handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showAlertDialog(
        context: context,
        title: 'Location disable',
        content: 'Location services are disabled. Please enable the services', status: Status.failed,
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showAlertDialog(
          context: context,
          title: 'Permission denied',
          content: 'Location permissions are denied',
          status: Status.failed,
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showAlertDialog(
        context: context,
        title: 'Permission denied forever',
        content: 'Location permissions are permanently denied',
        status: Status.failed,
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition(context) async {
    final hasPermission = await handleLocationPermission(context);
    if (hasPermission) {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        getCurrentAddress(position);
      }).catchError((err) {
        print('current position error, $err');
      });
    } else {
      return;
    }
  }

  getCurrentAddress(Position position) async {
    sharedPreferences = await SharedPreferences.getInstance();
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((placemarks) async {
      var place = placemarks[0];
      if (sharedPreferences.getString(locationKey) == null) {
        await sharedPreferences.setString(locationKey, place.street.toString());
      }
      getPlaceDetails();
    }).catchError((err) {
      print('current place error, $err');
    });
  }

  getPlaceDetails() async {
    sharedPreferences = await SharedPreferences.getInstance();
    place = sharedPreferences.getString(locationKey).toString();
    print('////////////////===========>>>>>>>>>>>>>>>place Stored: $place');
    notifyListeners();
  }
}
