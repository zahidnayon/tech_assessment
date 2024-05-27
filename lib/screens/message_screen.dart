import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Screen'),
      ),
      body: Center(
        child: const Text(
          'Hello from the new screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}