import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:productive_families/main.dart';

import '../../../business_logic/blocs/wishlist/wishlist_bloc.dart';
import '../home/widgets/product_grid.dart';

class FavoriteProductScreen extends StatelessWidget {
  const FavoriteProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(builder: (context, state) {
      if (state is WishlistLoaded) {
        if (state.wishlist.isNotEmpty) {
          return ProductGrid(products: state.wishlist);
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: SvgPicture.asset('assets/images/favourite.svg')),
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      language.favoriteItemsNotAdded,
                      style: const TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      } else {
        return const Center(
          child: Text("Something Wrong!"),
        );
      }
    });
  }
}
