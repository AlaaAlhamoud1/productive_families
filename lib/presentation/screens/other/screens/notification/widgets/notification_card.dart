import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Odio morbi quis commodo odio aenean sed adipiscing diam. In hac habitasse platea dictumst. Lectus arcu bibendum at varius vel. Varius sit amet mattis vulputate enim nulla."),
              ]),
        ),
      ),
    );
  }
}
