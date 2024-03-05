import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productive_families/business_logic/blocs/product/product_bloc.dart';
import 'package:productive_families/data/models/product_model.dart';
import 'package:productive_families/main.dart';
import 'package:productive_families/presentation/screens/product/widgets/product_button_navigation.dart';
import 'package:productive_families/presentation/widgets/favorite_products_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel product;
  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getImageUrl(product.image!),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            body: PhysicalModel(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data ?? ""),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back_outlined)),
                        BlocBuilder<ProductBloc, ProductState>(
                          builder: (context, state) => FavoriteProductButton(
                            product: product,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SlidingUpPanel(
                    renderPanelSheet: false,
                    panel: _floatingPanel(product.description ?? ""),
                    collapsed: _floatingCollapsed(),
                  )
                ],
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: productBottomNavigation(
                product: product,
              ),
            ),
          );
        });
  }

  Widget _floatingCollapsed() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const RotatedBox(
            quarterTurns: 3,
            child: Icon(
              Icons.double_arrow_sharp,
              color: Colors.white,
            ),
          ),
          Text(
            language.swipeUpToDetails,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _floatingPanel(String description) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: Text(
          description,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
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
}
