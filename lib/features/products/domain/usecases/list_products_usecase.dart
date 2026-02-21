import 'package:dartz/dartz.dart';
import 'package:flutter_ai_agent_synkra/core/error/failure.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/entities/product.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/repositories/product_repository.dart';

class ListProductsUseCase {
  const ListProductsUseCase(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, List<Product>>> call() {
    return _repository.listProducts();
  }
}
