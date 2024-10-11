import 'package:bandoan/page/home_page.dart';
import 'package:bandoan/service/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? user = FirebaseAuth.instance.currentUser;

            if (user != null && !user.emailVerified) {
              // Email chưa được xác thực
              return AlertDialog(
                title: const Text("Email not verified"),
                content: const Text("Please verify your email before accessing the app."),
                actions: [
                  TextButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: const Text("OK"),
                  ),
                ],
              );
            } else {
              // Email đã được xác thực
              return const HomePage();
            }
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
