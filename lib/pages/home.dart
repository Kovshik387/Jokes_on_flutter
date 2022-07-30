// ignore_for_file: unused_label

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
// ignore: unused_import
import 'package:convert/convert.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
//List StarAnekd = ['Я тут жил и буду жить я всегда тут буду'];

List<String> Anekdot = [];
bool _isLoading = true;

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  get direction => null;

  @override
  void initState() {
    super.initState();
    GetActivity();
  }

// Получение подписи
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  // ignore: non_constant_identifier_names
  Future<String> GetActivity() async {
    // ignore: constant_identifier_names
    const String KEY_ =
        'e09c6493c7fe9269dd9919578ffae1a9701b9223da9f7d8726e36b8ef0243676';
    // ignore: constant_identifier_names
    const String PID = 'w193z1w8epmeemwdiwx5';

    // ignore: prefer_interpolation_to_compose_strings
    String query = 'pid=' +
        PID +
        '&method=getRandItem&uts=' +
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    var signature = generateMd5(query + KEY_);

    // ignore: prefer_interpolation_to_compose_strings
    String url = 'http://anecdotica.ru/api?' +
        query +
        '&hash=' +
        // generateMd5(signature);
        signature;

    var searchResult = await http.get(Uri.parse(url));

    var result = json.decode(searchResult.body)["item"]["text"];

    // ignore: avoid_print, prefer_interpolation_to_compose_strings

    setState(() {
      Anekdot.add(result);
    });

    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Анекдоты'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 4, 61, 107),
      ),
      body: ListView.builder(
          itemCount: Anekdot.length,
          itemBuilder: (BuildContext context, int index) {
            if (Anekdot.isEmpty)
              Center(child: Text('Загрузка', textAlign: TextAlign.center));
            return Slidable(
              key: Key(Anekdot[index]),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(onDismissed: () {
                  setState(() {
                    // ignore: non_constant_identifier_names
                    String Temp;
                    Temp = Anekdot[0];
                    Anekdot.clear();
                    GetActivity();

                    FirebaseFirestore.instance
                        .collection('Star')
                        .add({'Star': Temp});
                    Scaffold.of(context)
                        // ignore: deprecated_member_use
                        .showSnackBar(const SnackBar(
                            content: Text('Сохранено'),
                            duration: Duration(milliseconds: 50)));
                  });
                }),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      setState(() {
                        // ignore: non_constant_identifier_names
                        String Temp;
                        Temp = Anekdot[0];
                        Anekdot.clear();
                        GetActivity();

                        FirebaseFirestore.instance
                            .collection('Star')
                            .add({'Star': Temp});
                        Scaffold.of(context)
                            // ignore: deprecated_member_use
                            .showSnackBar(const SnackBar(
                                content: Text('Сохранено'),
                                duration: Duration(milliseconds: 50)));
                      });
                    },
                    backgroundColor: Color(0xFF0392CF),
                    foregroundColor: Colors.white,
                    icon: Icons.archive,
                    label: 'Сохранить',
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(onDismissed: ((() {
                  setState(() {
                    Anekdot.clear();
                    GetActivity();
                    // ignore: deprecated_member_use
                    Scaffold.of(context).showSnackBar(const SnackBar(
                        content: Text('Удалено'),
                        duration: Duration(milliseconds: 50)));
                  });
                }))),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      setState(() {
                        Anekdot.clear();

                        GetActivity();
                        // ignore: deprecated_member_use
                        Scaffold.of(context).showSnackBar(const SnackBar(
                            content: Text('Удалено'),
                            duration: Duration(milliseconds: 50)));
                      });
                    },
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete_forever,
                    label: 'Удалить',
                  ),
                ],
              ),
              child: SizedBox(
                height: 600,
                child: Center(
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0))),
                    color: const Color.fromARGB(255, 77, 151, 194),
                    shadowColor: Colors.black87,
                    //margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListTile(
                      title: Text(
                        Anekdot[0],
                        style: const TextStyle(fontSize: 24),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ),
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
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  accountEmail: Text('https://github.com/Kovshik387',
                      style: TextStyle(color: Colors.white))),
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
            //         context, '/main', (route) => false);
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
