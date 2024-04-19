import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LocalNotificationService {
  static showMessage(Map<Object?, dynamic> data) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        customSound: 'resource://raw/a',
        locked: false,
        id: DateTime.now().millisecond,
        channelKey: 'pushnotificationapp',
        wakeUpScreen: true,
        title: data['title'].toString(),
        body: data['body'].toString(),
        // payload: {
        //   'go to': data['data']['go to'].toString(),
        // },
      ),
    );
  }

  static sendMessage(Map<String, String>? data) async {
    await FirebaseMessaging.instance.subscribeToTopic('a');
    await FirebaseMessaging.instance.sendMessage(
        to: 'a',
        messageType: 'good',
        ttl: 1,
        messageId: Timestamp.fromMicrosecondsSinceEpoch.toString(),
        data: {
          'notification': jsonEncode({
            'title': data!['title'] ?? 'Default Title',
            'body': data['body'] ?? 'Default Body'
          }),
        });
  }
}
