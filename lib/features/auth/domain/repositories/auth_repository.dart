import 'package:dartz/dartz.dart';
import 'package:flutter_ai_agent_synkra/core/error/failure.dart';
import 'package:flutter_ai_agent_synkra/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
}
