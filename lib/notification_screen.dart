import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static const route = '/notification-screen';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! RemoteMessage) {
      return const Scaffold(
        body: Center(
          child: Text(
            '📭 Aucune notification à afficher',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    final message = args;

    return Scaffold(
      appBar: AppBar(
        title: const Text('📩 Notification reçue'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.notification?.title ?? 'Sans titre',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message.notification?.body ?? 'Sans message',
              style: const TextStyle(fontSize: 16),
            ),
            const Divider(height: 32),
            const Text(
              '📦 Données associées :',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ...message.data.entries.map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text('• ${e.key} : ${e.value}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
