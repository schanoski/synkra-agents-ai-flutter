import 'package:flutter_ai_agent_synkra/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
}

class FakeAuthRemoteDataSource implements AuthRemoteDataSource {
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));

    if (email.trim().isEmpty || password.trim().isEmpty) {
      throw Exception('Email e senha sao obrigatorios.');
    }

    if (!email.contains('@') || password.length < 6) {
      throw Exception('Credenciais invalidas. Senha minima: 6 caracteres.');
    }

    return UserModel(id: 'user-001', name: 'Synkra User', email: email);
  }
}
