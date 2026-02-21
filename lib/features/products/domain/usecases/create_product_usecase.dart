import 'package:dartz/dartz.dart';
import 'package:flutter_ai_agent_synkra/core/error/failure.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/entities/product.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/repositories/product_repository.dart';

class CreateProductUseCase {
  const CreateProductUseCase(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, Product>> call({
    required String idProduct,
    required String name,
    required double price,
  }) {
    return _repository.createProduct(
      idProduct: idProduct,
      name: name,
      price: price,
    );
  }
}
