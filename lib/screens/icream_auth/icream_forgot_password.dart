import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icream/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../widgets/text_form_field.dart';

class ICreamForgotPassword extends StatefulWidget {
  const ICreamForgotPassword({super.key});

  @override
  State<ICreamForgotPassword> createState() => _ICreamForgotPasswordState();
}

class _ICreamForgotPasswordState extends State<ICreamForgotPassword> {
  GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
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
              Consumer<AuthProvider>(builder: (context, auth, child) {
                return Container(
                  height: size.height * 0.78,
                  margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(Icons.arrow_back_ios,
                                    color: Colors.white)),
                            Text(
                              'Forgot password',
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
                        Form(
                          key: emailFormKey,
                          child: Column(
                            children: [
                              Text(
                                'use your email',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                hintText: 'Email',
                                controller: auth.emailController,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: auth.resetPasswordFocusNode,
                                onTapOutside: (event) =>
                                    auth.resetPasswordFocusNode.unfocus(),
                                validator: (value) =>
                                    auth.emailValidator(value!),
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
                                if (emailFormKey.currentState!.validate()) {
                                  emailFormKey.currentState!.save();
                                  await auth.emailResetPassword(
                                      context: context,
                                      email: auth.emailController.text);

                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    auth.emailController.text = '';
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange.shade800,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
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
                      ]),
                );
              }),
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
