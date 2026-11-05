import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class TaskEditScreen extends StatefulWidget {
  final String initialValue;
  const TaskEditScreen({super.key, required this.initialValue});

  @override
  State<TaskEditScreen> createState() => _TaskEditScreenState();
}
