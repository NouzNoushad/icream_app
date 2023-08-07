import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icream/screens/icream_auth/icream_login.dart';
import 'package:introduction_screen/introduction_screen.dart';

class ICreamOnboarding extends StatefulWidget {
  const ICreamOnboarding({Key? key}) : super(key: key);

  @override
  ICreamOnboardingState createState() => ICreamOnboardingState();
}

class ICreamOnboardingState extends State<ICreamOnboarding> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ICreamLogin()),
    );
  }

  Widget _pageViewContainer(
      {String? text, double? fontSize, double? letterSpacing, double? height}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(
            width: 1.5, color: const Color.fromARGB(255, 255, 220, 232)),
      ),
      child: Text(
        text!,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          height: height,
          letterSpacing: letterSpacing,
          color: const Color.fromARGB(255, 252, 177, 203),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buttonContainer({Widget? widget}) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: const BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20),
            )),
        child: widget!);
  }

  Widget _buildImage(String assetName, [double width = 500]) {
    return Container(
        color: const Color.fromARGB(255, 255, 251, 215),
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
        child: Image.asset(
          assetName,
          width: width,
          fit: BoxFit.contain,
        ));
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 16.0);

    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle:
          GoogleFonts.poppins(fontSize: 22.0, fontWeight: FontWeight.w500),
      bodyTextStyle: bodyStyle,
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.transparent,
      imagePadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.all(10),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IntroductionScreen(
          key: introKey,
          // bodyPadding: const EdgeInsets.only(top: 40),
          globalBackgroundColor: const Color.fromARGB(255, 255, 251, 215),
          allowImplicitScrolling: true,
          autoScrollDuration: 3000,
          // globalHeader: Align(
          //   alignment: Alignment.topRight,
          //   child: SafeArea(
          //     child: Padding(
          //       padding: const EdgeInsets.only(top: 16, right: 16),
          //       child: _buildImage('assets/images/ice-cream.png', 100),
          //     ),
          //   ),
          // ),
          globalFooter: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              child: Text(
                'Let\'s go right away!',
                style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              onPressed: () => _onIntroEnd(context),
            ),
          ),
          pages: [
            PageViewModel(
                titleWidget: _pageViewContainer(
                  text: 'Mouthwatering ice creams',
                  fontSize: 18,
                  letterSpacing: 0.5,
                ),
                bodyWidget: _pageViewContainer(
                    text:
                        "Discover a vast array of mouthwatering ice cream flavors and products with just a few clicks.",
                    fontSize: 16,
                    letterSpacing: 0.2,
                    height: 1.5),
                image: _buildImage('assets/images/ice-cream-cup2.png'),
                decoration: pageDecoration.copyWith(
                  bodyFlex: 5,
                  imageFlex: 7,
                  bodyAlignment: Alignment.bottomCenter,
                  imageAlignment: Alignment.topCenter,
                ),
                reverse: true),
            PageViewModel(
                titleWidget: _pageViewContainer(
                  text: 'Easy Browsing',
                  fontSize: 18,
                  letterSpacing: 0.5,
                ),
                bodyWidget: _pageViewContainer(
                    text:
                        "Our user-friendly app allows you to effortlessly browse through different categories",
                    fontSize: 16,
                    letterSpacing: 0.2,
                    height: 1.5),
                image: _buildImage('assets/images/ice-cream-truck.png'),
                decoration: pageDecoration.copyWith(
                  bodyFlex: 5,
                  imageFlex: 7,
                  bodyAlignment: Alignment.bottomCenter,
                  imageAlignment: Alignment.topCenter,
                ),
                reverse: true),
            PageViewModel(
                titleWidget: _pageViewContainer(
                  text: 'Product Details',
                  fontSize: 18,
                  letterSpacing: 0.5,
                ),
                bodyWidget: _pageViewContainer(
                    text:
                        "we provide comprehensive product details to help you make informed choices based on your preferences and dietary needs.",
                    fontSize: 16,
                    letterSpacing: 0.2,
                    height: 1.5),
                image: _buildImage('assets/images/ice-cream.png'),
                decoration: pageDecoration.copyWith(
                  bodyFlex: 5,
                  imageFlex: 7,
                  bodyAlignment: Alignment.bottomCenter,
                  imageAlignment: Alignment.topCenter,
                ),
                reverse: true),
            PageViewModel(
                titleWidget: _pageViewContainer(
                  text: 'Safety and Quality Assurance',
                  fontSize: 18,
                  letterSpacing: 0.5,
                ),
                bodyWidget: _pageViewContainer(
                    text:
                        "Our ice cream is carefully prepared and stored under the highest standards, ensuring a delicious and safe delivery experience",
                    fontSize: 16,
                    letterSpacing: 0.2,
                    height: 1.5),
                image: _buildImage('assets/images/ice-cream6.png'),
                decoration: pageDecoration.copyWith(
                  bodyFlex: 5,
                  imageFlex: 7,
                  bodyAlignment: Alignment.bottomCenter,
                  imageAlignment: Alignment.topCenter,
                ),
                reverse: true),
          ],
          onDone: () => _onIntroEnd(context),
          //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
          showSkipButton: true,
          skipOrBackFlex: 0,
          nextFlex: 0,
          showBackButton: false,
          //rtl: true, // Display as right-to-left
          back: const Icon(Icons.arrow_back),
          skip: _buttonContainer(
              widget: Text('Skip',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, color: Colors.white))),

          next: _buttonContainer(
              widget: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 18,
          )),
          done: _buttonContainer(
              widget: Text('Done',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, color: Colors.white))),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: const DotsDecorator(
            size: Size(6.0, 6.0),
            color: Color(0xFFBDBDBD),
            activeSize: Size(20.0, 6.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ),
    );
  }
}
