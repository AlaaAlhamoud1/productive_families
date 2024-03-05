import 'package:productive_families/data/models/product_model.dart';

class StoreModel {
  String? id;
  String? storeName;
  String? activityType;
  String? desciption;
  String? storeImage;
  List<ProductModel>? products;
  StoreModel({
    this.id,
    this.storeName,
    this.activityType,
    this.desciption,
    this.storeImage,
    this.products,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'storeName': storeName,
        'activityType': activityType,
        'desciption': desciption,
        'storeImage': storeImage,
        'products': products?.map((product) => product.toJson()).toList(),
      };

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['storeName'];
    activityType = json['activityType'];
    desciption = json['desciption'];
    storeImage = json['storeImage'];
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((v) {
        products!.add(ProductModel.fromJson(v));
      });
    }
  }
}
