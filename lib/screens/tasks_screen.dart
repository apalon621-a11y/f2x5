import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}
class _TasksScreenState extends State<TasksScreen> {
  final List<String> tasks = ['не отупеть', 'Найти Милфу', 'апнуть 10к в Клешь рояле'];
  Future<void> addTask() async {
    final c = TextEditingController();
    final value = await showDialog<String>(context:context,builder:(ctx)=>AlertDialog(title:const Text('Новая задача'),
      content:TextField(controller:c,autofocus:true,decoration:const InputDecoration(hintText:'Название задачи')),
      actions:[TextButton(onPressed:()=>Navigator.pop(ctx),child:const Text('Отмена')),
        FilledButton(onPressed:()=>Navigator.pop(ctx,c.text.trim()),child:const Text('Добавить'))]));
    c.dispose();
    if(value!=null&&value.isNotEmpty) setState(()=>tasks.add(value));
  }
  Future<void> editTask(int i) async {
    final value = await Navigator.push<String>(context,MaterialPageRoute(builder:(_)=>TaskEditScreen(initialValue:tasks[i])));
    if(value!=null&&value.trim().isNotEmpty) setState(()=>tasks[i]=value.trim());
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    body: tasks.isEmpty ? const Center(child:Text('Задач пока нет')) : ListView.builder(itemCount:tasks.length,itemBuilder:(ctx,i)=>ListTile(
      leading:const Icon(Icons.task_alt),title:Text(tasks[i]),onTap:()=>editTask(i),
      trailing:IconButton(icon:const Icon(Icons.delete_outline),onPressed:()=>setState(()=>tasks.removeAt(i))))),
    floatingActionButton:FloatingActionButton(onPressed:addTask,child:const Icon(Icons.add)));
}
class TaskEditScreen extends StatefulWidget {
  final String initialValue;
  const TaskEditScreen({super.key,required this.initialValue});
  @override
  State<TaskEditScreen> createState()=>_TaskEditScreenState();
}
class _TaskEditScreenState extends State<TaskEditScreen> {
  late final TextEditingController controller;
  @override
  void initState(){super.initState();controller=TextEditingController(text:widget.initialValue);}
  @override
  void dispose(){controller.dispose();super.dispose();}
  @override
  Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Редактировать задачу')),
    body:Padding(padding:const EdgeInsets.all(20),child:Column(children:[
      TextField(controller:controller,autofocus:true,decoration:const InputDecoration(labelText:'Название задачи')),
      const SizedBox(height:16),FilledButton(onPressed:()=>Navigator.pop(context,controller.text),child:const Text('Сохранить'))
    ])));
}
