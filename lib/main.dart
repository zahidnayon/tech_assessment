
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tech_assessment/service/firebase_api.dart';
import 'app.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyDgOVdZtvpj80g9Ai47R91R-FAqHa4G28E',
        appId: '1:78403230469:android:49e28ed7c25397c11f356c',
        messagingSenderId: '78403230469',
        projectId: 'techassessment-35fc5',
      ),
    );
    print('Firebase initialized successfully');

    // Initialize Firebase notifications
    await FirebaseApi().initNotifications();
    print('Notifications initialized successfully');

  } catch (e) {
    print('Error initializing Firebase: $e');
    // Handle initialization error
  }
  runApp(const MyApp());
}

