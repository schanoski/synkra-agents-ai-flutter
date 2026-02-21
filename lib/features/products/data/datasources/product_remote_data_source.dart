import 'package:flutter_ai_agent_synkra/features/products/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> createProduct({
    required String idProduct,
    required String name,
    required double price,
  });

  Future<List<ProductModel>> listProducts();

  Future<ProductModel> getProductById(String idProduct);

  Future<ProductModel> updateProduct({
    required String idProduct,
    required String name,
    required double price,
  });

  Future<void> deleteProduct(String idProduct);
}

class FakeProductRemoteDataSource implements ProductRemoteDataSource {
  FakeProductRemoteDataSource();

  static const String baseUrl = 'http://localhost:3000/api';
  static const String productsPath = '/products';

  final Map<String, ProductModel> _storage = <String, ProductModel>{};

  @override
  Future<ProductModel> createProduct({
    required String idProduct,
    required String name,
    required double price,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _validatePayload(idProduct: idProduct, name: name, price: price);
    if (_storage.containsKey(idProduct)) {
      throw Exception('Produto com idProduct "$idProduct" ja existe.');
    }

    final product = ProductModel(
      idProduct: idProduct.trim(),
      name: name.trim(),
      price: price,
    );
    _storage[idProduct] = product;
    return product;
  }

  @override
  Future<List<ProductModel>> listProducts() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final items = _storage.values.toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return items;
  }

  @override
  Future<ProductModel> getProductById(String idProduct) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final key = idProduct.trim();
    final product = _storage[key];
    if (product == null) {
      throw Exception('Produto "$idProduct" nao encontrado.');
    }
    return product;
  }

  @override
  Future<ProductModel> updateProduct({
    required String idProduct,
    required String name,
    required double price,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _validatePayload(idProduct: idProduct, name: name, price: price);
    final key = idProduct.trim();
    if (!_storage.containsKey(key)) {
      throw Exception('Produto "$idProduct" nao encontrado.');
    }

    final product = ProductModel(
      idProduct: key,
      name: name.trim(),
      price: price,
    );
    _storage[key] = product;
    return product;
  }

  @override
  Future<void> deleteProduct(String idProduct) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final key = idProduct.trim();
    if (!_storage.containsKey(key)) {
      throw Exception('Produto "$idProduct" nao encontrado.');
    }
    _storage.remove(key);
  }

  void _validatePayload({
    required String idProduct,
    required String name,
    required double price,
  }) {
    if (idProduct.trim().isEmpty) {
      throw Exception('idProduct e obrigatorio.');
    }
    if (name.trim().isEmpty) {
      throw Exception('name e obrigatorio.');
    }
    if (price <= 0) {
      throw Exception('price deve ser maior que zero.');
    }
  }
}
