import 'package:flutter_ai_agent_synkra/features/products/data/datasources/product_remote_data_source.dart';
import 'package:flutter_ai_agent_synkra/features/products/data/repositories/product_repository_impl.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/usecases/create_product_usecase.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/usecases/delete_product_usecase.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/usecases/get_product_by_id_usecase.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/usecases/list_products_usecase.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/usecases/update_product_usecase.dart';
import 'package:flutter_ai_agent_synkra/features/products/presentation/providers/product_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProductProvider provider;

  setUp(() {
    final dataSource = FakeProductRemoteDataSource();
    final repository = ProductRepositoryImpl(dataSource);
    provider = ProductProvider(
      CreateProductUseCase(repository),
      ListProductsUseCase(repository),
      GetProductByIdUseCase(repository),
      UpdateProductUseCase(repository),
      DeleteProductUseCase(repository),
    );
  });

  test('creates and lists products', () async {
    await provider.prepareCreateForm();
    provider
      ..setDraftIdProduct('p-1')
      ..setDraftName('Mouse')
      ..setDraftPrice('99.90');

    final success = await provider.submitForm();

    expect(success, isTrue);
    expect(provider.products.length, 1);
    expect(provider.products.first.idProduct, 'p-1');
  });

  test('updates product values', () async {
    await provider.prepareCreateForm();
    provider
      ..setDraftIdProduct('p-2')
      ..setDraftName('Keyboard')
      ..setDraftPrice('120');
    await provider.submitForm();

    await provider.prepareEditForm('p-2');
    provider
      ..setDraftName('Mechanical Keyboard')
      ..setDraftPrice('199.99');

    final success = await provider.submitForm();
    await provider.loadProductById('p-2');

    expect(success, isTrue);
    expect(provider.selectedProduct?.name, 'Mechanical Keyboard');
    expect(provider.selectedProduct?.price, 199.99);
  });

  test('returns validation error for invalid price', () async {
    await provider.prepareCreateForm();
    provider
      ..setDraftIdProduct('p-3')
      ..setDraftName('Monitor')
      ..setDraftPrice('0');

    final success = await provider.submitForm();

    expect(success, isFalse);
    expect(provider.errorMessage, 'Preco deve ser maior que zero.');
  });
}
