import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:productive_families/app_store/app_store.dart';
import 'package:productive_families/core/values/constant.dart';
import 'package:productive_families/core/values/values.dart';
import 'package:productive_families/data/local_data/shared_pref.dart';
import 'package:productive_families/data/models/product_model.dart';
import 'package:productive_families/main.dart';

class CartProductCard extends StatelessWidget {
  final ProductModel product;
  const CartProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getImageUrl(product.image!),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 0.88,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        snapshot.data ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        product.name ?? "",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        product.description ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(
                          (getStringAsync(SELECTED_LANGUAGE_CODE) == '')
                              ? (platformDispatcher.locale.languageCode == 'en')
                                  ? Icons.keyboard_double_arrow_right_outlined
                                  : Icons.keyboard_double_arrow_left_sharp
                              : getStringAsync(SELECTED_LANGUAGE_CODE) == 'en'
                                  ? Icons.keyboard_double_arrow_right_outlined
                                  : Icons.keyboard_double_arrow_left_sharp,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                    Text(
                      language.swap,
                      style: TextStyle(color: AppColors.appColor),
                    )
                  ],
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<String> getImageUrl(String imagePath) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child(imagePath);
      return await storageRef.getDownloadURL();
    } catch (e) {
      print("Error getting image URL: $e");
      return "";
    }
  }
}
