import 'package:unicrush/presentation/configs/constant_assets.dart';

class UserModel {
  String uid;
  String username;
  String? email;
  String? fullName;
  DateTime? dob;
  String? gender;
  String? school;
  String? clubs;
  String? photos;
  String? city;
  String? bio;

  UserModel({
    required this.uid,
    required this.username,
    this.email,
    this.fullName,
    this.dob,
    this.gender,
    this.school,
    this.clubs,
    this.photos,
    this.city,
    this.bio,
  });

  static List<UserModel> dummyUsers = [
    UserModel(
      uid: '1',
      username: 'user1',
      fullName: 'John Doe',
      dob: DateTime(1990, 10, 20),
      gender: 'Male',
      school: 'ABC School',
      clubs: 'Club1',
      photos: kauser1,
      city: 'New York',
      bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    UserModel(
      uid: '2',
      username: 'user2',
      fullName: 'Jane Smith',
      dob: DateTime(1995, 5, 15),
      gender: 'Female',
      school: 'XYZ School',
      clubs: 'Club3',
      photos: kauser2,
      city: 'Los Angeles',
      bio: 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    UserModel(
      uid: '3',
      username: 'user3',
      fullName: 'Michael Johnson',
      dob: DateTime(1987, 8, 25),
      gender: 'Male',
      school: 'PQR School',
      clubs: 'Club5',
      photos: kauser3,
      city: 'Chicago',
      bio:
          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    ),
    UserModel(
      uid: '4',
      username: 'user4',
      fullName: 'Emily Brown',
      dob: DateTime(1992, 4, 12),
      gender: 'Female',
      school: 'LMN School',
      clubs: 'Club6',
      photos: 'photo6.jpg',
      city: 'Houston',
      bio:
          'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
    ),
    UserModel(
      uid: '5',
      username: 'user5',
      fullName: 'William Taylor',
      dob: DateTime(1985, 12, 8),
      gender: 'Male',
      school: 'STU School',
      clubs: 'Club7',
      photos: 'photo7.jpg',
      city: 'Miami',
      bio:
          'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
    UserModel(
      uid: '6',
      username: 'user6',
      fullName: 'Olivia Wilson',
      dob: DateTime(1998, 6, 30),
      gender: 'Female',
      school: 'UVW School',
      clubs: 'Club8',
      photos: 'photo8.jpg',
      city: 'San Francisco',
      bio:
          'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.',
    ),
  ];
}
