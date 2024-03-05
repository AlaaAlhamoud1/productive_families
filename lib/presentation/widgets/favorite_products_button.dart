import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productive_families/data/models/product_model.dart';

import '../../business_logic/blocs/wishlist/wishlist_bloc.dart';

class FavoriteProductButton extends StatelessWidget {
  final ProductModel product;
  const FavoriteProductButton({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<WishlistBloc>().add(ToggleWishlist(product: product));
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.red,
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        elevation: 0,
        padding: const EdgeInsets.all(6),
      ),
      child: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoaded) {
            return Icon(
                state.wishlist.any((element) => element == product)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Theme.of(context).primaryColor);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
