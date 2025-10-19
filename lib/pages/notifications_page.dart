import 'package:flutter/material.dart';


class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> notifications = [
      "You’ve successfully registered for Flutter for Beginners!",
      "Your next class starts on Monday, 10:00 AM.",
      "New course available: Data Science with Python!",
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications'), backgroundColor: const Color(0xFFFFC857)),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.notifications_active_outlined, color: Colors.orange),
          title: Text(notifications[index]),
        ),
      ),
    );
  }
}
