import 'package:e_commerce/model/facebook_model.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  bool isVisibility = false;
  bool isCheckBox = false;
  var displayUSerName = ''.obs;
  var displayUserPhoto = ''.obs;
  var displayUSerEmail = ''.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  var googleSingIn = GoogleSignIn();
  FaceBookModel? faceBookModel;

  var isSignedIn = false;
  final GetStorage authBox = GetStorage();

  User? get userProfile => auth.currentUser;

  @override
  void onInit() {
    displayUSerName.value =
        (userProfile != null ? userProfile!.displayName : "")!;
    displayUserPhoto.value =
        (userProfile != null ? userProfile!.photoURL : "")!;
    displayUSerEmail.value = (userProfile != null ? userProfile!.email : "")!;
  }

  void visibility() {
    isVisibility = !isVisibility;

    update();
  }

  void checkBox() {
    isCheckBox = !isCheckBox;

    update();
  }

  void signUpUsingFirebase({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        displayUSerName.value = name;
        auth.currentUser!.updateDisplayName(name);
      });

      update();

      Get.offNamed(Routes.mainScreen);
    } on FirebaseAuthException catch (error) {
      String title = error.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';
      if (error.code == 'weak-password') {
        message = ' Provided Password is too weak.. ';
      } else if (error.code == 'email-already-in-use') {
        message = ' Account already exists for that email.. ';
      } else {
        message = error.message.toString();
      }

      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void logInUsingFirebase({
    required String email,
    required String password,
  }) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => displayUSerName.value = auth.currentUser!.displayName!,
          );

      isSignedIn = true;
      authBox.write("auth", isSignedIn);

      update();
      Get.offNamed(Routes.mainScreen);
    } on FirebaseAuthException catch (error) {
      String title = error.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';
      if (error.code == 'user-not-found') {
        message =
            'Account does not exist for that $email.. Create you account y signing up..';
      } else if (error.code == 'wrong-password') {
        message = 'Invalid Password... Please try again!';
      } else {
        message = error.message.toString();
      }
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void googleSignUpApp() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSingIn.signIn();
      displayUSerName.value = googleUser!.displayName!;
      displayUserPhoto.value = googleUser.photoUrl!;
      displayUSerEmail.value = googleUser.email;

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      await auth.signInWithCredential(credential);

      isSignedIn = true;
      authBox.write("auth", isSignedIn);

      update();
      Get.offNamed(Routes.mainScreen);
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void faceBookSignUpApp() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.success) {
      final data = await FacebookAuth.instance.getUserData();

      faceBookModel = FaceBookModel.fromJson(data);

      // print("================");
      // print(faceBookModel!.email);
      // print(faceBookModel!.name);
      // print("================");
      isSignedIn = true;
      authBox.write("auth", isSignedIn);

      update();
      Get.offNamed(Routes.mainScreen);
    }
  }

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);

      update();
      Get.back();
    } on FirebaseAuthException catch (error) {
      String title = error.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';
      if (error.code == 'user-not-found') {
        message =
            'Account does not exist for that $email.. Create you account y signing up..';
      } else {
        message = error.message.toString();
      }
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void signOutFromApp() async {
    try {
      await auth.signOut();
      await googleSingIn.signOut();
      await FacebookAuth.i.logOut();
      displayUSerName.value = '';
      displayUserPhoto.value = '';
      displayUSerEmail.value = '';

      isSignedIn = false;
      authBox.remove("auth");

      update();
      Get.offNamed(Routes.welcomeScreen);
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}
