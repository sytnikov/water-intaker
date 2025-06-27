import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  void addWater() {
    showDialog(context: context, builder: (context) => 
      AlertDialog(
        title: Text('Add Water'),
        content: Column(
          children: [
            Text('Add water to your daily intake...')
          ],
        ),
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water'),
        centerTitle: true,
        elevation: 4,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.map))],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: addWater,
        child: Icon(Icons.add),
      ),
    );
  }
}
