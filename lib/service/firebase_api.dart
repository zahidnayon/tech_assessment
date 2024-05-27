import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tech_assessment/main.dart';
import 'package:tech_assessment/screens/push_notification_screen.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
  print("Payload: ${message.data}");
}

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final AndroidNotificationChannel _androidChannel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notification',
    description: 'This channel is used for important notifications',
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin _localNotification = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      PushNotificationScreen.route,
      arguments: message,
    );
  }

  Future<void> initLocalNotification() async {
    const DarwinInitializationSettings ios = DarwinInitializationSettings();
    const AndroidInitializationSettings android = AndroidInitializationSettings('@drawable/ic_launcher');
    const InitializationSettings settings = InitializationSettings(android: android, iOS: ios);

    await _localNotification.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          final message = RemoteMessage.fromMap(jsonDecode(response.payload!));
          handleMessage(message);
        }
      },
    );

    final platform = _localNotification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initNotifications() async {
    // Request permissions for notifications
    await _firebaseMessaging.requestPermission();

    // Get the FCM token
    final fcmToken = await _firebaseMessaging.getToken();
    print("Token: $fcmToken");

    await initLocalNotification();

    // Configure foreground notification presentation options
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle messages when the app is in the background or terminated
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // Handle messages when the app is opened from a terminated state
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // Handle messages when the app is opened from the background
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // Handle messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }
}
