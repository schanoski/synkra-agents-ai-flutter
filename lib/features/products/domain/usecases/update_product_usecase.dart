import 'package:dartz/dartz.dart';
import 'package:flutter_ai_agent_synkra/core/error/failure.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/entities/product.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/repositories/product_repository.dart';

class UpdateProductUseCase {
  const UpdateProductUseCase(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, Product>> call({
    required String idProduct,
    required String name,
    required double price,
  }) {
    return _repository.updateProduct(
      idProduct: idProduct,
      name: name,
      price: price,
    );
  }
}
