import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:icream/providers/bottom_nav_provider.dart';
import 'package:icream/providers/auth_provider.dart';
import 'package:icream/providers/cart_provider.dart';
import 'package:icream/providers/home_provider.dart';
import 'package:icream/providers/location_provider.dart';
import 'package:icream/providers/profile_provider.dart';
import 'package:icream/services/network_service.dart';
import 'package:provider/provider.dart';

import 'providers/category_provider.dart';
import 'screens/icream_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map source = {ConnectivityResult.none: false};
  final NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
  String string = '';

  @override
  void initState() {
    networkConnectivity.initialize();
    networkConnectivity.myStream.listen((event) {
      source = event;
      print('source, $source');

      switch (source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          string =
              source.values.toList()[0] ? 'Mobile: Online' : 'Mobile Offline';
          break;
        case ConnectivityResult.wifi:
          string = source.values.toList()[0] ? 'Wifi: Online' : 'Wifi Offline';
          break;
        case ConnectivityResult.none:
        default:
          string = 'Offline';
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        debugShowCheckedModeBanner: false,
        home: const ICreamSplashScreen(),
      ),
    );
  }
}
