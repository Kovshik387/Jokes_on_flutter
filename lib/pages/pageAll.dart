// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/pages/home.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Сохраненные анекдоты'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 4, 61, 107),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Star').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
            if (!snapshots.hasData)
              return const Center(
                  child: Text('Нет запесей', textAlign: TextAlign.center));
            return ListView.separated(
              itemCount: snapshots.data.docs.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0))),
                  color: const Color.fromARGB(255, 77, 151, 194),
                  child: ListTile(
                    title: Text(
                      snapshots.data?.docs[index].get('Star'),
                      style: const TextStyle(fontSize: 22),
                    ),
                    trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_sweep,
                          color: Color.fromARGB(255, 11, 96, 165),
                        ),
                        onPressed: () {
                          setState(() {
                            FirebaseFirestore.instance
                                .collection('Star')
                                .doc(snapshots.data.docs[index].id)
                                .delete();
                          });
                        }),
                  ),
                );
              },
            );
          }),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 37, 84, 123)),
              child: UserAccountsDrawerHeader(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 37, 84, 123)),
                  accountName: Text(
                    'Меню',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 30),
                  ),
                  accountEmail: Text('https://github.com/Kovshik387')),
            ),
            ListTile(
              title: const Text("Анекдоты"),
              leading: Icon(Icons.mood),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/todo', (route) => false);
                Anekdot.clear();
              },
            ),
            ListTile(
              title: const Text("Сохраненные Анекдоты"),
              leading: const Icon(Icons.bookmarks_outlined),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/pages', (route) => false);
              },
            ),
            // ListTile(
            //   title: const Text('О нас'),
            //   trailing: const Icon(Icons.mail),
            //   onTap: () {
            //     Navigator.pushNamedAndRemoveUntil(
            //         context, '/Our', (route) => false);
            //   },
            // )
          ],
        ),
      ),
    ));
  }
}
