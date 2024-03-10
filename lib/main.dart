import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:layout/layout.dart';
import 'package:unicrush/firebase_options.dart';
import 'package:unicrush/presentation/route/routes.dart';

import 'presentation/utils/extensions/extensions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Get.put(ThemeController());

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
