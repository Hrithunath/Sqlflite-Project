import 'package:flutter/material.dart';

class grid_view extends StatelessWidget {
  const grid_view({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: Text('Grid View'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.list))],
      ),
      body: Center(
        child: Text('No Data'),
      ),
    );
  }
}
