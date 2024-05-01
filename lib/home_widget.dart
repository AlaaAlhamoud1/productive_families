import 'package:flutter/material.dart';
import 'package:productive_families/core/values/values.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 4, child: Image.asset('assets/images/new_logo.png')),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Welcom to',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
                  Expanded(
                    child: Text('Potea',
                        style: TextStyle(
                            fontSize: 50,
                            color: AppColors.appColor,
                            fontWeight: FontWeight.w900)),
                  ),
                  const Expanded(
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
        ],
      ),
    );
  }
}
