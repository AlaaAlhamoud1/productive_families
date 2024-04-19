import 'dart:async';

import 'package:flutter/material.dart';
import 'package:productive_families/widget_tree.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WidgetTree(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(flex: 4, child: Image.asset('assets/images/new_logo.png')),
        const Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.only(left: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcom to',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
                Expanded(
                  child: Text('Potea',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 50,
                          color: Color(0xFF4AC382),
                          fontWeight: FontWeight.w900)),
                ),
                Expanded(
                  child: SizedBox(
                    width: 350,
                    child: Text(
                        'The best plant e-commerce & online store app of the contury for your needs!',
                        style: TextStyle(fontSize: 13)),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
