import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  void dispose() { email.dispose(); password.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Center(child: SingleChildScrollView(
    padding: const EdgeInsets.all(24), child: Form(key: formKey, child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.account_circle, size: 80),
      TextFormField(controller: email, decoration: const InputDecoration(labelText: 'Электронная почта'),
        keyboardType: TextInputType.emailAddress,
        validator: (v) => v != null && RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v) ? null : 'Введите корректную почту'),
      TextFormField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Пароль'),
        validator: (v) => v == null || v.isEmpty ? 'Введите пароль' : null),
      const SizedBox(height: 16),
      FilledButton(onPressed: () { if(formKey.currentState!.validate()) Navigator.push(context, MaterialPageRoute(builder: (_) => WelcomeScreen(email: email.text.trim()))); }, child: const Text('Войти')),
      TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())), child: const Text('Регистрация')),
    ]))));
}
class WelcomeScreen extends StatelessWidget {
  final String email;
  const WelcomeScreen({super.key, required this.email});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Добро пожаловать')),
    body: Center(child: Text('Вы вошли как $email')));
}
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController(), email = TextEditingController(), phone = TextEditingController(), password = TextEditingController();
  @override
  void dispose() { name.dispose(); email.dispose(); phone.dispose(); password.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Регистрация')),
    body: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Form(key: formKey, child: Column(children: [
      TextFormField(controller:name, decoration:const InputDecoration(labelText:'Имя'), validator:(v)=>v==null||v.trim().isEmpty?'Введите имя':null),
      TextFormField(controller:email, decoration:const InputDecoration(labelText:'Электронная почта'), keyboardType:TextInputType.emailAddress,
        validator:(v)=>v!=null&&RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v)?null:'Некорректная почта'),
      TextFormField(controller:phone, decoration:const InputDecoration(labelText:'Телефон'), keyboardType:TextInputType.phone,
        validator:(v)=>v==null||v.trim().isEmpty?'Введите телефон':null),
      TextFormField(controller:password, decoration:const InputDecoration(labelText:'Пароль'), obscureText:true,
        validator:(v)=>v==null||v.length<8?'Минимум 8 символов':null),
      const SizedBox(height:20),
      FilledButton(onPressed:(){if(formKey.currentState!.validate()) Navigator.push(context,MaterialPageRoute(builder:(_)=>RegistrationDoneScreen(name:name.text)));},child:const Text('Создать аккаунт')),
    ]))));
}
class RegistrationDoneScreen extends StatelessWidget {
  final String name;
  const RegistrationDoneScreen({super.key, required this.name});
  @override
  Widget build(BuildContext context) => Scaffold(appBar:AppBar(title:const Text('Готово')),body:Center(child:Text('Аккаунт создан: $name')));
}
