import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Моё приложение',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final pages = const [
    ProfileScreen(),
    ContactsScreen(),
    DragCircleScreen(),
    LoginScreen(),
    TasksScreen(),
  ];

  final titles = const ['Профиль', 'Контакты', 'Круг', 'Вход', 'Задачи'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titles[selectedIndex]), centerTitle: true),
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => setState(() => selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.person), label: 'Профиль'),
          NavigationDestination(icon: Icon(Icons.contacts), label: 'Контакты'),
          NavigationDestination(icon: Icon(Icons.circle_outlined), label: 'Круг'),
          NavigationDestination(icon: Icon(Icons.login), label: 'Вход'),
          NavigationDestination(icon: Icon(Icons.task_alt), label: 'Задачи'),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const CircleAvatar(
              radius: 55,
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.person, size: 65, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text('Кристина Роналдо',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('ГНОМ'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ProfileDetailsScreen())),
              child: const Text('Подробнее о профиле'),
            ),
          ]),
        ),
      ),
    );
  }
}

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Информация о профиле')),
        body: const ListView(padding: EdgeInsets.all(20), children: [
          ListTile(leading: Icon(Icons.person), title: Text('Кристина Роналдо')),
          ListTile(leading: Icon(Icons.badge), title: Text('ГНОМ')),
          ListTile(leading: Icon(Icons.info_outline), title: Text('Личный профиль')),
        ]),
      );
}

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  static const contacts = [
    ('Данил Колбосенко', '+996 555 123 456'),
    ('Кристина Роналдо', '+996 700 234 567'),
    ('Сократ', '+996 550 456 789'),
    ('Микрозайм', '+996 990 567 890'),
    ('Огузек', '+996 707 678 901'),
    ('Скала', '+996 772 890 123'),
    ('Путин', '+996 500 901 234'),
    ('Жена', '+996 550 333 444'),
  ];

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            leading: CircleAvatar(child: Text(contact.$1[0])),
            title: Text(contact.$1),
            subtitle: Text(contact.$2),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => ContactDetailsScreen(
                  name: contact.$1, phone: contact.$2))),
          );
        },
      );
}

class ContactDetailsScreen extends StatelessWidget {
  final String name;
  final String phone;
  const ContactDetailsScreen({super.key, required this.name, required this.phone});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Контакт')),
        body: Center(child: Card(
          margin: const EdgeInsets.all(24),
          child: Padding(padding: const EdgeInsets.all(24), child: Column(
            mainAxisSize: MainAxisSize.min, children: [
              CircleAvatar(radius: 38, child: Text(name[0], style: const TextStyle(fontSize: 28))),
              const SizedBox(height: 16),
              Text(name, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(phone),
            ],
          )),
        )),
      );
}

class DragCircleScreen extends StatefulWidget {
  const DragCircleScreen({super.key});

  @override
  State<DragCircleScreen> createState() => _DragCircleScreenState();
}

class _DragCircleScreenState extends State<DragCircleScreen> {
  Offset? position;
  static const circleSize = 80.0;

  @override
  Widget build(BuildContext context) => Column(children: [
        Expanded(child: LayoutBuilder(builder: (context, constraints) {
          position ??= Offset((constraints.maxWidth-circleSize)/2,
              (constraints.maxHeight-circleSize)/2);
          final maxX = (constraints.maxWidth-circleSize).clamp(0.0, double.infinity);
          final maxY = (constraints.maxHeight-circleSize).clamp(0.0, double.infinity);
          return Stack(children: [
            Positioned(left: position!.dx, top: position!.dy,
              child: GestureDetector(
                onPanUpdate: (details) => setState(() => position = Offset(
                  (position!.dx+details.delta.dx).clamp(0.0, maxX),
                  (position!.dy+details.delta.dy).clamp(0.0, maxY))),
                child: Container(width: circleSize, height: circleSize,
                  decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
              )),
          ]);
        })),
        Padding(padding: const EdgeInsets.all(12), child: TextButton.icon(
          onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const DragDetailsScreen())),
          icon: const Icon(Icons.info_outline), label: const Text('Как пользоваться'))),
      ]);
}

class DragDetailsScreen extends StatelessWidget {
  const DragDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Перетаскивание круга')),
    body: const Padding(padding: EdgeInsets.all(24), child: Text(
      'Зажмите синий круг пальцем и перемещайте его по экрану. '
      'Круг остаётся в пределах доступной области.')),
  );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(child: SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Form(key: formKey, child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.account_circle, size: 80),
      const SizedBox(height: 20),
      TextFormField(controller: emailController,
        decoration: const InputDecoration(labelText: 'Электронная почта', prefixIcon: Icon(Icons.email)),
        keyboardType: TextInputType.emailAddress,
        validator: (v) => (v != null && RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v))
          ? null : 'Введите корректную почту'),
      const SizedBox(height: 12),
      TextFormField(controller: passwordController, obscureText: true,
        decoration: const InputDecoration(labelText: 'Пароль', prefixIcon: Icon(Icons.lock)),
        validator: (v) => (v == null || v.isEmpty) ? 'Введите пароль' : null),
      const SizedBox(height: 18),
      FilledButton(onPressed: () {
        if (formKey.currentState!.validate()) {
          Navigator.push(context, MaterialPageRoute(builder: (_) =>
            WelcomeScreen(email: emailController.text.trim())));
        }
      }, child: const Text('Войти')),
      TextButton(onPressed: () => Navigator.push(context,
        MaterialPageRoute(builder: (_) => const RegisterScreen())),
        child: const Text('Регистрация')),
    ])),
  ));

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

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    name.dispose(); email.dispose(); phone.dispose(); password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Регистрация')),
    body: SingleChildScrollView(padding: const EdgeInsets.all(24),
      child: Form(key: formKey, child: Column(children: [
        TextFormField(controller: name, decoration: const InputDecoration(labelText: 'Имя'),
          validator: (v) => v == null || v.trim().isEmpty ? 'Введите имя' : null),
        TextFormField(controller: email, decoration: const InputDecoration(labelText: 'Электронная почта'),
          keyboardType: TextInputType.emailAddress,
          validator: (v) => v != null && RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v) ? null : 'Некорректная почта'),
        TextFormField(controller: phone, decoration: const InputDecoration(labelText: 'Телефон'),
          keyboardType: TextInputType.phone,
          validator: (v) => v == null || v.trim().isEmpty ? 'Введите телефон' : null),
        TextFormField(controller: password, decoration: const InputDecoration(labelText: 'Пароль'),
          obscureText: true, validator: (v) => v == null || v.length < 8 ? 'Минимум 8 символов' : null),
        const SizedBox(height: 20),
        FilledButton(onPressed: () {
          if (formKey.currentState!.validate()) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => RegistrationDoneScreen(name: name.text)));
          }
        }, child: const Text('Создать аккаунт')),
      ])),
    ),
  );
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

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<String> tasks = ['не отупеть', 'Найти Милфу', 'апнуть 10к в Клешь рояле'];

  Future<void> addTask() async {
    final controller = TextEditingController();
    final value = await showDialog<String>(context: context, builder: (dialogContext) =>
      AlertDialog(title: const Text('Новая задача'),
        content: TextField(controller: controller, autofocus: true,
          decoration: const InputDecoration(hintText: 'Название задачи')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Отмена')),
          FilledButton(onPressed: () => Navigator.pop(dialogContext, controller.text.trim()),
            child: const Text('Добавить')),
        ]));
    controller.dispose();
    if (value != null && value.isNotEmpty) setState(() => tasks.add(value));
  }

  Future<void> editTask(int index) async {
    final controller = TextEditingController(text: tasks[index]);
    final value = await Navigator.push<String>(context,
      MaterialPageRoute(builder: (_) => TaskEditScreen(initialValue: tasks[index])));
    controller.dispose();
    if (value != null && value.trim().isNotEmpty) setState(() => tasks[index] = value.trim());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: tasks.isEmpty ? const Center(child: Text('Задач пока нет'))
      : ListView.builder(itemCount: tasks.length, itemBuilder: (context, index) =>
        ListTile(leading: const Icon(Icons.task_alt), title: Text(tasks[index]),
          trailing: IconButton(icon: const Icon(Icons.delete_outline),
            onPressed: () => setState(() => tasks.removeAt(index))),
          onTap: () => editTask(index))),
    floatingActionButton: FloatingActionButton(onPressed: addTask, child: const Icon(Icons.add)),
  );
}

class TaskEditScreen extends StatefulWidget {
  final String initialValue;
  const TaskEditScreen({super.key, required this.initialValue});

  @override
  State<TaskEditScreen> createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Редактировать задачу')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: controller, autofocus: true,
        decoration: const InputDecoration(labelText: 'Название задачи')),
      const SizedBox(height: 16),
      FilledButton(onPressed: () => Navigator.pop(context, controller.text),
        child: const Text('Сохранить')),
    ])),
  );
}
