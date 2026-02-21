import 'package:dartz/dartz.dart';
import 'package:flutter_ai_agent_synkra/core/error/failure.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/entities/product.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/repositories/product_repository.dart';

class GetProductByIdUseCase {
  const GetProductByIdUseCase(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, Product>> call(String idProduct) {
    return _repository.getProductById(idProduct);
  }
}
