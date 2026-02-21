import 'package:dartz/dartz.dart';
import 'package:flutter_ai_agent_synkra/core/error/failure.dart';
import 'package:flutter_ai_agent_synkra/features/products/data/datasources/product_remote_data_source.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/entities/product.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl(this._remoteDataSource);

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, Product>> createProduct({
    required String idProduct,
    required String name,
    required double price,
  }) async {
    try {
      final product = await _remoteDataSource.createProduct(
        idProduct: idProduct,
        name: name,
        price: price,
      );
      return Right<Failure, Product>(product);
    } on Exception catch (e) {
      return Left<Failure, Product>(
        Failure(e.toString().replaceFirst('Exception: ', '')),
      );
    }
  }

  @override
  Future<Either<Failure, List<Product>>> listProducts() async {
    try {
      final products = await _remoteDataSource.listProducts();
      return Right<Failure, List<Product>>(products);
    } on Exception catch (e) {
      return Left<Failure, List<Product>>(
        Failure(e.toString().replaceFirst('Exception: ', '')),
      );
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String idProduct) async {
    try {
      final product = await _remoteDataSource.getProductById(idProduct);
      return Right<Failure, Product>(product);
    } on Exception catch (e) {
      return Left<Failure, Product>(
        Failure(e.toString().replaceFirst('Exception: ', '')),
      );
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct({
    required String idProduct,
    required String name,
    required double price,
  }) async {
    try {
      final product = await _remoteDataSource.updateProduct(
        idProduct: idProduct,
        name: name,
        price: price,
      );
      return Right<Failure, Product>(product);
    } on Exception catch (e) {
      return Left<Failure, Product>(
        Failure(e.toString().replaceFirst('Exception: ', '')),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String idProduct) async {
    try {
      await _remoteDataSource.deleteProduct(idProduct);
      return const Right<Failure, Unit>(unit);
    } on Exception catch (e) {
      return Left<Failure, Unit>(
        Failure(e.toString().replaceFirst('Exception: ', '')),
      );
    }
  }
}
