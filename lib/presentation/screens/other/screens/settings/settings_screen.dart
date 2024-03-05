// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productive_families/app_store/app_store.dart';
import 'package:productive_families/configure_di.dart';
import 'package:productive_families/core/logic/global_bloc.dart';
import 'package:productive_families/core/themes/app_theme.dart';
import 'package:productive_families/core/values/constant.dart';
import 'package:productive_families/data/local_data/shared_pref.dart';
import 'package:productive_families/main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InputDecorationWidget(
                label: language.general,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(language.currency),
                      const Text("USD"),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(language.deliveryAddress)),
                      const Text("3033 Sumner Street"),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(language.language),
                      DropdownMenu(
                          initialSelection: (getStringAsync(
                                      SELECTED_LANGUAGE_CODE) ==
                                  '')
                              ? (platformDispatcher.locale.languageCode == 'en')
                                  ? 1
                                  : 2
                              : (getStringAsync(SELECTED_LANGUAGE_CODE) == 'en')
                                  ? 1
                                  : 2,
                          onSelected: (value) {
                            if (value == 1) {
                              getIt<AppStore>().setLanguage('en');
                              setValue(SELECTED_LANGUAGE_CODE, 'en');
                              BlocProvider.of<GlobalBloc>(context).add(
                                LanguageChanged('en'),
                              );
                            } else {
                              getIt<AppStore>().setLanguage('ar');
                              setValue(SELECTED_LANGUAGE_CODE, 'ar');
                              BlocProvider.of<GlobalBloc>(context).add(
                                LanguageChanged('ar'),
                              );
                            }
                            setState(() {});
                          },
                          textStyle: const TextStyle(fontSize: 10),
                          dropdownMenuEntries: const [
                            DropdownMenuEntry(
                              value: 1,
                              label: 'English',
                              style: ButtonStyle(
                                textStyle: MaterialStatePropertyAll(
                                  TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            DropdownMenuEntry(
                              value: 2,
                              label: 'العربية',
                              style: ButtonStyle(
                                textStyle: MaterialStatePropertyAll(
                                  TextStyle(fontSize: 10),
                                ),
                              ),
                            )
                          ])
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InputDecorationWidget(
                label: language.notificaitons,
                children: [
                  customSwitchWidget(language.order),
                  customSwitchWidget(language.promotion),
                  customSwitchWidget(language.newArrival)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customSwitchWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        Switch(
          activeTrackColor: AppTheme.darkPrimaryColor,
          value: true,
          activeColor: const Color(0xffcc9c1d),
          onChanged: (bool value) {
            debugPrint(getStringAsync(SELECTED_LANGUAGE_CODE));
          },
        )
      ],
    );
  }
}

class InputDecorationWidget extends StatelessWidget {
  final String label;
  final List<Widget> children;
  const InputDecorationWidget({
    Key? key,
    required this.label,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Color(0xffcc9c1d)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 24, left: 8, bottom: 16, right: 12),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children),
      ),
    );
  }
}
