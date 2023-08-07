import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/icream_auth/icream_login.dart';
import '../screens/icream_bottom_nav.dart';
import '../screens/widgets/dialog_box.dart';
import '../services/auth_service.dart';
import '../utils/constants.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FocusNode signUpFullNameFocusNode = FocusNode();
  FocusNode signUpPhoneNoFocusNode = FocusNode();
  FocusNode signUpEmailFocusNode = FocusNode();
  FocusNode signUpPasswordFocusNode = FocusNode();
  FocusNode signUpConfirmPasswordFocusNode = FocusNode();
  FocusNode loginEmailFocusNode = FocusNode();
  FocusNode loginPasswordFocusNode = FocusNode();
  FocusNode resetPasswordFocusNode = FocusNode();

  String selectedCountry = countryCodes.first;
  bool? isNewUser;

  AuthService authService = AuthService();
  late SharedPreferences sharedPreferences;

  UserCredential? loginResponse;
  UserCredential? googleSignInResponse;
  AuthStatus? status;

  countryCodeValueChanged(String value) {
    selectedCountry = value;
    notifyListeners();
  }

  nameValidator(String value) {
    if (value.isEmpty) {
      return 'Name field is required';
    }
    profileNameValidator();
  }

  profileNameValidator() {
    if (fullNameController.text.length >= 2) {
      if (fullNameController.text.length < 4) {
        return 'Please enter a name with more than 3 characters';
      }
    }
  }

  emailValidator(String value) {
    if (value.isEmpty) {
      return 'Email field is required';
    }
    profileEmailValidator();
  }

  profileEmailValidator() {
    if (emailController.text.length >= 2) {
      if (!EmailValidator.validate(emailController.text)) {
        return 'Please enter valid email address';
      }
    }
  }

  phoneNoValidator(String value) {
    if (value.isEmpty) {
      return 'Phone No field is required';
    }
    if (!RegExp(r'(^[0-9]{3}[-\s\.]?[0-9]{4,9}$)').hasMatch(value)) {
      return 'Please enter valid phone number';
    }
  }

  passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Password field is required';
    }

    if (!RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(value)) {
      return 'Should contain at least one Special character';
    }
    if (!RegExp(r'(?=.*?[0-9])').hasMatch(value)) {
      return 'Should contain at least one digit';
    }
    if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
      return 'Should contain at least one lower case';
    }
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return 'Should contain at least one upper case';
    }
    if (!RegExp(r'.{8,}').hasMatch(value)) {
      return 'Must be at least 8 characters in length';
    }
  }

  confirmPasswordValidator(String value) {
    if (value.isEmpty) {
      return 'Confirm Password field is required';
    }

    if (value != passwordController.text) {
      return 'Password does not match';
    }
  }

  createUserAccount(context, name, email, password, phoneNo) async {
    var navigator = Navigator.of(context);
    var response = await authService.createUserAccount(
        context, name, email, password, phoneNo);
    if (response == AuthStatus.successful) {
      showAlertDialog(
        context: context,
        title: 'Success',
        content: 'Created your new account',
        status: Status.success,
      );
      Future.delayed(const Duration(seconds: 2), () {
        // Navigate to Home page
        navigator.pushReplacement(
            MaterialPageRoute(builder: (context) => const ICreamBottomNav()));
      });
    } else if (response == AuthStatus.exists) {
      showAlertDialog(
        context: context,
        title: 'Error',
        content: 'User already exists',
        status: Status.failed,
      );
    } else if (response == AuthStatus.failed) {
      showAlertDialog(
        context: context,
        title: 'Error',
        content: 'Something went wrong',
        status: Status.failed,
      );
    }
  }

  loginUser(context, email, password) async {
    var navigator = Navigator.of(context);
    var response = await authService.loginUser(email, password);
    if (response == AuthStatus.successful) {
      showAlertDialog(
        context: context,
        title: 'Success',
        content: 'You are successfully logged In',
        status: Status.success,
      );
      Future.delayed(const Duration(seconds: 2), () {
        // Navigate to Home page
        navigator.pushReplacement(
            MaterialPageRoute(builder: (context) => const ICreamBottomNav()));
      });
    } else if (response == AuthStatus.noUser) {
      showAlertDialog(
        context: context,
        title: 'Error',
        content: 'No user found, signup first',
        status: Status.failed,
      );
    } else if (response == AuthStatus.wrongPass) {
      showAlertDialog(
        context: context,
        title: 'Error',
        content: 'Wrong password, try again',
        status: Status.failed,
      );
    } else if (response == AuthStatus.failed) {
      showAlertDialog(
        context: context,
        title: 'Error',
        content: 'Something went wrong',
        status: Status.failed,
      );
    }
  }

  signInWithGoogle(context) async {
    var navigator = Navigator.of(context);
    var response = await authService.signInWithGoogle();
    if (response == AuthStatus.successful) {
      showAlertDialog(
        context: context,
        title: 'Success',
        content: 'You are successfully logged In',
        status: Status.success,
      );
      Future.delayed(const Duration(seconds: 2), () {
        // Navigate to Home page
        navigator.pushReplacement(
            MaterialPageRoute(builder: (context) => const ICreamBottomNav()));
      });
    } else if (response == AuthStatus.failed) {
      showAlertDialog(
        context: context,
        title: 'Error',
        content: 'Something went wrong',
        status: Status.failed,
      );
    }
  }

  emailResetPassword({required context, required String email}) async {
    var navigator = Navigator.of(context);
    var response = await authService.emailResetPassword(email: email);
    if (response == AuthStatus.successful) {
      showAlertDialog(
        context: context,
        title: 'Email',
        content: 'Please check your email and reset your password',
        status: Status.success,
      );
      Future.delayed(const Duration(seconds: 3), () {
        navigator.pushReplacement(
            MaterialPageRoute(builder: (context) => const ICreamLogin()));
      });
    } else {
      showAlertDialog(
        context: context,
        title: 'Error',
        content: 'Something went wrong',
        status: Status.failed,
      );
    }
  }

  updateUserInfo(
      {required context,
      required dialogContext,
      required String name,
      required String email}) async {
    var response = await authService.updateUserInfo(name: name, email: email);
    if (response == AuthStatus.successful) {
      print('///////---------------->>>>>>>>> update result, $response');
      showAlertDialog(
        context: context,
        title: 'Success',
        content: 'Profile updated successfully',
        status: Status.success,
      );

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     backgroundColor: Colors.pink.shade800,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(10),
      //       side: BorderSide(width: 3, color: Colors.pink.shade700),
      //     ),
      //     content: const Text(
      //       'profile updated successfully',
      //       style: TextStyle(color: Colors.white),
      //     )));
      // Navigator.pop(context);
    } else if (response == AuthStatus.failed) {
      showAlertDialog(
        context: context,
        title: 'Error',
        content: 'Something went wrong',
        status: Status.failed,
      );
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNoController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
    super.dispose();
  }

  // checkPhoneNumber(BuildContext context, String phoneNumber) async {
  //   await authService.checkPhoneNumber(context, phoneNumber);
  // }

  // verifyOTPCode(String verificationId, String smsCode) async {
  //   await authService.verifyOTPCode(verificationId, smsCode);
  // }
}
