import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:productive_families/data/models/product_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<LoadWishlist>(_onLoadWishlist);
    on<ToggleWishlist>(_onToggleWishlist);
  }

  void _onLoadWishlist(LoadWishlist event, Emitter<WishlistState> emit) async {
    debugPrint("Loading Wishlist...");
    try {
      emit(const WishlistLoaded(wishlist: <ProductModel>[]));
    } catch (e) {
      debugPrint(e.toString());
      emit(WishlistError());
    }
  }

  void _onToggleWishlist(
      ToggleWishlist event, Emitter<WishlistState> emit) async {
    try {
      debugPrint("Wishlist Adding....");
      final state = this.state;
      if (state is WishlistLoaded) {
        if (state.wishlist.any((element) => element == event.product)) {
          emit(WishlistLoaded(
              wishlist: List.from(state.wishlist)..remove(event.product)));
        } else {
          emit(WishlistLoaded(
              wishlist: List.from(state.wishlist)..add(event.product)));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(WishlistError());
    }
  }
}
