import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationScreen extends StatelessWidget {
  static const route = '/notification';

  const PushNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RemoteMessage? message = ModalRoute.of(context)?.settings.arguments as RemoteMessage?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notification'),
      ),
      body: Center(
        child: message != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Title: ${message.notification?.title}'),
            Text('Body: ${message.notification?.body}'),
            Text('Payload: ${message.data}'),
          ],
        )
            : const Text('No message received.'),
      ),
    );
  }
}
