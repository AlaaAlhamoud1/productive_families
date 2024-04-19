import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:productive_families/data/models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const AllProductLoaded()) {
    on<LoadProduct>(_onLoadProduct);
    on<ToggleFavoriteProduct>(_onToggleFavoriteProduct);
  }

  void _onLoadProduct(LoadProduct event, Emitter<ProductState> emit) async {
    try {
      List<ProductModel> products = [];
      int id = 0;
      emit(ProductLoaded(products: products, id: id));
      if (event.type == 'all') {
        emit(const AllProductLoaded());
      } else if (event.type == 'handicrafts') {
        emit(const HandicraftsProductLoaded());
      } else if (event.type == 'attention') {
        emit(const AttentionProductLoaded());
      } else if (event.type == 'food') {
        emit(const FoodProductLoaded());
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(ProductError());
    }
  }

  void _onToggleFavoriteProduct(
      ToggleFavoriteProduct event, Emitter<ProductState> emit) async {
    final state = this.state;
    if (state is ProductLoaded) {
      emit(ProductLoading());
      try {
        List<ProductModel> products = state.products;
        emit(ProductLoaded(products: products, id: null));
      } catch (e) {
        debugPrint(e.toString());
        emit(ProductError());
      }
    }
  }
}
