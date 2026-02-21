import 'package:flutter_ai_agent_synkra/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_ai_agent_synkra/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_ai_agent_synkra/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_ai_agent_synkra/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_ai_agent_synkra/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_ai_agent_synkra/features/products/data/datasources/product_remote_data_source.dart';
import 'package:flutter_ai_agent_synkra/features/products/data/repositories/product_repository_impl.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/repositories/product_repository.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/usecases/create_product_usecase.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/usecases/delete_product_usecase.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/usecases/get_product_by_id_usecase.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/usecases/list_products_usecase.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/usecases/update_product_usecase.dart';
import 'package:flutter_ai_agent_synkra/features/products/presentation/providers/product_provider.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  sl
    ..registerLazySingleton<AuthRemoteDataSource>(FakeAuthRemoteDataSource.new)
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
    )
    ..registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(sl<AuthRepository>()),
    )
    ..registerFactory<AuthProvider>(() => AuthProvider(sl<LoginUseCase>()))
    ..registerLazySingleton<ProductRemoteDataSource>(
      FakeProductRemoteDataSource.new,
    )
    ..registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl<ProductRemoteDataSource>()),
    )
    ..registerLazySingleton<CreateProductUseCase>(
      () => CreateProductUseCase(sl<ProductRepository>()),
    )
    ..registerLazySingleton<ListProductsUseCase>(
      () => ListProductsUseCase(sl<ProductRepository>()),
    )
    ..registerLazySingleton<GetProductByIdUseCase>(
      () => GetProductByIdUseCase(sl<ProductRepository>()),
    )
    ..registerLazySingleton<UpdateProductUseCase>(
      () => UpdateProductUseCase(sl<ProductRepository>()),
    )
    ..registerLazySingleton<DeleteProductUseCase>(
      () => DeleteProductUseCase(sl<ProductRepository>()),
    )
    ..registerFactory<ProductProvider>(
      () => ProductProvider(
        sl<CreateProductUseCase>(),
        sl<ListProductsUseCase>(),
        sl<GetProductByIdUseCase>(),
        sl<UpdateProductUseCase>(),
        sl<DeleteProductUseCase>(),
      ),
    );
}
