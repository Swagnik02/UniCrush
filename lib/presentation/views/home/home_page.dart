import 'package:flutter/material.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:line_icons/line_icons.dart';
import 'package:unicrush/presentation/views/find/find_page.dart';
import 'package:unicrush/presentation/views/home/home_page_controller.dart';
import 'package:unicrush/presentation/views/matches/matches_page.dart';
import 'package:unicrush/presentation/views/profile/profile_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      builder: (_) => Obx(() {
        return Container(
          // decoration: boxDecor(),
          child: Scaffold(
            extendBody: true,
            backgroundColor: Colors.transparent,
            bottomNavigationBar: _CustomNavBar(controller: controller),
            body: (() {
              switch (controller.bottomNavBarIndex.value) {
                case 0:
                  return MatchesPage();

                case 1:
                  return FindPage();
                case 2:
                  return ProfilePage();

                default:
                  return FindPage();
              }
            })(),
          ),
        );
      }),
    );
  }
}

class _CustomNavBar extends StatelessWidget {
  final HomePageController controller;

  const _CustomNavBar({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CrystalNavigationBar(
        currentIndex: controller.bottomNavBarIndex.value,
        height: 10,
        // indicatorColor: Colors.blue,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.black.withOpacity(0.1),
        onTap: (index) {
          controller.bottomNavBarIndex.value = index;
        },
        items: [
          /// matches
          CrystalNavigationBarItem(
            icon: LineIcons.heartAlt,
            unselectedIcon: IconlyLight.heart,
            selectedColor: Colors.purpleAccent,
          ),

          /// find
          CrystalNavigationBarItem(
            icon: IconlyBold.search,
            unselectedIcon: IconlyLight.search,
            selectedColor: Colors.purpleAccent,
          ),

          /// Profile
          CrystalNavigationBarItem(
            icon: IconlyBold.user_2,
            unselectedIcon: IconlyLight.user,
            selectedColor: Colors.purpleAccent,
          ),
        ],
      ),
    );
  }
}
