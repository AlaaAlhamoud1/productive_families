import 'package:flutter/material.dart';
import 'package:productive_families/main.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language.about),
      ),
      body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "",
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ],
            ),
          )),
    );
  }
}
