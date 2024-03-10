import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unicrush/presentation/utils/utils.dart';
import 'package:unicrush/presentation/views/auth/login/login_page.dart';
import 'package:unicrush/presentation/views/home/home_page.dart';

class AuthHome extends StatelessWidget {
  const AuthHome({super.key});

  @override
  Widget build(BuildContext context) {
    final stream = FirebaseAuth.instance.authStateChanges();

    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (ConnectionState.waiting == snapshot.connectionState) {
          return Utils.customLoadingSpinner();
        } else if (snapshot.hasError) {
          // Handle error scenario
          return const Center(
            child: Text('An error occurred!'),
          );
        } else if (snapshot.hasData) {
          return HomePage();
        }
        return LoginPage();
      },
    );
  }
}
