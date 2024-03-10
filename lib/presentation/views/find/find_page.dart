import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:unicrush/presentation/configs/configs.dart';
import 'package:unicrush/presentation/views/auth/login/login_page.dart';
import 'package:unicrush/presentation/views/auth/onboard/onboard_page.dart';
import 'package:unicrush/presentation/views/auth/signup/signup_page.dart';
import 'package:unicrush/presentation/views/find/find_page_controller.dart';
import 'dart:ui';

class FindPage extends StatelessWidget {
  FindPage({super.key});
  final FindPageController controller = Get.put(FindPageController());
  final TextEditingController searchControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FindPageController>(
      builder: (_) => Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: kBackground,
        body: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Stack(
              children: [
                //background image
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    'assets/images/find-bg.png',
                    fit: BoxFit.cover,
                  ),
                ),

                // searchBox
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: _topBar(context),
                ),
                // test buttons
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () => Get.to(() => LoginPage()),
                          child: Text('Login')),
                      TextButton(
                          onPressed: () => Get.to(() => SignUpPage()),
                          child: Text('Signup')),
                      TextButton(
                          onPressed: () => Get.to(() => OnboardPage()),
                          child: Text('OnBoard'))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.transparent,
                    border: Border.all(color: kBackground)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: kBackground.withOpacity(0.2),
                      ),
                      child: Row(
                        children: [
                          _searchBar(context),
                          const Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Text(
                              'Find your crush',
                              style: TextStyle(
                                  fontFamily: ksFontFamily,
                                  fontSize: 20,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  SearchBarAnimation _searchBar(BuildContext context) {
    return SearchBarAnimation(
      durationInMilliSeconds: 500,
      onPressButton: (isOpen) {
        controller.searchController.clear();
        FocusScope.of(context).unfocus();
        controller.resetSearch();
      },
      buttonElevation: 2,
      isOriginalAnimation: false,
      buttonBorderColour: Colors.purpleAccent,
      onFieldSubmitted: (String value) => controller.filteredValues(value),
      textEditingController: searchControl,
      trailingWidget: const Icon(
        Icons.search,
        color: Colors.purpleAccent,
      ),
      secondaryButtonWidget: const Icon(
        Icons.arrow_back_ios_new_rounded,
        color: Colors.purpleAccent,
      ),
      buttonWidget: Icon(
        IconlyLight.search,
        color: Colors.purpleAccent,
      ),
    );
  }
}
