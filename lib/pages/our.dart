import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(251, 102, 162, 210),
      appBar: AppBar(
        title: const Text('Фантокины Анекдоты'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(251, 102, 162, 210),
      ),
      body: Center(
        child: Column(children: const [
          Text(
            'О нас',
            style:
                TextStyle(color: Color.fromARGB(255, 22, 18, 5), fontSize: 40),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }
}
