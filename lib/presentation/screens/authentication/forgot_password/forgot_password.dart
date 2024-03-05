import 'package:flutter/material.dart';
import 'package:productive_families/auth.dart';
import 'package:productive_families/core/utils/common.dart';
import 'package:productive_families/main.dart';
import 'package:productive_families/presentation/screens/authentication/sign_in/sign_in_screen.dart';

import '../../../widgets/input_form_button.dart';
import '../../../widgets/input_text_button.dart';
import '../../../widgets/input_text_form_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 3, child: Image.asset("assets/images/new_logo.png")),
            Expanded(
              child: Text(
                language.pleaseAddEmailAndPass,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: InputTextFormField(
                controller: emailController,
                hint: language.email,
              ),
            ),
            Expanded(
              child: InputFormButton(
                onClick: () async {
                  Future.delayed(const Duration(seconds: 3), () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()),
                      (route) => false,
                    );
                    toast(language.checkYourInboxPlease);
                  });
                  await Auth().forgotPassword(email: emailController.text);
                },
                titleText: language.confirm,
              ),
            ),
            Expanded(
              child: InputTextButton(
                onClick: () {
                  Navigator.of(context).pop();
                },
                titleText: language.back,
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    ));
  }
}
