import 'package:flutter/material.dart';
import 'package:productive_families/main.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 6,
              color: Colors.black.withOpacity(0.3),
              blurStyle: BlurStyle.normal,
              offset: const Offset(0, 0)),
        ]),
        child: TextField(
          style: const TextStyle(color: Colors.black),
          autofocus: false,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 12),
            suffixIcon: const Icon(Icons.search),
            border: const OutlineInputBorder(),
            hintText: language.search,
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 3.0),
                borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white, width: 3.0),
            ),
          ),
        ),
      ),
    );
  }
}
