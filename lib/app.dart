import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_assessment/main.dart';
import 'package:tech_assessment/screens/home_screen.dart';
import 'package:tech_assessment/screens/message_screen.dart';
import 'package:tech_assessment/screens/offline_capabilities.dart';
import 'package:tech_assessment/screens/push_notification_screen.dart';
import 'package:tech_assessment/screens/rest_api_screen.dart';
import 'package:tech_assessment/screens/weather_map_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Technical Assessment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () =>  HomeScreen()),
        GetPage(name: '/message', page: () => const MessageScreen()),
        GetPage(name: '/restapi', page: () =>  RestApiScreen()),
        GetPage(name: '/offline', page: () =>  OfflineCapabilities()),
        GetPage(name: '/weather', page: () =>  const WeatherMapScreen()),
        GetPage(name: PushNotificationScreen.route, page: () => const PushNotificationScreen()),
      ],
    );
  }
}
