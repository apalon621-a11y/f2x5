import 'package:flutter/material.dart';

class DragCircleScreen extends StatefulWidget {
  const DragCircleScreen({super.key});

  @override
  State<DragCircleScreen> createState() => _DragCircleScreenState();
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
