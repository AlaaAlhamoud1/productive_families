import 'package:flutter/material.dart';

class OtherItemCard extends StatelessWidget {
  final String title;
  final Function()? onClick;
  const OtherItemCard({
    Key? key,
    required this.title,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 6,
              spreadRadius: 1,
              color: Colors.black.withOpacity(0.1),
              blurStyle: BlurStyle.normal,
              offset: const Offset(0, 0)),
        ]),
        child: InkWell(
          onTap: onClick,
          child: Card(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: Color(0xFF4AC382)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
