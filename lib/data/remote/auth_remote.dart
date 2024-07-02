import 'package:firebase_project/config/network/firebase_wrapper.dart';

abstract class AuthRemote {
  Future<bool?> login(String email, String password);

  Future<bool?> register(String email, String password);

  bool checkCurrentUser();
  MyUser? getCurrentUser();
  Future<void> logout();
}
