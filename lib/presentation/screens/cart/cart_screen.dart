import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:productive_families/data/models/product_model.dart';
import 'package:productive_families/main.dart';
import 'package:productive_families/presentation/screens/order/screens/order_details_screen.dart';

import '../../../business_logic/blocs/cart/cart_bloc.dart';
import 'components/cart_product_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartLoaded) {
            if (state.products.isNotEmpty) {
              return Stack(
                children: [
                  ListView.builder(
                      itemCount: state.products.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Dismissible(
                          onDismissed: (val) {
                            BlocProvider.of<CartBloc>(context)
                                .add(RemoveCart(index: index));
                          },
                          key: UniqueKey(),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child:
                                CartProductCard(product: state.products[index]),
                          ),
                        );
                      }),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(4.0),
                                bottomRight: Radius.circular(4.0),
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                              color: Colors.black.withOpacity(0.55)),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${language.totalNumbersItems} :",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "x${state.products.length}",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${language.totalPrice} :",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      sum(state.products).toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetailsScreen(
                                  products: state.products,
                                  
                                  isCart: true,
                                ),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 20)),
                            maximumSize: MaterialStateProperty.all<Size>(
                                const Size(double.maxFinite, 50)),
                            minimumSize: MaterialStateProperty.all<Size>(
                                const Size(double.maxFinite, 50)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(32.0),
                                  bottomRight: Radius.circular(32.0),
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                            ),
                          ),
                          child: Text(
                            language.checkout,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                    Expanded(
                        flex: 8,
                        child: SvgPicture.asset('assets/images/cart.svg')),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          language.cartItemsNotAdded,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          } else {
            return const Center(
              child: Text("Something Wrong!"),
            );
          }
        },
      ),
    );
  }

  int sum(List<ProductModel> list) {
    int sum = 0;
    for (var element in list) {
      if (element.price != null) {
        sum += element.price!;
      }
    }
    return sum;
  }
}
