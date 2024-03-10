import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:layout/layout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicrush/firebase_options.dart';
import 'package:unicrush/model/lists.dart';
import 'package:unicrush/presentation/route/routes.dart';
import 'package:unicrush/presentation/utils/utils.dart';
import 'package:unicrush/services/current_user_data_service.dart';

import 'presentation/utils/extensions/extensions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Retrieve user data from local storage
  await CurrentUserDataService().retrieveUserDataLocally();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  GlobalUtil.isViewed = prefs.getInt(GlobalUtil.onBordingToken);
  fetchUsers();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Get.put(ThemeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

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

  final String initialRoute =
      GlobalUtil.isViewed == 0 || GlobalUtil.isViewed == null
          ? Routes.onboard
          : Routes.authHome;
}
