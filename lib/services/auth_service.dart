import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class AuthService {
  late SharedPreferences sharedPreferences;
  static AuthStatus status = AuthStatus.pending;

  Future<AuthStatus> createUserAccount(
      context, name, email, password, phoneNo) async {
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      UserCredential result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      await user?.updateDisplayName(name);
      if (user != null) {
        await sharedPreferences.setString(nameKey, name);
        await sharedPreferences.setString(emailKey, email);
        var savedName = sharedPreferences.getString(nameKey);
        print(
            '//////////////////////////=========>>>>>>>>>>>>> saved Name: $savedName');
        status = AuthStatus.successful;
      } else {
        status = AuthStatus.failed;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        status = AuthStatus.exists;
      }
    } catch (e) {
      print(e);
      status = AuthStatus.failed;
    }
    return status;
  }

  Future<AuthStatus> loginUser(email, password) async {
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      var response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('============>>>>>>>>>>>>>>>>>>>>> signed in, $response');
      User? user = response.user;
      if (user != null) {
        await sharedPreferences.setString(nameKey, user.displayName.toString());
        await sharedPreferences.setString(emailKey, user.email.toString());
        status = AuthStatus.successful;
      } else {
        status = AuthStatus.noUser;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        status = AuthStatus.noUser;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        status = AuthStatus.wrongPass;
      }
    } catch (e) {
      print(e);
      status = AuthStatus.failed;
    }
    return status;
  }

  Future<AuthStatus> signInWithGoogle() async {
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential response =
            await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = response.user;
        print(
            '///////////////////===============>>>>>>>> google User, $response');
        if (user != null) {
          print(
              '///////////////////===============>>>>>>>> google User, ${user.displayName}');
          await sharedPreferences.setString(nameKey, user.displayName ?? '');
          await sharedPreferences.setString(emailKey, user.email ?? '');
          status = AuthStatus.successful;
        } else {
          status = AuthStatus.failed;
        }
      }
    } catch (err) {
      print(err);
      status = AuthStatus.successful;
    }
    return status;
  }

  Future<AuthStatus> emailResetPassword({required String email}) async {
    var auth = FirebaseAuth.instance;
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => status = AuthStatus.successful)
        .catchError((e) => status = AuthStatus.failed);
    return status;
  }

  Future<AuthStatus> updateUserInfo(
      {required String name, required String email}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      user.updateDisplayName(name);
      user.updateEmail(email);
      await sharedPreferences.setString(nameKey, name);
      await sharedPreferences.setString(emailKey, email);
      status = AuthStatus.successful;
    } else {
      status = AuthStatus.failed;
    }
    return status;
  }

  // void phoneResetPassword(String currentPassword, String newPassword) async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   final cred = EmailAuthProvider.credential(
  //       email: user?.email ?? '', password: currentPassword);

  //   user?.reauthenticateWithCredential(cred).then((value) {
  //     user.updatePassword(newPassword).then((_) {
  //       //Success, do something
  //     }).catchError((error) {
  //       //Error, show something
  //     });
  //   }).catchError((err) {});
  // }

  // checkPhoneNumber(BuildContext context, String phoneNumber) async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     verificationCompleted: (PhoneAuthCredential credential) {},
  //     verificationFailed: (FirebaseAuthException e) {
  //       if (e.code == 'invalid-phone-number') {
  //         print('The provided phone number is not valid.');
  //       }
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       Navigator.of(context).push(MaterialPageRoute(
  //           builder: (context) => ICreamOtp(verificationId: verificationId)));
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  // }

  // verifyOTPCode(String verificationId, String smsCode) async {
  //   // var auth = FirebaseAuth.instance;
  //   var credential = PhoneAuthProvider.credential(
  //       verificationId: verificationId, smsCode: smsCode);

  //   // UserCredential response = await auth.signInWithCredential(credential);
  //   print('////////////////verifyOTPResponse, $credential');
  // }
}
