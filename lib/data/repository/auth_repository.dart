import 'package:firebase_project/data/remote/auth_remote.dart';
import 'package:firebase_project/data/remote/auth_remote_impl.dart';

class AuthRepository {
  final AuthRemote authRemote;

  AuthRepository(this.authRemote);

  checkUserLogged() => authRemote.checkCurrentUser();
  logout() => authRemote.logout();
  signInWithEmailAndPassword({
    required String email,
    required String password,
  }) => authRemote.login(email, password);

  createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      authRemote.register(email, password);
}
