import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_assessment/controller/counter_controller.dart';
import 'package:tech_assessment/screens/message_screen.dart';
import 'package:tech_assessment/screens/offline_capabilities.dart';
import 'package:tech_assessment/screens/push_notification_screen.dart';
import 'package:tech_assessment/screens/weather_map_screen.dart';

import 'rest_api_screen.dart';


class HomeScreen extends StatelessWidget {
  final CounterController _counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Home Screen',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            GetBuilder<CounterController>(
              builder: (controller) {
                return Text(
                  'Counter: ${controller.counter.value}',
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _counterController.increment();
              },
              child: const Text('Increment'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(MessageScreen());
              },
              child: const Text('Go to Message Screen'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(RestApiScreen());
              },
              child: const Text('Go to API Screen'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(OfflineCapabilities());
              },
              child: const Text('Offline Capabilities'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(WeatherMapScreen());
              },
              child: const Text('Weather Map Screen'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(PushNotificationScreen());
              },
              child: const Text('Push Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
