import 'package:firebase_project/data/exceptions/my_exception.dart';
import 'package:firebase_project/data/remote/auth_remote_impl.dart';
import 'package:firebase_project/data/repository/auth_repository.dart';
import 'package:firebase_project/main.dart';
import 'package:firebase_project/presentations/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';

import '../profile/profile_screen.dart';

class AuthProvider extends ChangeNotifier {
  final _authRepo = AuthRepository(AuthRemoteImpl());

  final TextEditingController _emailController = TextEditingController();

  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get passwordController => _passwordController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  bool _haveAccount = false;

  bool get haveAccount => _haveAccount;

  set haveAccount(bool newValue) {
    _haveAccount = newValue;
    notifyListeners();
  }

  void reset() {
    _emailController.clear();
    _passwordController.clear();
  }

  void checkLoggedUser() async {
    await Future.delayed(const Duration(seconds: 2), () {
      final flag = _authRepo.checkUserLogged();
      if (navigationStateKey.currentContext != null) {
        Navigator.of(navigationStateKey.currentContext!).pushReplacement(
          MaterialPageRoute(
            builder: (_) => flag ? const ProfileScreen() : const AuthScreen(),
          ),
        );
      }
    });
  }

  Future<void> logout() async {
    await _authRepo.logout().whenComplete(() {
      if (navigationStateKey.currentContext != null) {
        Navigator.of(navigationStateKey.currentContext!).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const AuthScreen()),
            (route) => false);
      }
    });
  }

  Future<void> socialAuthAction() async {
    // await _fireRepo.signInViaGoogle();
  }

  Future<void> authAction() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      // String message = _haveAccount ? "logged" : "registered";
      Future<bool?> authFuture = _haveAccount
          ? _authRepo.signInWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,
            )
          : _authRepo.createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,
            );

      await authFuture.then((value) {
        reset();
        if (value != null && value) {
          if (navigationStateKey.currentContext != null) {
            // ScaffoldMessenger.of(navigationStateKey.currentContext!)
            //     .showSnackBar(
            //   SnackBar(
            //     content: Text(
            //       "You are successfully $message on FireBase",
            //       style: const TextStyle(color: Colors.white),
            //     ),
            //   ),
            // );
            Navigator.of(navigationStateKey.currentContext!).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const ProfileScreen(),
              ),
            );
          }
        }
      }).catchError(
        (err) {
          final errorMessage = (err as MyException).message;
          if (navigationStateKey.currentContext != null) {
            ScaffoldMessenger.of(navigationStateKey.currentContext!)
                .showSnackBar(
              SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        },
      );
    }
  }
}
