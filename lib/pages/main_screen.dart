import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/pages/home.dart';

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
        child: Column(children: [
          const Text(
            'О нас',
            style:
                TextStyle(color: Color.fromARGB(255, 22, 18, 5), fontSize: 40),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 37, 84, 123)),
              child: Text('Меню'),
            ),
            ListTile(
              title: const Text("Анекдоты"),
              // trailing: Icon(Icons.arrow_back),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/todo', (route) => false);

                Anekdot.clear();
              },
            ),
            ListTile(
              title: const Text("Сохраненные Анекдоты"),
              trailing: const Icon(Icons.star),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/pages', (route) => false);
              },
            ),
            ListTile(
              title: const Text('О нас'),
              trailing: const Icon(Icons.mail),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/Our', (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
