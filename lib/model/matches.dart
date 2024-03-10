import 'package:unicrush/model/user_model.dart';
import 'package:unicrush/presentation/configs/constant_assets.dart';

class MatchModel {
  String uid;
  String? email;
  String username;
  String userPhoto;
  DateTime matchTime;

  UserModel? user;

  MatchModel({
    required this.uid,
    this.email,
    required this.username,
    required this.userPhoto,
    required this.matchTime,
    this.user,
  });

  static List<MatchModel> matchList = [
    MatchModel(
      uid: '1',
      username: 'user1',
      userPhoto: kauser1,
      matchTime: DateTime.now(),
      // user: users.firstWhere((user) => user.uid == '1'),
    ),
    MatchModel(
      uid: '2',
      username: 'user2',
      userPhoto: kauser2,
      matchTime: DateTime.now(),
      // user: users.firstWhere((user) => user.uid == '2'),
    ),
    MatchModel(
      uid: '3',
      username: 'user3',
      userPhoto: kauser3,
      matchTime: DateTime.now(),
      // user: users.firstWhere((user) => user.uid == '3'),
    ),
  ];
}
