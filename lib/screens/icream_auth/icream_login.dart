import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icream/screens/icream_auth/icream_forgot_password.dart';
import 'package:icream/screens/icream_auth/icream_signup.dart';

import 'package:icream/screens/widgets/text_form_field.dart';
import 'package:icream/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class ICreamLogin extends StatefulWidget {
  const ICreamLogin({super.key});

  @override
  State<ICreamLogin> createState() => _ICreamLoginState();
}

class _ICreamLoginState extends State<ICreamLogin> {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
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
            child: Consumer<AuthProvider>(builder: (context, auth, child) {
              return Column(children: [
                Container(
                  height: size.height * 0.78,
                  margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 209, 255, 1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Text(
                            'verify your account',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                        ),
                        Form(
                          key: loginFormKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              CustomTextFormField(
                                hintText: 'Email',
                                controller: auth.emailController,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: auth.loginEmailFocusNode,
                                onTapOutside: (event) =>
                                    auth.loginEmailFocusNode.unfocus(),
                                validator: (value) =>
                                    auth.emailValidator(value!),
                              ),
                              CustomTextFormField(
                                hintText: 'Password',
                                controller: auth.passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                focusNode: auth.loginPasswordFocusNode,
                                onTapOutside: (event) =>
                                    auth.loginPasswordFocusNode.unfocus(),
                                validator: (value) =>
                                    auth.passwordValidator(value!),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ICreamForgotPassword())),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    color: Colors.transparent,
                                    child: Text(
                                      'Oops Forgot password ?',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (loginFormKey.currentState!.validate()) {
                                  loginFormKey.currentState!.save();
                                  await auth.loginUser(
                                      context,
                                      auth.emailController.text,
                                      auth.passwordController.text);
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    auth.emailController.text = '';
                                    auth.passwordController.text = '';
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(1, 173, 227, 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Text(
                                'send',
                                style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await auth.signInWithGoogle(context);
                      },
                      child: CircleAvatar(
                        radius: 42,
                        backgroundColor: const Color.fromRGBO(29, 250, 0, 1),
                        child: Center(
                          child: Text(
                            'G',
                            style: GoogleFonts.poppins(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
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
                    InkWell(
                      onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const ICreamSignUp())),
                      child: CircleAvatar(
                        radius: 42,
                        backgroundColor: const Color.fromRGBO(221, 0, 250, 1),
                        child: Center(
                          child: Text(
                            'Sign up',
                            style: GoogleFonts.poppins(
                              fontSize: 19,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ]);
            }),
          ),
        ),
      ),
    );
  }
}
