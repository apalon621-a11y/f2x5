import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'task_edit_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<String> tasks = [
    'не отупеть',
    'Найти Милфу',
    'апнуть 10к в Клешь рояле',
  ];

  Future<void> addTask() async {
    final controller = TextEditingController();
    try {
      final newTask = await showDialog<String>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Новая задача'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Введите название задачи',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pop(dialogContext, controller.text.trim()),
              child: const Text('Добавить'),
            ),
          ],
        ),
      );

      if (newTask != null && newTask.isNotEmpty && mounted) {
        setState(() {
          tasks.add(newTask);
        });
      }
    } finally {
      controller.dispose();
    }
  }

  Future<void> editTask(int index) {
    return Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => TaskEditScreen(taskName: tasks[index]),
      ),
    ).then((newTitle) {
      if (newTitle != null && mounted) {
        setState(() {
          tasks[index] = newTitle;
        });
      }
    });
  }

  Future<void> showTaskMenu(int index) async {
    final action = await showModalBottomSheet<String>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Редактировать'),
              onTap: () => Navigator.pop(sheetContext, 'edit'),
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Удалить'),
              onTap: () => Navigator.pop(sheetContext, 'delete'),
            ),
          ],
        ),
      ),
    );

    if (!mounted || action == null) return;

    if (action == 'edit') {
      await editTask(index);
      return;
    }

    if (action == 'delete') {
      final confirmed = await showCupertinoDialog<bool>(
        context: context,
        builder: (dialogContext) => CupertinoAlertDialog(
          title: const Text('точно не пожелеешь?'),
          content: const Text('точно точно ?'),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Отмена'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Удалить'),
            ),
          ],
        ),
      );

      if (confirmed == true && mounted) {
        setState(() {
          tasks.removeAt(index);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Список задач')),
      body: tasks.isEmpty
          ? const Center(child: Text('Задач пока нет'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) => GestureDetector(
                onLongPress: () => showTaskMenu(index),
                child: ListTile(
                  title: Text(tasks[index]),
                  onTap: () => editTask(index),
                  trailing: IconButton(
                    tooltip: 'Действия с задачей',
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => showTaskMenu(index),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        tooltip: 'Добавить задачу',
        child: const Icon(Icons.add),
      ),
    );
  }
}
