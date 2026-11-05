import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';
import 'screens/contacts_screen.dart';
import 'screens/drag_circle_screen.dart';
import 'screens/auth_screens.dart';
import 'screens/tasks_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Моё приложение',
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
    home: const HomeScreen(),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final pages = const [ProfileScreen(), ContactsScreen(), DragCircleScreen(), LoginScreen(), TasksScreen()];
  final titles = const ['Профиль', 'Контакты', 'Круг', 'Вход', 'Задачи'];
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(titles[selectedIndex]), centerTitle: true),
    body: IndexedStack(index: selectedIndex, children: pages),
    bottomNavigationBar: NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (i) => setState(() => selectedIndex = i),
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
