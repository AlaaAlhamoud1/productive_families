import 'package:flutter/material.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:productive_families/auth.dart';
import 'package:productive_families/presentation/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:productive_families/presentation/screens/main/main_screen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        print(snapshot.hasData);
        if (snapshot.hasData) {
          EasyLoading.dismiss();
          return const MainScreen();
        } else {
          EasyLoading.dismiss();
          return const SignInScreen();
        }
      },
      stream: Auth().authStateChanges,
    );
  }
}
