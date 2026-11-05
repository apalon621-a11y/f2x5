import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class WelcomeScreen extends StatelessWidget {
  final String email;
  const WelcomeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Добро пожаловать')),
    body: Center(child: Text('Вы вошли как $email', style: const TextStyle(fontSize: 20))),
  );
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class RegistrationDoneScreen extends StatelessWidget {
  final String name;
  const RegistrationDoneScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Готово')),
    body: Center(child: Text('Аккаунт создан: $name', style: const TextStyle(fontSize: 20))),
  );
}
