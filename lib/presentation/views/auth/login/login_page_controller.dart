import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicrush/presentation/route/routes.dart';

class LoginPageController extends GetxController {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool isPasswordVisible = false;
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLoading = false;

  void togglePasswordVisibleFunc() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  void toggleLoading() {
    isLoading = !isLoading;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> logIn() async {
    try {
      toggleLoading();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        // UserDataService().fetchUserData(emailController.text).then(
        //   (_) {
        //     // Store user data locally after successful login
        //     UserDataService().storeUserDataLocally();
        //   },
        // );
        // toggleLoading();

        // // Navigate to the home screen
        Get.offAllNamed(Routes.home);
      });
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
  }
}
