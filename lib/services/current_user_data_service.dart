import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicrush/model/user_model.dart';
import 'package:unicrush/presentation/configs/configs.dart';
import 'package:unicrush/presentation/utils/utils.dart';

class CurrentUserDataService {
  static final CurrentUserDataService _instance =
      CurrentUserDataService._internal();

  factory CurrentUserDataService() {
    return _instance;
  }

  CurrentUserDataService._internal();

  UserModel? _userModel;

  UserModel? get userModel => _userModel;
  Future<void> fetchUserData(String userEmail) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        // User not authenticated
        return;
      }

      String userEmail = currentUser.email ?? "";
      if (userEmail.isEmpty) {
        // Email not available
        return;
      }

      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection(FirestoreCollections.usersCollection);
      QuerySnapshot querySnapshot =
          await usersCollection.where('email', isEqualTo: userEmail).get();

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot productDocument in querySnapshot.docs) {
          Map<String, dynamic> userData =
              productDocument.data() as Map<String, dynamic>;

          _userModel = UserModel(
            uid: userData[kcUid].toString(),
            email: userData[kcEmail]?.toString() ?? '',
            username: userData[kcUserName]?.toString() ?? '',
            fullName: userData[kcFullName]?.toString() ?? '',
            dob: userData[kcDob] != null
                ? DateTime.parse(userData[kcDob])
                : null,
            gender: userData[kcGender]?.toString() ?? '',
            school: userData[kcSchool]?.toString() ?? '',
            clubs: userData[kcClubs] != null
                ? List<String>.from(userData[kcClubs])
                : null,
            photos: userData[kcPhotos] != null
                ? List<String>.from(userData[kcPhotos])
                : null,
            city: userData[kcCity]?.toString() ?? '',
            bio: userData[kcBio]?.toString() ?? '',
          );

          log('Users Data for $userEmail: $userData');
        }
      } else {
        // User not found
        _userModel = null;
      }
    } catch (e) {
      // Handle specific Firestore exceptions
      log('Error collecting user data: $e');
    }
  }

  void storeUserDataLocally() {
    if (_userModel != null) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString(kcEmail, _userModel?.email ?? '');
        prefs.setString(kcUserName, _userModel!.username);
        prefs.setString(kcUid, _userModel?.uid ?? '');
        prefs.setString(kcCity, _userModel?.city ?? '');
        prefs.setString(kcFullName, _userModel?.fullName ?? '');
        prefs.setString(kcGender, _userModel?.gender ?? '');
        prefs.setString(kcSchool, _userModel?.school ?? '');
        prefs.setStringList(kcClubs, _userModel?.clubs ?? []);
        prefs.setStringList(kcPhotos, _userModel?.photos ?? []);
        prefs.setString(kcBio, _userModel?.bio ?? '');
      });
    }
  }

  // Add a method to retrieve user data from local storage
  Future<void> retrieveUserDataLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString(kcEmail) ?? "";

    if (userEmail.isNotEmpty) {
      await fetchUserData(userEmail);
    }
  }

  Future<void> updateUserData(UserModel updatedUserData) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return;
      }
      String userEmail = currentUser.email ?? "";
      if (userEmail.isEmpty) {
        return;
      }
      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection(FirestoreCollections.usersCollection);
      await usersCollection.doc(userEmail).update({
        kcCity: updatedUserData.city,
        kcUserName: updatedUserData.username,
        kcFullName: updatedUserData.fullName,
        kcGender: updatedUserData.gender,
        kcSchool: updatedUserData.school,
        kcClubs: updatedUserData.clubs,
        kcPhotos: updatedUserData.photos,
        kcBio: updatedUserData.bio,
        // kcUid: updatedUserData.uid,
        // kcEmail: updatedUserData.email,
        // kcDob: updatedUserData.dob?.toIso8601String(),
      });

      // Update local data
      _userModel = updatedUserData;
      storeUserDataLocally();

      // Retrieve updated user data locally
      await retrieveUserDataLocally();
    } catch (e) {
      // Handle specific Firestore exceptions
      log('Error updating user data: $e');
    }
  }

  Future<void> clearUserDataLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _userModel = null;
  }
}
