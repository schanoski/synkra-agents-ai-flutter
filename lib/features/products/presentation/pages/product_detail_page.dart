import 'package:flutter/material.dart';
import 'package:flutter_ai_agent_synkra/core/router/app_router.dart';
import 'package:flutter_ai_agent_synkra/features/products/presentation/providers/product_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({required this.idProduct, super.key});

  final String idProduct;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductProvider>().loadProductById(widget.idProduct);
  }

  Future<void> _onDelete() async {
    final provider = context.read<ProductProvider>();
    final success = await provider.deleteById(widget.idProduct);
    if (success) {
      rootNavigatorKey.currentState?.maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhe do Produto')),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.selectedProduct == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null &&
              provider.selectedProduct == null) {
            return Center(child: Text(provider.errorMessage!));
          }

          final product = provider.selectedProduct;
          if (product == null) {
            return const Center(child: Text('Produto nao encontrado.'));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              Text(
                'ID: ${product.idProduct}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Nome: ${product.name}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Preco: ${product.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              FilledButton.tonal(
                onPressed: () =>
                    context.push('/products/${product.idProduct}/edit'),
                child: const Text('Editar'),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: provider.isLoading ? null : _onDelete,
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                child: provider.isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Excluir'),
              ),
            ],
          );
        },
      ),
    );
  }
}
