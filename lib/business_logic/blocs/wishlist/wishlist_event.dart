part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();
}

class LoadWishlist extends WishlistEvent {
  @override
  List<Object> get props => [];
}

class ToggleWishlist extends WishlistEvent {
  final ProductModel product;
  const ToggleWishlist({required this.product});

  @override
  List<Object> get props => [product];
}
