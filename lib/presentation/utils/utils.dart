import 'package:flutter/material.dart';

class GlobalUtil {
  // test user credentials

  static int? isViewed;
  static const String onBordingToken = '';
}

class Utils {
  static Widget customLoadingSpinner() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class FirestoreCollections {
  static const String usersCollection = "users";
  static const String matchesCollection = "matches";
}
