import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicrush/presentation/route/routes.dart';
import 'package:unicrush/presentation/utils/utils.dart';

class SignupPageController extends GetxController {
  late final TextEditingController usernameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool isPasswordVisible1 = false;
  bool isPasswordVisible2 = false;

  bool isLoading = false;

  @override
  void onInit() {
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void togglePasswordFunc1() {
    isPasswordVisible1 = !isPasswordVisible1;
    update();
  }

  void togglePasswordFunc2() {
    isPasswordVisible2 = !isPasswordVisible2;
    update();
  }

  void toggleLoading() {
    isLoading = !isLoading;
    update();
  }

  Future<void> signUp() async {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      log('Field Empty');
    }
    try {
      toggleLoading();
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then(
        (value) async {
          await FirebaseFirestore.instance
              .collection(FirestoreCollections.usersCollection)
              .doc(value.user!.email)
              .set(
            {
              'uid': value.user!.uid,
              'userName': usernameController.text,
              'email': value.user!.email,
            },
          );
          await FirebaseAuth.instance.currentUser
              ?.updateProfile(displayName: usernameController.text);
          toggleLoading();
          FirebaseAuth.instance
              .signOut()
              .then((value) => Get.offAllNamed(Routes.login));
          log('Account Created');
        },
      );
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
  }
}
