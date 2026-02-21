import 'package:flutter/material.dart';
import 'package:flutter_ai_agent_synkra/features/products/presentation/providers/product_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/products/new'),
        icon: const Icon(Icons.add),
        label: const Text('Novo'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null && provider.products.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(provider.errorMessage!),
              ),
            );
          }

          if (provider.products.isEmpty) {
            return const Center(child: Text('Nenhum produto cadastrado.'));
          }

          return RefreshIndicator(
            onRefresh: provider.loadProducts,
            child: ListView.separated(
              itemCount: provider.products.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final product = provider.products[index];
                return ListTile(
                  onTap: () => context.push('/products/${product.idProduct}'),
                  title: Text(product.name),
                  subtitle: Text(
                    'ID: ${product.idProduct}  •  Preco: ${product.price.toStringAsFixed(2)}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        tooltip: 'Editar',
                        onPressed: () =>
                            context.push('/products/${product.idProduct}/edit'),
                        icon: const Icon(Icons.edit_outlined),
                      ),
                      IconButton(
                        tooltip: 'Excluir',
                        onPressed: () => context
                            .read<ProductProvider>()
                            .deleteById(product.idProduct),
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
