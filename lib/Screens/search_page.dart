import 'package:flutter/material.dart';

class search_page extends StatelessWidget {
  const search_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: Text('Search Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: TextFormField(
          decoration: InputDecoration(
              icon: Icon(Icons.search),
              // hintText: 'Search',
              border: OutlineInputBorder()),
        ),
      ),
    );
  }
}
