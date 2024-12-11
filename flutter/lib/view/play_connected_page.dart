import 'package:flutter/material.dart';

class ConnectedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connected'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      const Text("人"),
      ElevatedButton(onPressed: () {}, child: const Text("SET"))
        ],
      ),
    );
  }

}
