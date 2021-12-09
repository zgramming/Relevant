import 'package:dartz/dartz.dart';

import '../../data/model/user/user_model.dart';
import '../../data/model/user/user_register_model.dart';
import '../../utils/utils.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> register({
    required UserRegisterModel user,
  });
}
