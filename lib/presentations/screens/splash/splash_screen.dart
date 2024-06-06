import 'package:firebase_project/data/remote/firebase/fcm_repository.dart';
import 'package:firebase_project/presentations/screens/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    setupFCM();
    context.read<AuthProvider>().checkLoggedUser();
    super.initState();
  }

  void setupFCM() async {
    await FCMRepo.instance.requestPermission();
    await FCMRepo.instance.getToken();
    FCMRepo.instance.onMessage();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Text("FIREBASE EXAMPLE"),
      )),
    );
  }
}
