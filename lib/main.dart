import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';
import 'screens/contacts_screen.dart';
import 'screens/drag_circle_screen.dart';
import 'screens/auth_screens.dart';
import 'screens/tasks_screen.dart';

void main() => runApp(const MyApp());

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
