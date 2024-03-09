import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindPageController extends GetxController {
  late TextEditingController searchController = TextEditingController();

  void resetSearch() {
    searchController.clear();
    update();
  }

  void filteredValues(String value) {
    log(value);
  }
}
