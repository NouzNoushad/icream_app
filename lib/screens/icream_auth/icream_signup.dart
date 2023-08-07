import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icream/providers/auth_provider.dart';
import 'package:icream/screens/icream_auth/icream_login.dart';
import 'package:icream/screens/widgets/text_form_field.dart';
import 'package:icream/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class ICreamSignUp extends StatefulWidget {
  const ICreamSignUp({super.key});

  @override
  State<ICreamSignUp> createState() => _ICreamSignUpState();
}

class _ICreamSignUpState extends State<ICreamSignUp> {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
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
                    color: const Color.fromRGBO(255, 0, 0, 1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: Text(
                            'create your new account',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                        ),
                        Form(
                          key: signUpFormKey,
                          child: Column(
                            children: [
                              CustomTextFormField(
                                hintText: 'Full Name',
                                controller: auth.fullNameController,
                                keyboardType: TextInputType.name,
                                focusNode: auth.signUpFullNameFocusNode,
                                onTapOutside: (event) =>
                                    auth.signUpFullNameFocusNode.unfocus(),
                                validator: (value) =>
                                    auth.nameValidator(value!),
                              ),
                              CustomTextFormField(
                                hintText: 'Email',
                                controller: auth.emailController,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: auth.signUpEmailFocusNode,
                                onTapOutside: (event) =>
                                    auth.signUpEmailFocusNode.unfocus(),
                                validator: (value) =>
                                    auth.emailValidator(value!),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      hintText: 'Phone No',
                                      controller: auth.phoneNoController,
                                      keyboardType: TextInputType.phone,
                                      focusNode: auth.signUpPhoneNoFocusNode,
                                      onTapOutside: (event) =>
                                          auth.signUpPhoneNoFocusNode.unfocus(),
                                      validator: (value) =>
                                          auth.phoneNoValidator(value!),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Container(
                                    width: size.width * 0.14,
                                    height: size.height * 0.07,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(254, 230, 11, 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DropdownButton(
                                      underline: Container(),
                                      icon: Container(),
                                      isExpanded: true,
                                      value: auth.selectedCountry,
                                      dropdownColor:
                                          const Color.fromRGBO(254, 230, 11, 1),
                                      borderRadius: BorderRadius.circular(20),
                                      items: countryCodes
                                          .map((code) => DropdownMenuItem(
                                              value: code,
                                              child: Center(
                                                  child: Text(
                                                code,
                                                style: const TextStyle(
                                                    fontSize: 16.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(
                                                        207, 0, 0, 1)),
                                              ))))
                                          .toList(),
                                      onChanged: (value) =>
                                          auth.countryCodeValueChanged(value!),
                                    ),
                                  ),
                                ],
                              ),
                              CustomTextFormField(
                                hintText: 'Password',
                                controller: auth.passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                focusNode: auth.signUpPasswordFocusNode,
                                onTapOutside: (event) =>
                                    auth.signUpPasswordFocusNode.unfocus(),
                                validator: (value) =>
                                    auth.passwordValidator(value!),
                              ),
                              CustomTextFormField(
                                hintText: 'Confirm Password',
                                controller: auth.confirmPasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                focusNode: auth.signUpConfirmPasswordFocusNode,
                                onTapOutside: (event) => auth
                                    .signUpConfirmPasswordFocusNode
                                    .unfocus(),
                                validator: (value) =>
                                    auth.confirmPasswordValidator(value!),
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
                                if (signUpFormKey.currentState!.validate()) {
                                  signUpFormKey.currentState!.save();
                                  await auth.createUserAccount(
                                      context,
                                      auth.fullNameController.text,
                                      auth.emailController.text,
                                      auth.passwordController.text,
                                      auth.phoneNoController.text);
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    auth.fullNameController.text = '';
                                    auth.emailController.text = '';
                                    auth.phoneNoController.text = '';
                                    auth.passwordController.text = '';
                                    auth.confirmPasswordController.text = '';
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(207, 0, 0, 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Text(
                                'save',
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
                        backgroundColor: const Color.fromRGBO(0, 67, 250, 1),
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
                              builder: (context) => const ICreamLogin())),
                      child: CircleAvatar(
                        radius: 42,
                        backgroundColor: const Color.fromRGBO(1, 130, 29, 1),
                        child: Center(
                          child: Text(
                            'Login',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
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
