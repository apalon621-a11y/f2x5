import 'package:flutter/material.dart';

class DragCircleScreen extends StatefulWidget {
  const DragCircleScreen({super.key});
  @override
  State<DragCircleScreen> createState() => _DragCircleScreenState();
}
class _DragCircleScreenState extends State<DragCircleScreen> {
  Offset? position;
  static const size = 80.0;
  @override
  Widget build(BuildContext context) => Column(children: [
    Expanded(child: LayoutBuilder(builder: (context, c) {
      position ??= Offset((c.maxWidth-size)/2, (c.maxHeight-size)/2);
      final maxX = (c.maxWidth-size).clamp(0.0, double.infinity);
      final maxY = (c.maxHeight-size).clamp(0.0, double.infinity);
      return Stack(children: [Positioned(left: position!.dx, top: position!.dy,
        child: GestureDetector(onPanUpdate: (d) => setState(() => position = Offset(
          (position!.dx+d.delta.dx).clamp(0.0,maxX), (position!.dy+d.delta.dy).clamp(0.0,maxY))),
          child: Container(width:size,height:size,decoration:const BoxDecoration(color:Colors.blue,shape:BoxShape.circle))))]);
    })),
    TextButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DragDetailsScreen())),
      icon: const Icon(Icons.info_outline), label: const Text('Как пользоваться')),
  ]);
}
class DragDetailsScreen extends StatelessWidget {
  const DragDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Перетаскивание круга')),
    body: const Padding(padding: EdgeInsets.all(24), child: Text('Зажмите синий круг пальцем и перемещайте его по экрану. Круг остаётся в пределах доступной области.')),
  );
}
