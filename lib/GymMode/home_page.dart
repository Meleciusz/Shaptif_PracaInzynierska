import 'package:flutter/material.dart';

class HomePageGym extends StatelessWidget {
  const HomePageGym({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cyclist'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: (){},
            child: const Text("data")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.keyboard_return_outlined),
      ),
    );
  }
}