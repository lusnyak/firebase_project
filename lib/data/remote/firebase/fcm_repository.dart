import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class FCMRepo {
  FCMRepo._();
  static FCMRepo? _instance;
  static FCMRepo get instance {
    return _instance ?? FCMRepo._();
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> requestPermission() async {
    await messaging.setAutoInitEnabled(true);
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint(settings.authorizationStatus.toString());
  }

  Future<void> getToken() async {
    final fcmToken = await messaging.getToken();
    debugPrint("fcmToken - $fcmToken");
  }

  onBackgroundMessage(BackgroundMessageHandler handler) =>
    FirebaseMessaging.onBackgroundMessage(handler);

  onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint("onMessage");

      debugPrint("${message.toMap()}");
      debugPrint("${message.notification?.title}");
      debugPrint("${message.notification?.body}");
    });
  }
}
