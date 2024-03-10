import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unicrush/model/user_model.dart';
import 'package:unicrush/model/matches.dart';
import 'package:unicrush/presentation/utils/utils.dart';

import '../presentation/configs/configs.dart';

List<UserModel> usersList = [];
List<MatchModel> matchesList = [];

Future<void> fetchUsers() async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirestoreCollections.usersCollection)
        .get();

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic>? userData = doc.data() as Map<String, dynamic>?;
      if (userData != null) {
        UserModel user = UserModel(
          uid: userData[kcUid] ?? '',
          username: userData[kcUserName] ?? '',
          email: userData[kcEmail] ?? '',
          gender: userData[kcGender]?.toString() ?? '',
          school: userData[kcSchool]?.toString() ?? '',
          clubs: userData[kcClubs]?.toString() ?? '',
          photos: userData[kcPhotos]?.toString() ?? '',
        );
        usersList.add(user);
        log(user.username);
      }
    });
  } catch (e) {
    print('Error fetching users: $e');
  }
}
