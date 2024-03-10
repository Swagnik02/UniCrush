import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicrush/presentation/views/home/home_page.dart';

class SignupPageController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  void signUp() {
    Get.offAllNamed('/home');
  }
}
