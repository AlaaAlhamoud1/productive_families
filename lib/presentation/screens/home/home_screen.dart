import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productive_families/business_logic/blocs/product/product_bloc.dart';
import 'package:productive_families/core/values/values.dart';
import 'package:productive_families/data/models/product_model.dart';
import 'package:productive_families/presentation/screens/home/widgets/carosel_with_indecator.dart';
import 'package:productive_families/presentation/screens/home/widgets/suggestion_list.dart';
import 'package:productive_families/storage/firebase_storage.dart';

import '../../../data/models/ads_model.dart';
import 'widgets/home_title.dart';
import 'widgets/product_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<ProductModel?>? products;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      headerSliverBuilder: (context, value) {
        return [
          const SliverToBoxAdapter(
            child: HomeTitle(),
          ),
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverPersistentHeader(
              pinned: true,
              delegate: PersistentHeader(
                widget: Column(
                  children: [
                    const Expanded(flex: 2, child: SuggestionList()),
                    Expanded(
                      flex: 2,
                      child: FutureBuilder<List<AdsModel?>>(
                          future: getAllAds(),
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              if (snapshot.data!.isNotEmpty) {
                                return CarouselWithIndicatorWidget(
                                  adsModels: snapshot.data ?? [],
                                  indicatorsColor: AppColors.appColor,
                                );
                              } else {
                                return const SizedBox();
                              }
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      body: Builder(
        builder: (context) {
          return Column(
            children: [
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is AllProductLoaded) {
                    return FutureBuilder<List<ProductModel?>>(
                        future: getAllProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return Expanded(
                              child: CustomScrollView(
                                physics: const BouncingScrollPhysics(),
                                slivers: <Widget>[
                                  SliverOverlapInjector(
                                    handle: NestedScrollView
                                        .sliverOverlapAbsorberHandleFor(
                                            context),
                                  ),
                                  SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child:
                                          ProductGrid(products: snapshot.data!),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        });
                  } else if (state is FoodProductLoaded) {
                    return FutureBuilder<List<ProductModel?>>(
                        future: getProductsByType('food'),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return Expanded(
                              child: CustomScrollView(
                                physics: const BouncingScrollPhysics(),
                                slivers: <Widget>[
                                  SliverOverlapInjector(
                                    handle: NestedScrollView
                                        .sliverOverlapAbsorberHandleFor(
                                            context),
                                  ),
                                  SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child:
                                          ProductGrid(products: snapshot.data!),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        });
                  } else if (state is AttentionProductLoaded) {
                    return FutureBuilder<List<ProductModel?>>(
                        future: getProductsByType('attention'),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return Expanded(
                              child: CustomScrollView(
                                physics: const BouncingScrollPhysics(),
                                slivers: <Widget>[
                                  SliverOverlapInjector(
                                    handle: NestedScrollView
                                        .sliverOverlapAbsorberHandleFor(
                                            context),
                                  ),
                                  SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child:
                                          ProductGrid(products: snapshot.data!),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        });
                  } else if (state is HandicraftsProductLoaded) {
                    return FutureBuilder<List<ProductModel?>>(
                        future: getProductsByType('handicrafts'),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return Expanded(
                              child: CustomScrollView(
                                physics: const BouncingScrollPhysics(),
                                slivers: <Widget>[
                                  SliverOverlapInjector(
                                    handle: NestedScrollView
                                        .sliverOverlapAbsorberHandleFor(
                                            context),
                                  ),
                                  SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child:
                                          ProductGrid(products: snapshot.data!),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
    // } else {
    //   return const Center(child: CircularProgressIndicator());
    // }
    // },
    // );
  }
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;

  PersistentHeader({required this.widget});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      width: double.infinity,
      height: 130.0,
      child: Container(
        alignment: Alignment.bottomCenter,
        color: Colors.white,
        child: widget,
      ),
    );
  }

  @override
  double get maxExtent => 130.0;

  @override
  double get minExtent => 130.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
