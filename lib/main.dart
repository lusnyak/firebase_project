import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_project/data/remote/firebase/fcm_repository.dart';
import 'package:firebase_project/presentations/screens/auth/auth_provider.dart';
import 'package:firebase_project/presentations/screens/auth/auth_screen.dart';
import 'package:firebase_project/presentations/screens/splash/splash_screen.dart';
import 'package:firebase_project/presentations/screens/users/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

GlobalKey<NavigatorState> navigationStateKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => debugPrint(value.options.appId));

  FCMRepo.instance.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // initFirebase();
    super.initState();
  }

  initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((value) => debugPrint(value.options.appId));
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => UsersProvider())
    ],
      child: MaterialApp(
        navigatorKey: navigationStateKey,
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
            useMaterial3: true,
        ),
        home: const SplashScreen(

        ),
      )
    );
  }
}