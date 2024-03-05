import 'package:flutter/material.dart';
import 'package:productive_families/presentation/screens/home/widgets/suggestion_button.dart';
import 'package:productive_families/storage/firebase_storage.dart';

class SuggestionList extends StatefulWidget {
  const SuggestionList({Key? key}) : super(key: key);

  @override
  State<SuggestionList> createState() => _SuggestionListState();
}

class _SuggestionListState extends State<SuggestionList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: FutureBuilder(
        future: getAllStores(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ListView.separated(
                  itemCount: snapshot.data!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => SuggestionButton(
                      title: snapshot.data != null
                          ? snapshot.data![index]?.storeName ?? ""
                          : "",
                      onClick: () {},
                      isSelected: snapshot.data![index]?.storeName == "all"),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
