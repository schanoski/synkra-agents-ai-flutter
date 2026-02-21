import 'package:dartz/dartz.dart';
import 'package:flutter_ai_agent_synkra/core/error/failure.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/repositories/product_repository.dart';

class DeleteProductUseCase {
  const DeleteProductUseCase(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, Unit>> call(String idProduct) {
    return _repository.deleteProduct(idProduct);
  }
}
