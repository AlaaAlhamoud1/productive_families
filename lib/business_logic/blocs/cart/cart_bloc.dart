import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:productive_families/data/models/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<LoadCart>(_onLoadCart);
    on<AddCart>(_onAddCart);
    on<RemoveCart>(_onRemoveCart);
    on<RemoveAllProductsCart>(_onRemoveallProductsCart);
  }

  void _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    debugPrint("Loading Cart...");
    try {
      emit(const CartLoaded(products: <ProductModel>[]));
    } catch (e) {
      debugPrint(e.toString());
      emit(CartError());
    }
  }

  void _onAddCart(AddCart event, Emitter<CartState> emit) async {
    try {
      debugPrint("Cart Adding....");
      final state = this.state;
      if (state is CartLoaded) {
        emit(CartLoaded(
            products: List.from(state.products)..add(event.product)));
        debugPrint(event.product.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(CartError());
    }
  }

  void _onRemoveCart(RemoveCart event, Emitter<CartState> emit) async {
    try {
      debugPrint("Cart Removing....");
      final state = this.state;
      if (state is CartLoaded) {
        emit(CartLoaded(
            products: List.from(state.products)..removeAt(event.index)));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(CartError());
    }
  }

  void _onRemoveallProductsCart(
      RemoveAllProductsCart event, Emitter<CartState> emit) async {
    try {
      debugPrint("Cart Removing....");
      final state = this.state;
      if (state is CartLoaded) {
        emit(const CartLoaded(products: []));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(CartError());
    }
  }
}
