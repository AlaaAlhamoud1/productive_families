part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartLoading extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoaded extends CartState {
  final List<ProductModel> products;
  const CartLoaded({this.products = const []});

  double getTotal() =>
      products.fold(0, (previousValue, element) => previousValue);

  @override
  List<Object> get props => [products];
}

class CartError extends CartState {
  @override
  List<Object> get props => [];
}
