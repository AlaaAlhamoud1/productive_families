import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productive_families/business_logic/blocs/product/product_bloc.dart';
import 'package:productive_families/presentation/screens/home/widgets/suggestion_button.dart';

class SuggestionList extends StatefulWidget {
  const SuggestionList({Key? key}) : super(key: key);

  @override
  State<SuggestionList> createState() => _SuggestionListState();
}

bool isAll = true;
bool isFood = false;
bool isHandcrafts = false;
bool isAttention = false;

class _SuggestionListState extends State<SuggestionList> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is AllProductLoaded) {
          isAll = true;
        } else {
          isAll = false;
        }
        if (state is HandicraftsProductLoaded) {
          isHandcrafts = true;
        } else {
          isHandcrafts = false;
        }
        if (state is FoodProductLoaded) {
          isFood = true;
        } else {
          isFood = false;
        }
        if (state is AttentionProductLoaded) {
          isAttention = true;
        } else {
          isAttention = false;
        }
      },
      child: SizedBox(
        height: 40,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SuggestionButton(
                      image: 'assets/images/home.png',
                      onClick: () {
                        BlocProvider.of<ProductBloc>(context)
                            .add(LoadProduct(type: "all"));
                        setState(() {});
                      },
                      isSelected: isAll),
                  const SizedBox(
                    width: 10,
                  ),
                  SuggestionButton(
                      image: 'assets/images/food.png',
                      onClick: () {
                        BlocProvider.of<ProductBloc>(context)
                            .add(LoadProduct(type: "food"));
                        setState(() {});
                      },
                      isSelected: isFood),
                  const SizedBox(
                    width: 10,
                  ),
                  SuggestionButton(
                      image: 'assets/images/attention.png',
                      onClick: () {
                        BlocProvider.of<ProductBloc>(context)
                            .add(LoadProduct(type: "attention"));
                        setState(() {});
                      },
                      isSelected: isAttention),
                  const SizedBox(
                    width: 10,
                  ),
                  SuggestionButton(
                      image: 'assets/images/handicrafts.png',
                      onClick: () {
                        BlocProvider.of<ProductBloc>(context)
                            .add(LoadProduct(type: "handicrafts"));
                        setState(() {});
                      },
                      isSelected: isHandcrafts),
                ],
              ),
            )),
      ),
    );
  }
}
