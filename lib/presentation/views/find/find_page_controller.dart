import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicrush/model/lists.dart';
import 'package:unicrush/model/user_model.dart';
import 'package:unicrush/services/current_user_data_service.dart';

class FindPageController extends GetxController {
  late TextEditingController searchController = TextEditingController();
  List<UserModel> searchList = usersList
      .where((user) =>
          user.clubs == CurrentUserDataService().userModel!.clubs &&
          user.email != CurrentUserDataService().userModel!.email.toString())
      .toList();

  void resetSearch() {
    searchController.clear();
    update();
  }

  void filteredValues(String value) {
    log(value);
  }
}
