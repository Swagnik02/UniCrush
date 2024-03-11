import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicrush/model/user_model.dart';
import 'package:unicrush/presentation/configs/configs.dart';
import 'package:unicrush/presentation/configs/constant_strings.dart';
import 'package:unicrush/presentation/route/routes.dart';
import 'package:unicrush/presentation/utils/utils.dart';
import 'package:unicrush/services/current_user_data_service.dart';

class ProfilePageController extends GetxController {
  late final TextEditingController universityController;
  late final TextEditingController clubController;
  late final TextEditingController cityController;
  late final TextEditingController dobController;
  @override
  void onInit() {
    super.onInit();
    universityController =
        TextEditingController(text: CurrentUserDataService().userModel?.school);
    clubController = TextEditingController(
        text: CurrentUserDataService().userModel?.clubs.toString());
    cityController =
        TextEditingController(text: CurrentUserDataService().userModel?.city);
    dobController = TextEditingController();
  }

  void saveProfile() {
    CurrentUserDataService().updateUserData(
      UserModel(
        uid: CurrentUserDataService().userModel!.uid,
        username: CurrentUserDataService().userModel!.username,
        clubs: clubController.text,
        school: universityController.text,
      ),
    );
  }

  void onTapLogOut() {
    FirebaseAuth.instance
        .signOut()
        .then((value) => Get.offAllNamed(Routes.authHome));
    log('Logged Out');
  }

  void addUserToFirestore() async {
    String email = 'John1234@gmail.com';
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection(FirestoreCollections.usersCollection)
        .doc(email);

    try {
      await userDocRef.set({
        kcUid: 'uid04',
        kcEmail: email,
        kcUserName: 'John',
        kcGender: 'Male',
        kcSchool: 'IIIT BBSR',
        kcClubs: 'PSOC',
        kcPhotos: 'photourl',
      });
      print('User added to Firestore successfully.');
    } catch (e) {
      print('Error adding user to Firestore: $e');
    }
  }

  void matchBtn() {
    String matchEmail = CurrentUserDataService().userModel!.email.toString();
    log(matchEmail);

    CollectionReference matchesCollection = FirebaseFirestore.instance
        .collection(FirestoreCollections.usersCollection)
        .doc(matchEmail)
        .collection(FirestoreCollections.matchesCollection);

    matchesCollection.doc(CurrentUserDataService().userModel!.email).set(
      {
        kcUid: 'uid04',
        kcEmail: 'John1234@gmail.com',
        kcUserName: 'John',
        kcPhotos:
            'https://firebasestorage.googleapis.com/v0/b/test-1e674.appspot.com/o/profilePhotos%2Fuser1.png?alt=media&token=072cca9e-0f6f-4dfd-9ea0-a0900e965b91',
        kcMatchTime: DateTime.now(),
      },
    ).then((_) {
      log('Match data added successfully');
    }).catchError((error) {
      log('Failed to add match data: $error');
    });
  }
}
