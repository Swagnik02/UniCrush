import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:layout/layout.dart';
import 'package:unicrush/presentation/route/routes.dart';
import 'package:unicrush/presentation/views/auth/login/login_page.dart';
import 'package:unicrush/presentation/views/auth/onboard/onboard_page.dart';
import 'package:unicrush/presentation/views/auth/signup/signup_page.dart';
import 'package:unicrush/presentation/views/find/find_page.dart';
import 'package:unicrush/presentation/views/home/home_page.dart';
import 'package:unicrush/presentation/views/matches/matches_page.dart';
import 'package:unicrush/presentation/views/profile/profile_page.dart';

import 'presentation/utils/extensions/extensions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //     );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Get.put(ThemeController()); // Initialize the theme controller

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetMaterialApp(
        title: 'UniMatch',
        defaultTransition: Transition.fadeIn,
        debugShowCheckedModeBanner: false,
        theme: Get.find<ThemeController>().themeData,
        initialRoute: initialRoute,
        getPages: routes,
      ),
    );
  }

  final String initialRoute = Routes.home;
}

final List<GetPage> routes = [
  // auth
  GetPage(name: Routes.onboard, page: () => OnboardPage()),
  GetPage(name: Routes.login, page: () => LoginPage()),
  GetPage(name: Routes.signup, page: () => SignUpPage()),

  // bottom nav
  GetPage(name: Routes.home, page: () => HomePage()),

  // main pages
  GetPage(name: Routes.matches, page: () => MatchesPage()),
  GetPage(name: Routes.find, page: () => FindPage()),
  GetPage(name: Routes.profile, page: () => ProfilePage()),
];



/* 


    TextStyle? titleTextStyle = context.adaptive(
      Theme.of(context).textTheme.titleMedium,
      Theme.of(context).textTheme.headlineSmall,
      md: Theme.of(context).textTheme.titleLarge,
    );

    */