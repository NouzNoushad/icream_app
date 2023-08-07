import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icream/providers/auth_provider.dart';
import 'package:icream/utils/colors.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class ICreamOtp extends StatelessWidget {
  final String? verificationId;
  const ICreamOtp({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                height: size.height * 0.78,
                margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(207, 0, 0, 1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Consumer<AuthProvider>(builder: (context, auth, child) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: const Icon(Icons.arrow_back_ios,
                                      color: Colors.white)),
                              Text(
                                'Verify your OTP code',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Pinput(
                            length: 6,
                            controller: auth.otpController,
                            defaultPinTheme: PinTheme(
                              height: 50,
                              width: 50,
                              textStyle: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: Align(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.28,
                              child: ElevatedButton(
                                onPressed: () async {
                                  print(
                                      '///////////*********verify, $verificationId');
                                  // if (verificationId != '') {
                                  //   await auth.verifyOTPCode(verificationId!,
                                  //       auth.otpController.text);
                                  // }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(173, 0, 0, 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Text(
                                  'verify',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]);
                }),
              ),
              Center(
                child: Container(
                  width: 70,
                  height: size.height * 0.16,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(254, 215, 11, 1),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60),
                      )),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
