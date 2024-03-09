import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  final RxInt bottomNavBarIndex = 1.obs;
  late final PageController pageController;
  late final AnimationController loadingController;

  @override
  void onClose() {
    super.onClose();
  }
}
