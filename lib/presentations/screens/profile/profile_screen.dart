import 'package:firebase_project/data/remote/firebase/firebase_repository.dart';
import 'package:firebase_project/presentations/screens/auth/auth_provider.dart';
import 'package:firebase_project/presentations/screens/map/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FireBaseRepo().currentUser;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user?.email ?? "",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: context.read<AuthProvider>().logout,
                  child: const Text("Logout"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => MapScreen()));
                  },
                  child: const Text("GO TO MAP"),
                ),
              ]),
        ),
      ),
    );
  }
}
