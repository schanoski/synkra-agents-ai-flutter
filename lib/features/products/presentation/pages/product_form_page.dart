import 'package:flutter/material.dart';
import 'package:flutter_ai_agent_synkra/core/router/app_router.dart';
import 'package:flutter_ai_agent_synkra/features/products/presentation/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({required this.idProduct, super.key});

  final String? idProduct;

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  late final TextEditingController _idController;
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _loadDraft();
  }

  Future<void> _loadDraft() async {
    final provider = context.read<ProductProvider>();
    if (widget.idProduct == null) {
      await provider.prepareCreateForm();
    } else {
      await provider.prepareEditForm(widget.idProduct!);
    }
    _idController.text = provider.draftIdProduct;
    _nameController.text = provider.draftName;
    _priceController.text = provider.draftPrice;
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    final provider = context.read<ProductProvider>();
    provider
      ..setDraftIdProduct(_idController.text)
      ..setDraftName(_nameController.text)
      ..setDraftPrice(_priceController.text);

    final success = await provider.submitForm();
    if (success) {
      rootNavigatorKey.currentState?.maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.idProduct != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Editar Produto' : 'Novo Produto')),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              TextField(
                controller: _idController,
                enabled: !isEdit,
                decoration: const InputDecoration(
                  labelText: 'idProduct',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Preco',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              if (provider.errorMessage != null)
                Text(
                  provider.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: provider.isLoading ? null : _onSave,
                child: provider.isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Salvar'),
              ),
            ],
          );
        },
      ),
    );
  }
}
