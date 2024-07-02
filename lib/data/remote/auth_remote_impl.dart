import 'package:firebase_project/config/network/firebase_wrapper.dart';
import 'package:firebase_project/data/remote/auth_remote.dart';

class AuthRemoteImpl implements AuthRemote {
  final baseApiInstance = FireBaseWrapper();

  @override
  Future<void> logout() async => baseApiInstance.logout();

  @override
  Future<bool?> login(String email, String password) async {
    return await baseApiInstance.signIn(email, password).then((value) {
      return value != null;
    });
  }

  @override
  Future<bool?> register(String email, String password) async {
    return await baseApiInstance
        .createUser(email, password)
        .then((value) => value != null);
  }

  @override
  bool checkCurrentUser() => baseApiInstance.checkCurrentUser();

  @override
  MyUser? getCurrentUser() => baseApiInstance.currentUser;
}
