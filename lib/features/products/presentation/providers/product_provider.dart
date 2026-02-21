import 'package:flutter/foundation.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/entities/product.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/usecases/create_product_usecase.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/usecases/delete_product_usecase.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/usecases/get_product_by_id_usecase.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/usecases/list_products_usecase.dart';
import 'package:flutter_ai_agent_synkra/features/products/domain/usecases/update_product_usecase.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider(
    this._createProductUseCase,
    this._listProductsUseCase,
    this._getProductByIdUseCase,
    this._updateProductUseCase,
    this._deleteProductUseCase,
  ) {
    loadProducts();
  }

  final CreateProductUseCase _createProductUseCase;
  final ListProductsUseCase _listProductsUseCase;
  final GetProductByIdUseCase _getProductByIdUseCase;
  final UpdateProductUseCase _updateProductUseCase;
  final DeleteProductUseCase _deleteProductUseCase;

  bool _isLoading = false;
  String? _errorMessage;
  List<Product> _products = <Product>[];
  Product? _selectedProduct;
  String? _editingId;
  String _draftIdProduct = '';
  String _draftName = '';
  String _draftPrice = '';

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Product> get products => _products;
  Product? get selectedProduct => _selectedProduct;
  bool get isEditing => _editingId != null;
  String get draftIdProduct => _draftIdProduct;
  String get draftName => _draftName;
  String get draftPrice => _draftPrice;

  void setDraftIdProduct(String value) {
    _draftIdProduct = value;
    notifyListeners();
  }

  void setDraftName(String value) {
    _draftName = value;
    notifyListeners();
  }

  void setDraftPrice(String value) {
    _draftPrice = value;
    notifyListeners();
  }

  String? validateIdProduct(String value) {
    if (value.trim().isEmpty) {
      return 'idProduct e obrigatorio.';
    }
    return null;
  }

  String? validateName(String value) {
    if (value.trim().isEmpty) {
      return 'Nome e obrigatorio.';
    }
    return null;
  }

  String? validatePrice(String value) {
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null) {
      return 'Preco invalido.';
    }
    if (parsed <= 0) {
      return 'Preco deve ser maior que zero.';
    }
    return null;
  }

  Future<void> loadProducts() async {
    _setLoading(true);
    _errorMessage = null;

    final result = await _listProductsUseCase();
    result.fold(
      (failure) {
        _errorMessage = failure.message;
      },
      (items) {
        _products = items;
      },
    );

    _setLoading(false);
  }

  Future<void> loadProductById(String idProduct) async {
    _setLoading(true);
    _errorMessage = null;

    final result = await _getProductByIdUseCase(idProduct);
    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _selectedProduct = null;
      },
      (product) {
        _selectedProduct = product;
      },
    );

    _setLoading(false);
  }

  Future<void> prepareCreateForm() async {
    _editingId = null;
    _draftIdProduct = '';
    _draftName = '';
    _draftPrice = '';
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> prepareEditForm(String idProduct) async {
    await loadProductById(idProduct);
    final product = _selectedProduct;
    if (product == null) {
      return;
    }
    _editingId = product.idProduct;
    _draftIdProduct = product.idProduct;
    _draftName = product.name;
    _draftPrice = product.price.toStringAsFixed(2);
    _errorMessage = null;
    notifyListeners();
  }

  Future<bool> submitForm() async {
    final idError = validateIdProduct(_draftIdProduct);
    final nameError = validateName(_draftName);
    final priceError = validatePrice(_draftPrice);

    if (idError != null || nameError != null || priceError != null) {
      _errorMessage = idError ?? nameError ?? priceError;
      notifyListeners();
      return false;
    }

    final parsedPrice = double.parse(_draftPrice.replaceAll(',', '.'));
    _setLoading(true);
    _errorMessage = null;

    final result = isEditing
        ? await _updateProductUseCase(
            idProduct: _editingId!,
            name: _draftName.trim(),
            price: parsedPrice,
          )
        : await _createProductUseCase(
            idProduct: _draftIdProduct.trim(),
            name: _draftName.trim(),
            price: parsedPrice,
          );

    var success = false;
    await result.fold(
      (failure) async {
        _errorMessage = failure.message;
        success = false;
      },
      (product) async {
        success = true;
        _selectedProduct = product;
        _editingId = product.idProduct;
        await loadProducts();
      },
    );

    _setLoading(false);
    return success;
  }

  Future<bool> deleteById(String idProduct) async {
    _setLoading(true);
    _errorMessage = null;

    final result = await _deleteProductUseCase(idProduct);
    var success = false;
    await result.fold(
      (failure) async {
        _errorMessage = failure.message;
        success = false;
      },
      (_) async {
        success = true;
        _selectedProduct = null;
        await loadProducts();
      },
    );

    _setLoading(false);
    return success;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
