import 'package:get/get.dart';
import 'package:unicrush/presentation/views/auth/login/login_page.dart';
import 'package:unicrush/presentation/views/auth/onboard/onboard_page.dart';
import 'package:unicrush/presentation/views/auth/signup/signup_page.dart';
import 'package:unicrush/presentation/views/find/find_page.dart';
import 'package:unicrush/presentation/views/home/home_page.dart';
import 'package:unicrush/presentation/views/matches/matches_page.dart';
import 'package:unicrush/presentation/views/profile/profile_page.dart';

class Routes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String onboard = '/onboard';
  static const String home = '/home';
  static const String matches = '/matches';
  static const String find = '/find';
  static const String profile = '/profile';
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
