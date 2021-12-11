import '../../data/model/user/user_model.dart';
import '../../data/model/user/user_register_model.dart';

abstract class UserRepository {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<User> register({
    required UserRegisterModel user,
  });
}
