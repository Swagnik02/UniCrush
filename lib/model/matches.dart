import 'package:unicrush/presentation/configs/constant_assets.dart';

class Match {
  String uid;
  String username;
  String userPhoto;
  DateTime matchTime;
  // UserModel user;

  Match({
    required this.uid,
    required this.username,
    required this.userPhoto,
    required this.matchTime,
    // required this.user,
  });

  static List<Match> matchList = [
    Match(
      uid: '1',
      username: 'user1',
      userPhoto: kauser1,
      matchTime: DateTime.now(),
      // user: users.firstWhere((user) => user.uid == '1'),
    ),
    Match(
      uid: '2',
      username: 'user2',
      userPhoto: kauser2,
      matchTime: DateTime.now(),
      // user: users.firstWhere((user) => user.uid == '2'),
    ),
    Match(
      uid: '3',
      username: 'user3',
      userPhoto: kauser3,
      matchTime: DateTime.now(),
      // user: users.firstWhere((user) => user.uid == '3'),
    ),
  ];
}
