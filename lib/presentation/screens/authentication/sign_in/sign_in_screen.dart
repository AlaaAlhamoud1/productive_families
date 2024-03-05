import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:productive_families/auth.dart';
import 'package:productive_families/core/utils/common.dart';
import 'package:productive_families/data/local_data/shared_pref.dart';
import 'package:productive_families/main.dart';
import 'package:productive_families/presentation/screens/authentication/forgot_password/forgot_password.dart';
import 'package:productive_families/presentation/screens/authentication/sign_up/sign_up_screen.dart';

import '../../../widgets/input_form_button.dart';
import '../../../widgets/input_text_form_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? errorMessage = '';
  bool isLogIn = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword(
      {required String email, required String pass}) async {
    try {
      await Auth().signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.message.toString().characters.length < 50) {
        print(e.message.toString().characters.length);
        toast(e.message);
      } else {
        toast('check your internet');
      }
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      if (e.message.toString().characters.length < 50) {
        print(e.message.toString().characters.length);
        toast(e.message);
      }
    }
  }

  @override
  void initState() {
    EasyLoading.dismiss();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("assets/images/new_logo.png"),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InputTextFormField(
                    controller: _controllerEmail,
                    hint: language.email,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InputTextFormField(
                      controller: _controllerPassword,
                      hint: language.password,
                      isSecureField: true,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(language.forgetPassword),
                  )
                ],
              ),
              InputFormButton(
                onClick: () async {
                  await EasyLoading.show(status: language.loading);
                  signInWithEmailAndPassword(
                    email: _controllerEmail.text,
                    pass: _controllerPassword.text,
                  ).then(
                    (value) async {
                      await setValue('ID', _controllerEmail.text);
                      EasyLoading.dismiss();
                    },
                  );
                },
                titleText: language.signIn,
              ),
              Row(
                children: [
                  Text(language.dontHaveAnAccount),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(language.register))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
