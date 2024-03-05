import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productive_families/business_logic/blocs/product/product_bloc.dart';
import 'package:productive_families/data/models/product_model.dart';

import 'main_products_card.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductModel?> products;
  const ProductGrid({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.55,
            crossAxisSpacing: 6,
          ),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return MainProductCard(
              product: products[index]!,
              onFavoriteToggle: () {
                context.read<ProductBloc>().add(ToggleFavoriteProduct(
                    productId: products[index]!.id ?? ""));
              },
            );
          },
        ));
  }
}
