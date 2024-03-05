import 'package:flutter/material.dart';
import 'package:productive_families/data/models/user_model.dart';
import 'package:productive_families/main.dart';
import 'package:productive_families/storage/firebase_storage.dart';

import '../../../../widgets/input_form_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(language.profile),
      ),
      body: FutureBuilder<UserModel?>(
          future: getUser(),
          builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
            print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return const Text('no data');
              } else {
                UserModel userModel = snapshot.data!;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: ListView(
                    children: [
                      const Hero(
                        tag: "C001",
                        child: CircleAvatar(
                          radius: 75.0,
                          backgroundImage:
                              AssetImage('assets/user/profile-picture.png'),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Name:',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),

                          // const SizedBox(
                          //   width: 20,
                          // ),
                          Expanded(
                            child: Text(
                              userModel.name ?? "",
                              style: const TextStyle(fontSize: 40),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Age:',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              userModel.age.toString() ?? "",
                              style: const TextStyle(fontSize: 40),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Email:',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),

                          // const SizedBox(
                          //   width: 20,
                          // ),
                          Expanded(
                            child: Text(
                              userModel.email ?? "",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Gender:',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),

                          // const SizedBox(
                          //   width: 20,
                          // ),
                          Expanded(
                            child: Text(
                              userModel.gender ?? "",
                              style: const TextStyle(fontSize: 40),
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const Expanded(
                      //       child: Text(
                      //         'Stores:',
                      //         style: TextStyle(
                      //               fontSize: 30),
                      //       ),
                      //     ),

                      //     // const SizedBox(
                      //     //   width: 20,
                      //     // ),
                      //     Expanded(
                      //       child: Text(
                      //         1.toString() ?? "",
                      //         style: const TextStyle(
                      //               fontSize: 40),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.none) {
              return const Text('Error'); // error
            } else {
              return const Center(
                  child: CircularProgressIndicator()); // loading
            }
          }),
      bottomNavigationBar: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: InputFormButton(onClick: () {}, titleText: language.update),
      )),
    );
  }
}
