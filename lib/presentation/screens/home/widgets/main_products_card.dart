import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:productive_families/presentation/screens/product/product_screens.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../data/models/product_model.dart';
import '../../../widgets/favorite_products_button.dart';

class MainProductCard extends StatelessWidget {
  final ProductModel product;
  final Function onFavoriteToggle;
  const MainProductCard({
    Key? key,
    required this.product,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getImageUrl(product.image ?? ""),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductScreen(product: product),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Card(
                            color: Colors.black,
                            elevation: 5,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Material(
                              child: GridTile(
                                footer: Container(),
                                child: snapshot.data == null
                                    ? Image.asset(
                                        'assets/images/broken_image.png',
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network(
                                        snapshot.data!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorBuilder:
                                            (context, exception, stackTrace) {
                                          return Image.asset(
                                            'assets/images/broken_image.png',
                                            width: double.infinity,
                                            fit: BoxFit.fill,
                                          );
                                        },
                                        frameBuilder:
                                            (context, child, frame, loaded) {
                                          if (frame != null) {
                                            return child;
                                          } else {
                                            return Shimmer.fromColors(
                                                baseColor: Colors.grey
                                                    .withOpacity(0.8),
                                                highlightColor: Colors.grey
                                                    .withOpacity(0.2),
                                                child: Container(
                                                    color: Colors.grey,
                                                    width: double.infinity));
                                          }
                                        },
                                      ),
                                //  Image.network(
                                //   snapshot.data ?? "",
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                            child: snapshot.data != null
                                ? Text(
                                    product.name!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  )
                                : shimmer(height: 10, horizontalPadding: 20)),
                        // const Padding(
                        //   padding: EdgeInsets.fromLTRB(4, 15, 4, 0),
                        //   child: Row(
                        //     children: [
                        // snapshot.data != null
                        //     ? Text(
                        //         r'$' + product.price.toString(),
                        //         style: const TextStyle(
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.w600,
                        //           // color: product.discountPrice == null
                        //           //     ? Colors.black87
                        //           //     : Colors.grey,
                        //           // decoration: product.discountPrice == null
                        //           //     ? null
                        //           //     : TextDecoration.lineThrough,
                        //         ),
                        //   )
                        // : shimmer(height: 10, horizontalPadding: 20),
                        // product.discountPrice == null
                        //     ? const SizedBox()
                        //     : Text(
                        //         ' \$${product.discountPrice}',
                        //         style: const TextStyle(
                        //             fontSize: 16, fontWeight: FontWeight.w600),
                        //       )
                        //   ],
                        // ),
                        // )
                      ],
                    ),
                    Positioned(
                      top: 10,
                      right: 0,
                      child: FavoriteProductButton(
                        product: product,
                      ),
                    ),
                  ],
                ),
              ),
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

  Widget shimmer(
      {int? verticalPadding, int? horizontalPadding, required double height}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: (horizontalPadding ?? 0.0).toDouble(),
          vertical: (verticalPadding ?? 0).toDouble()),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.8),
        highlightColor: Colors.grey.withOpacity(0.2),
        child: Container(
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            height: height,
            width: double.infinity),
      ),
    );
  }
}
