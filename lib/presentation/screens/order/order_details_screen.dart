import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:productive_families/data/models/product_model.dart';
import 'package:productive_families/main.dart';
import 'package:shimmer/shimmer.dart';

import '../../../business_logic/cubit/order_place/order_place_cubit.dart';
import '../../widgets/input_form_button.dart';
import '../../widgets/outline_label_card.dart';

class OrderDetailsScreen extends StatelessWidget {
  final List<ProductModel> products;
  const OrderDetailsScreen({Key? key, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => OrderPlaceCubit(),
        child: BlocListener<OrderPlaceCubit, OrderPlaceState>(
            listener: (context, state) {
              EasyLoading.dismiss();
              if (state is OrderPlaceLoading) {
                EasyLoading.show(status: '${language.loading}...');
              } else if (state is OrderPlaceSuccess) {
                EasyLoading.showSuccess("${language.orderPlaceSuccess}!");
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(language.orderDetails),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    OutlineLabelCard(
                      title: language.selectedProducts,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18, bottom: 8),
                        child: Column(
                          children: products
                              .map((product) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: FutureBuilder(
                                        future:
                                            getImageUrl(product.image ?? ""),
                                        builder: (context, snapshot) {
                                          return Row(
                                            children: [
                                              SizedBox(
                                                width: 75,
                                                child: AspectRatio(
                                                  aspectRatio: 0.88,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: snapshot.data != null
                                                        ? Image.network(
                                                            snapshot.data!,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Shimmer.fromColors(
                                                            baseColor: Colors
                                                                .grey
                                                                .withOpacity(
                                                                    0.8),
                                                            highlightColor:
                                                                Colors.grey
                                                                    .withOpacity(
                                                                        0.2),
                                                            child: Container(
                                                                color:
                                                                    Colors.grey,
                                                                width: double
                                                                    .infinity),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      product.name!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge,
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    // Text(
                                                    //     '\$${product.price.toStringAsFixed(2)}')
                                                  ],
                                                ),
                                              )
                                            ],
                                          );
                                        }),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    OutlineLabelCard(
                      title: language.deliveryDetails,
                      child: Container(
                        padding: const EdgeInsets.only(top: 12, bottom: 8),
                        child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Latoya M. Jones"),
                              Text("3033 Sumner Street"),
                              Text("Gardena, CA 90247"),
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    OutlineLabelCard(
                      title: language.selectedProducts,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(language.totalNumberOfItems),
                                Text("x${products.length}")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(language.totalPrice),
                                Text(
                                    "\$${products.fold(0.0, (previousValue, element) => element.price!.toDouble())}")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(language.deliveryCharge),
                                const Text("\$4.99")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(language.total),
                                Text(
                                    "\$${(products.fold(0.0, (previousValue, element) => element.price!.toDouble()) + 4.99)}")
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Builder(builder: (context) {
                    return InputFormButton(
                      onClick: () {
                        var orderPlaceBloc = context.read<OrderPlaceCubit>();
                        orderPlaceBloc.placeOrder();
                      },
                      titleText: language.confirm,
                    );
                  }),
                ),
              ),
            )));
  }
}

Future<String> getImageUrl(String imagePath) async {
  try {
    final storageRef = FirebaseStorage.instance.ref().child(imagePath);
    return await storageRef.getDownloadURL();
  } catch (e) {
    print("Error getting image URL: $e");
    return ""; // Return an empty string or some default URL in case of an error
  }
}
