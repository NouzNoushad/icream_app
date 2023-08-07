import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icream/providers/auth_provider.dart';
import 'package:icream/providers/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../widgets/text_form_field.dart';
import 'icream_about_us.dart';

class ICreamProfile extends StatefulWidget {
  const ICreamProfile({super.key});

  @override
  State<ICreamProfile> createState() => _ICreamProfileState();
}

class _ICreamProfileState extends State<ICreamProfile> {
  GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();
  GlobalKey<FormState> profileKey = GlobalKey<FormState>();

  @override
  void initState() {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.getUserProfileDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: CustomColors.backgroundColor,
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child:
                Consumer<ProfileProvider>(builder: (context, profile, child) {
              return Column(children: [
                Container(
                  height: size.height * 0.68,
                  margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 255, 87, 1),
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
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Sweet Profile',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                            GestureDetector(
                              onTap: () => showEditProfileSheet(
                                  profile.profileName!, profile.profileEmail!),
                              child: const CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Color.fromARGB(255, 0, 221, 63),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ProfileContainer(
                              profileField: profile.profileName ?? 'Name',
                            ),
                            ProfileContainer(
                              profileField: profile.profileEmail ?? 'Email',
                            ),
                          ],
                        ),
                        Align(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: ElevatedButton(
                              onPressed: () async {
                                await profile.logoutUser(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 0, 221, 63),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Text(
                                'logout',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
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
                    const CircleAvatar(
                      radius: 42,
                      backgroundColor: Color.fromRGBO(255, 0, 61, 1),
                      child: Center(
                        child: Text(
                          'Terms & Condition',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
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
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ICreamAboutUs())),
                      child: const CircleAvatar(
                        radius: 42,
                        backgroundColor: Color.fromRGBO(1, 173, 227, 1),
                        child: Center(
                          child: Text(
                            'About Us',
                            style: TextStyle(
                              fontSize: 15,
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

  showEditProfileSheet(String name, String email) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.5,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        builder: (dialogContext) => Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.red,
            ),
            child: Consumer<AuthProvider>(builder: (context, auth, child) {
              return Form(
                key: profileKey,
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          CustomTextFormField(
                            // hintText: name,
                            label: name,
                            controller: auth.fullNameController,
                            keyboardType: TextInputType.name,
                            focusNode: auth.signUpFullNameFocusNode,
                            onTapOutside: (event) =>
                                auth.signUpFullNameFocusNode.unfocus(),
                            validator: (value) => auth.profileNameValidator(),
                          ),
                          CustomTextFormField(
                            // hintText: email,
                            label: email,
                            controller: auth.emailController,
                            keyboardType: TextInputType.emailAddress,
                            focusNode: auth.signUpEmailFocusNode,
                            onTapOutside: (event) =>
                                auth.signUpEmailFocusNode.unfocus(),
                            validator: (value) => auth.profileEmailValidator(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      Align(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.28,
                          child: ElevatedButton(
                            onPressed: () async {
                              var profileProvider =
                                  Provider.of<ProfileProvider>(context,
                                      listen: false);
                              if (profileKey.currentState!.validate()) {
                                profileKey.currentState?.save();
                                String profileName =
                                    auth.fullNameController.text == ''
                                        ? name
                                        : auth.fullNameController.text;
                                String profileEmail =
                                    auth.emailController.text == ''
                                        ? email
                                        : auth.emailController.text;
                                print(
                                    '////////////// profile, $profileName $profileEmail');
                                await auth.updateUserInfo(
                                    context: context,
                                    dialogContext: dialogContext,
                                    name: profileName,
                                    email: profileEmail);

                                profileProvider.getUserProfileDetails();
                                Future.delayed(const Duration(seconds: 2), () {
                                  auth.emailController.text = '';
                                  auth.fullNameController.text = '';
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade700,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })));
  }
}

class ProfileContainer extends StatelessWidget {
  final String? profileField;
  const ProfileContainer({super.key, this.profileField});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width,
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        profileField ?? '',
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
