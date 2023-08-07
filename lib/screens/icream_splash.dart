import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:icream/screens/icream_onboarding/icream_onboarding.dart';
import 'package:icream/utils/colors.dart';
import 'package:lottie/lottie.dart';

class ICreamSplashScreen extends StatefulWidget {
  const ICreamSplashScreen({super.key});

  @override
  State<ICreamSplashScreen> createState() => _ICreamSplashScreenState();
}

class _ICreamSplashScreenState extends State<ICreamSplashScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const ICreamOnboarding())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        body: Material(
          color: const Color.fromARGB(255, 255, 251, 200),
          child: Center(
            child: Column(
              children: [
                Lottie.asset(
                  'assets/lottie/ice-cream.json',
                ),
                Image.asset(
                  'assets/images/i1.png',
                  width: size.width * 0.7,
                  fit: BoxFit.cover,
                ).animate().scale(
                      delay: 300.ms,
                      duration: 1.seconds,
                    ),
              ],
            ),
          ),
        ));
  }
}
