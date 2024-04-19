import 'package:flutter/material.dart';
import 'package:productive_families/data/models/product_model.dart';
import 'package:productive_families/presentation/screens/product/products_card.dart';
import 'package:productive_families/storage/firebase_storage.dart';

class MostOrderedProductsScreen extends StatefulWidget {
  const MostOrderedProductsScreen({super.key});

  @override
  State<MostOrderedProductsScreen> createState() =>
      _MostOrderedProductsScreenState();
}

class _MostOrderedProductsScreenState extends State<MostOrderedProductsScreen> {
  List list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4AC382),
        title: const Text(
          "Most Ordered Products",
        ),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      body: FutureBuilder(
        future: getRandomProducts(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            list = snapshot.data as List<ProductModel?>;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: List.generate(
                    snapshot.data!.length,
                    (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductWidget(product: snapshot.data![index]),
                        )),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
