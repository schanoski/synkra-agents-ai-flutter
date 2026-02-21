import 'package:dartz/dartz.dart';
import 'package:flutter_ai_agent_synkra/core/error/failure.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> createProduct({
    required String idProduct,
    required String name,
    required double price,
  });

  Future<Either<Failure, List<Product>>> listProducts();

  Future<Either<Failure, Product>> getProductById(String idProduct);

  Future<Either<Failure, Product>> updateProduct({
    required String idProduct,
    required String name,
    required double price,
  });

  Future<Either<Failure, Unit>> deleteProduct(String idProduct);
}
