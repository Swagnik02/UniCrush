import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicrush/presentation/configs/configs.dart';
import 'package:unicrush/presentation/configs/constant_assets.dart';
import 'package:unicrush/presentation/route/routes.dart';
import 'package:unicrush/presentation/utils/utils.dart';

///Example of App with LiquidSwipe by providing list of widgets
class OnboardPage extends StatefulWidget {
  static const style = TextStyle(
    fontSize: 30,
    fontFamily: ksFontFamily3,
    fontWeight: FontWeight.w600,
  );

  const OnboardPage({super.key});

  @override
  _OnboardPage createState() => _OnboardPage();
}

class _OnboardPage extends State<OnboardPage> {
  int page = 0;
  late LiquidController liquidController;
  late UpdateType updateType;
  final pages = [
    _Pages(
      color: kSecondary,
      anim: kanim1,
      str1: 'Try',
      str2: 'Someone',
      str3: 'New',
    ),
    _Pages(
      color: kPrimaryMedium,
      anim: kanim1,
      str1: 'Try',
      str2: 'Something',
      str3: 'New',
    ),
    _Pages(
      color: kBackground,
      anim: kanim1,
      str1: 'Find',
      str2: 'Your',
      str3: 'Crush!',
    ),
  ];

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return SizedBox(
      width: 25.0,
      child: Center(
        child: Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          LiquidSwipe(
            pages: pages,
            positionSlideIcon: 0.8,
            fullTransitionValue: 880,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            onPageChangeCallback: pageChangeCallback,
            waveType: WaveType.liquidReveal,
            liquidController: liquidController,
            preferDragFromRevealedArea: true,
            enableSideReveal: true,
            ignoreUserGestureWhileAnimating: true,
            enableLoop: true,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                const Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(pages.length, _buildDot),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextButton(
                onPressed: () async {
                  final pref = await SharedPreferences.getInstance();
                  pref.setInt(GlobalUtil.onBordingToken, 1);

                  Get.offAllNamed(Routes.authHome);
                },
                child: const Text("Skip"),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.01),
                    foregroundColor: Colors.black),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextButton(
                onPressed: () {
                  liquidController.jumpToPage(
                      page: liquidController.currentPage + 1 > pages.length - 1
                          ? 0
                          : liquidController.currentPage + 1);
                },
                child: const Text("Next"),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.01),
                    foregroundColor: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}

class _Pages extends StatelessWidget {
  final Color color;
  final String anim;
  final String str1;
  final String str2;
  final String str3;

  const _Pages({
    super.key,
    required this.color,
    required this.anim,
    required this.str1,
    required this.str2,
    required this.str3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Lottie.asset(anim),
          const Padding(
            padding: EdgeInsets.all(24.0),
          ),
          Column(
            children: <Widget>[
              Text(
                str1,
                style: OnboardPage.style,
              ),
              Text(
                str2,
                style: OnboardPage.style,
              ),
              Text(
                str3,
                style: OnboardPage.style,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ExampleSlider extends StatefulWidget {
  const ExampleSlider({Key? key}) : super(key: key);

  @override
  State<ExampleSlider> createState() => _ExampleSliderState();
}

class _ExampleSliderState extends State<ExampleSlider> {
  double sliderVal = 0;

  @override
  Widget build(BuildContext context) {
    return Slider(
        value: sliderVal,
        activeColor: Colors.white,
        inactiveColor: Colors.red,
        onChanged: (val) {
          setState(() {
            sliderVal = val;
          });
        });
  }
}
