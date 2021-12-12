import '../../data/model/user/user_model.dart';
import '../../data/model/user/user_register_form_model.dart';
import '../../data/model/user/user_update_form_model.dart';

abstract class UserRepository {
  Future<User> login({required String email, required String password});
  Future<User> register({required UserRegisterFormModel model});
  Future<User> update({required UserUpdateFormModel model});
  Future<User?> initializeUser();
  Future<bool> logout();
}
