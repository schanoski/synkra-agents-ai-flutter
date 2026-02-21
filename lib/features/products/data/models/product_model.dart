import 'package:flutter_ai_agent_synkra/features/products/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.idProduct,
    required super.name,
    required super.price,
  });

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      idProduct: product.idProduct,
      name: product.name,
      price: product.price,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      idProduct: (json['idProduct'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      price: (json['price'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idProduct': idProduct,
      'name': name,
      'price': price,
    };
  }
}
