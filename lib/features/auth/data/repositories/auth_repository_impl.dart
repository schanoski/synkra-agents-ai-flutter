import 'package:dartz/dartz.dart';
import 'package:flutter_ai_agent_synkra/core/error/failure.dart';
import 'package:flutter_ai_agent_synkra/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_ai_agent_synkra/features/auth/domain/entities/user.dart';
import 'package:flutter_ai_agent_synkra/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final User user = await _remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right<Failure, User>(user);
    } on Exception catch (e) {
      return Left<Failure, User>(
        Failure(e.toString().replaceFirst('Exception: ', '')),
      );
    }
  }
}
