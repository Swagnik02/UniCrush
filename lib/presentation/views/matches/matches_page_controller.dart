import 'package:get/get.dart';
import 'package:unicrush/model/lists.dart';

class MatchesPageController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    fetchMatches();
  }
}
