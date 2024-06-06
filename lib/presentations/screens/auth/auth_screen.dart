import 'package:firebase_project/presentations/screens/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Authorization"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
          child: Consumer<AuthProvider>(builder: (context, provider, _) {
            return Form(
              key: provider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Have an account",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Switch(
                          value: provider.haveAccount,
                          onChanged: (flag) {
                            provider.haveAccount = flag;
                          }),
                    ],
                  ),
                  TextFormField(
                    controller: provider.emailController,
                    decoration: const InputDecoration(hintText: "Email"),
                    validator: (text) {
                      if (text != null && text.isEmpty) {
                        return "Enter valid email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: provider.passwordController,
                    decoration: const InputDecoration(hintText: "Password"),
                    validator: (text) {
                      if (text != null && text.isEmpty) {
                        return "Enter valid password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: provider.authAction,
                    child: const Text("Auth"),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
