import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicrush/model/lists.dart';
import 'package:unicrush/model/matches.dart';
import 'package:unicrush/model/user_model.dart';
import 'package:unicrush/presentation/configs/configs.dart';
import 'package:unicrush/presentation/widgets/profile_tiles.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Stack(
        children: [
          // top
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  color: kBackground,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      // width: Get.width / 5,
                      height: 30,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      decoration: BoxDecoration(
                          color: kPrimary.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Matches',
                        style: TextStyle(
                            color: kBackground,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // mainbody
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Material(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(35),
                topLeft: Radius.circular(35),
              ),
              color: kPrimary,
              elevation: 5,
              child: Container(
                  padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  width: Get.width,
                  child: _matchesListBody()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _matchesListBody() {
    double aspectRatio = 1 / 1.35;
    return FutureBuilder<List<MatchModel>>(
      future: Future.value(matchesList),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<MatchModel>? matches = snapshot.data;
          if (matches == null || matches.isEmpty) {
            return const Center(child: Text('No data found'));
          }
          return SizedBox(
            // color: Colors.red,
            height: Get.height,
            child: GridView.builder(
              primary: false,
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: aspectRatio,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
              ),
              itemCount: matches.length,
              itemBuilder: (context, index) {
                MatchModel match = matches[index];
                String uid = match.uid;
                UserModel user =
                    usersList.firstWhere((user) => user.uid == uid);
                return ProfileTiles(user: user);
              },
            ),
          );
        }
      },
    );
  }
}
