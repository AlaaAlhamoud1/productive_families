part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductLoading extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final int? id;
  const ProductLoaded({required this.products, this.id});
  @override
  List<Object> get props => [products];
}

class ProductError extends ProductState {
  @override
  List<Object> get props => [];
}
