import 'package:flutter/material.dart';

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
