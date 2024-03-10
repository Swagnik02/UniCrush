import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:unicrush/model/matches.dart';
import 'package:unicrush/model/user_model.dart';
import 'package:unicrush/presentation/configs/configs.dart';
import 'package:unicrush/presentation/utils/match_func.dart';

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
            image: NetworkImage(user.photos.toString()),
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
}

Future<void> profileDetailsBottomSheet(BuildContext context, UserModel user) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        height: Get.height * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: kBackground,
          image: DecorationImage(
            image: NetworkImage(user.photos.toString()),
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
                    // calculateAge(user.dob).toString() ??
                    '25',
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
                        angle: 45 * (3.14 / 180), // Convert degrees to radians
                        child: CustomIconButtons(
                          icon: LineIcons.plus,
                        ),
                      ),
                      CustomIconButtons(
                        icon: LineIcons.user,
                      ),
                      CustomIconButtons(
                        icon: LineIcons.heart,
                        onTap: () {
                          matchBtn(
                            MatchModel(
                              uid: user.uid,
                              email: user.email,
                              username: user.username,
                              userPhoto: user.photos.toString(),
                              matchTime: DateTime.now(),
                              user: user,
                            ),
                          );
                        },
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

class CustomIconButtons extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  CustomIconButtons({
    Key? key,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
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
