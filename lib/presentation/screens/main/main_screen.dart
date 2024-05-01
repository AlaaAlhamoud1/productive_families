import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:productive_families/business_logic/blocs/cart/cart_bloc.dart';
import 'package:productive_families/core/themes/app_theme.dart';
import 'package:productive_families/core/values/values.dart';

import '../cart/cart_screen.dart';
import '../favorite/favorite_product_screen.dart';
import '../home/home_screen.dart';
import '../other/other_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedItemPosition = 0;
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: PhysicalModel(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40)),
          clipBehavior: Clip.antiAlias,
          child: SafeArea(
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                children: const <Widget>[
                  HomeScreen(),
                  FavoriteProductScreen(),
                  CartScreen(),
                  OtherScreen(),
                ],
              ),
            ),
          )),
      bottomNavigationBar: SnakeNavigationBar.color(
        height: 50,
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: SnakeShape.circle,
        elevation: 5,
        shadowColor: AppColors.appColor,
        padding: const EdgeInsets.all(6),
        backgroundColor: AppColors.appColor,
        snakeViewColor: Colors.black,
        selectedItemColor: AppTheme.darkTextColor,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() {
          controller.animateToPage(index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.linear);
          _selectedItemPosition = index;
        }),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'category'),
          BottomNavigationBarItem(
              icon: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.shopping_cart_outlined),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          alignment: const Alignment(0.3, -1.5),
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                              padding: const EdgeInsets.all(3),
                              child: Text(state.products.length.toString())),
                        ),
                      ],
                    );
                  } else {
                    return const Icon(Icons.shopping_cart_outlined);
                  }
                },
              ),
              label: 'cart'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'settings')
        ],
      ),
    );
  }
}
