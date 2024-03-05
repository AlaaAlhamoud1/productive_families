// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

// ignore: must_be_immutable
class LoadProduct extends ProductEvent {
  String type;
  LoadProduct({
    required this.type,
  });
  @override
  List<Object> get props => [];
}

class ToggleFavoriteProduct extends ProductEvent {
  final String productId;
  const ToggleFavoriteProduct({required this.productId});

  @override
  List<Object> get props => [productId];
}
