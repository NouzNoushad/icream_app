import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/icream_auth/icream_login.dart';
import '../utils/constants.dart';

class ProfileProvider extends ChangeNotifier {
  String? profileName = '';
  String? profileEmail = '';

  getUserProfileDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    profileName = sharedPreferences.getString(nameKey);
    profileEmail = sharedPreferences.getString(emailKey);
    print('//////////==>>>>>>>>>>>>>> name: $profileName');
    notifyListeners();
  }

  logoutUser(context) async {
    var navigator = Navigator.of(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    sharedPreferences.remove(nameKey);
    sharedPreferences.remove(emailKey);
    sharedPreferences.remove(locationKey);
    navigator.pushReplacement(
        MaterialPageRoute(builder: (context) => const ICreamLogin()));
  }
}
