import 'package:flutter/foundation.dart';
import 'package:flutter_ai_agent_synkra/features/auth/domain/entities/user.dart';
import 'package:flutter_ai_agent_synkra/features/auth/domain/usecases/login_usecase.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._loginUseCase);

  final LoginUseCase _loginUseCase;

  bool _isLoading = false;
  String? _errorMessage;
  User? _currentUser;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  Future<bool> login({required String email, required String password}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _loginUseCase(email: email, password: password);

    return result.fold(
      (failure) {
        _isLoading = false;
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (user) {
        _isLoading = false;
        _currentUser = user;
        notifyListeners();
        return true;
      },
    );
  }

  void logout() {
    _currentUser = null;
    _errorMessage = null;
    notifyListeners();
  }
}
