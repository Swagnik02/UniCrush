import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:unicrush/model/matches.dart';
import 'package:unicrush/model/user_model.dart';
import 'package:unicrush/presentation/configs/configs.dart';
import 'package:unicrush/presentation/utils/extensions/age_calculator.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Stack(
        children: [
          // top
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  color: kBackground,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      // width: Get.width / 5,
                      height: 30,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      decoration: BoxDecoration(
                          color: kPrimary.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Matches',
                        style: TextStyle(
                            color: kBackground,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // mainbody
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Material(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(35),
                topLeft: Radius.circular(35),
              ),
              color: kPrimary,
              elevation: 5,
              child: Container(
                  padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  width: Get.width,
                  child: _matchesListBody()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _matchesListBody() {
    double aspectRatio = 1 / 1.35;
    return FutureBuilder<List<Match>>(
      future: Future.value(Match.matchList),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Match>? matches = snapshot.data;
          if (matches == null || matches.isEmpty) {
            return const Center(child: Text('No data found'));
          }
          return SizedBox(
            // color: Colors.red,
            height: Get.height,
            child: GridView.builder(
              primary: false,
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: aspectRatio,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
              ),
              itemCount: matches.length,
              itemBuilder: (context, index) {
                Match match = matches[index];
                String uid = match.uid;
                UserModel user =
                    UserModel.dummyUsers.firstWhere((user) => user.uid == uid);
                return ProfileTiles(user: user);
              },
            ),
          );
        }
      },
    );
  }
}

class ProfileTiles extends StatelessWidget {
  final UserModel user;
  const ProfileTiles({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    // double widthOfTiles = Get.width / 2.5;
    // double heightOfTiles = 1.35 * widthOfTiles;
    // double paddingInBetweenTiles = Get.width - 2 * 30 - 2 * widthOfTiles;

    return GestureDetector(
      onTap: () => profileDetailsBottomSheet(context, user),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(user.photos![0]),
            fit: BoxFit.cover,
          ),
          color: kBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
                child: Text(
              user.username,
              style: const TextStyle(
                fontFamily: ksFontFamily,
                color: Colors.white,
                fontSize: 20,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Future<void> profileDetailsBottomSheet(BuildContext context, UserModel user) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: Get.height * 0.85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: kBackground,
            image: DecorationImage(
              image: AssetImage(user.photos![0]),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              // bar
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(30),
                      elevation: 1,
                      shadowColor: Colors.purple,
                      child: Container(
                        height: 8,
                        width: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kBackground),
                      ),
                    ),
                  ],
                ),
              ),
              // name and age
              Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 16),
                child: Row(
                  children: [
                    Text(
                      user.username + ', ',
                      style: TextStyle(
                          fontFamily: ksFontFamily,
                          fontSize: 45,
                          color: kPrimaryMedium),
                    ),
                    Text(
                      calculateAge(user.dob).toString(),
                      style: TextStyle(
                          fontFamily: ksFontFamily,
                          fontSize: 45,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.rotate(
                          angle:
                              45 * (3.14 / 180), // Convert degrees to radians
                          child: CustomIconButtons(
                            icon: LineIcons.plus,
                          ),
                        ),
                        CustomIconButtons(
                          icon: LineIcons.user,
                        ),
                        CustomIconButtons(
                          icon: LineIcons.heart,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomIconButtons extends StatelessWidget {
  final IconData icon;

  CustomIconButtons({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: _MatteGlassMorphism(
          blur: 15,
          gradientColors: [
            Colors.white.withOpacity(0.1),
            Colors.black.withOpacity(0.3),
            Colors.grey.withOpacity(0.2),
          ],
          opacity: 0.9,
          child: Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _MatteGlassMorphism extends StatelessWidget {
  final double blur;
  final List<Color> gradientColors;
  final double opacity;
  final Widget child;

  const _MatteGlassMorphism({
    Key? key,
    required this.blur,
    required this.gradientColors,
    required this.opacity,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: gradientColors,
            ),
            color: Colors.purpleAccent,
          ),
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        ),
      ),
    );
  }
}
