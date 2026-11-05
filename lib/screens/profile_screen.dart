import 'package:flutter/material.dart';

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
