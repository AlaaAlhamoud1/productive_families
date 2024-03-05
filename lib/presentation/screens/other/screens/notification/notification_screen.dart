import 'package:flutter/material.dart';
import 'package:productive_families/main.dart';

import 'widgets/notification_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language.notificaitons),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: const [
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
          ],
        ),
      ),
    );
  }
}
