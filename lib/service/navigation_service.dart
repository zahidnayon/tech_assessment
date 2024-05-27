import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._privateConstructor();

  static final NavigationService _instance = NavigationService._privateConstructor();

  factory NavigationService() {
    return _instance;
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
