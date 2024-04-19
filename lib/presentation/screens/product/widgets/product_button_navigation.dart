import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productive_families/data/models/product_model.dart';
import 'package:productive_families/main.dart';
import 'package:productive_families/presentation/screens/order/screens/order_details_screen.dart';

import '../../../../business_logic/blocs/cart/cart_bloc.dart';
import '../../../widgets/input_form_button.dart';

class productBottomNavigation extends StatelessWidget {
  final ProductModel product;
  final List<ProductModel> products = [];
  productBottomNavigation({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      height: 85,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    language.subTotal,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
                Expanded(
                  child: Text(
                    '\$${product.price!.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: SizedBox(
              width: 120,
              child: InputFormButton(
                  onClick: () {
                    context.read<CartBloc>().add(AddCart(product: product));
                    Navigator.pop(context);
                  },
                  titleText: language.addToCart),
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          SizedBox(
            width: 90,
            child: InputFormButton(
              onClick: () {
                products.clear();
                products.add(product);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailsScreen(
                      isCart: false,
                      products: products,
                    ),
                  ),
                );
              },
              titleText: language.buy,
            ),
          ),
        ],
      ),
    );
  }
}
