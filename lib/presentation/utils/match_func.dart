import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unicrush/model/matches.dart';
import 'package:unicrush/presentation/configs/configs.dart';
import 'package:unicrush/presentation/configs/constant_strings.dart';
import 'package:unicrush/presentation/utils/utils.dart';
import 'package:unicrush/services/current_user_data_service.dart';

void matchBtn(MatchModel match) {
  String matchEmail = match.email.toString();
  log(matchEmail);

  CollectionReference matchesCollection = FirebaseFirestore.instance
      .collection(FirestoreCollections.usersCollection)
      .doc(matchEmail)
      .collection(FirestoreCollections.matchesCollection);

  matchesCollection.doc(CurrentUserDataService().userModel!.email).set(
    {
      kcUid: match.uid,
      kcEmail: match.email,
      kcUserName: match.username,
      kcPhotos: match.userPhoto,
      kcMatchTime: match.matchTime,
    },
  ).then((_) {
    log('Match data added successfully');
  }).catchError((error) {
    log('Failed to add match data: $error');
  });
}
