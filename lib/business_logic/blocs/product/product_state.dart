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

class AllProductLoaded extends ProductState {
  final int? id;
  const AllProductLoaded({this.id});
  @override
  List<Object> get props => [];
}

class FoodProductLoaded extends ProductState {
  final int? id;
  const FoodProductLoaded({this.id});
  @override
  List<Object> get props => [];
}

class AttentionProductLoaded extends ProductState {
  final int? id;
  const AttentionProductLoaded({this.id});
  @override
  List<Object> get props => [];
}

class HandicraftsProductLoaded extends ProductState {
  final int? id;
  const HandicraftsProductLoaded({this.id});
  @override
  List<Object> get props => [];
}

class ProductError extends ProductState {
  @override
  List<Object> get props => [];
}
