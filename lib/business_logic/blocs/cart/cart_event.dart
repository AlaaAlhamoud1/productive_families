part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class LoadCart extends CartEvent {
  @override
  List<Object> get props => [];
}

class AddCart extends CartEvent {
  final ProductModel product;
  const AddCart({required this.product});

  @override
  List<Object> get props => [product];
}

class RemoveCart extends CartEvent {
  final int index;
  const RemoveCart({required this.index});

  @override
  List<Object> get props => [index];
}
