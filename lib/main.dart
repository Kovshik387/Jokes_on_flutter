import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/pages/home.dart';
import 'package:hello_flutter/pages/main_screen.dart';
import 'package:hello_flutter/pages/pageAll.dart';
import 'firebase_options.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainPrek()
  );
}

class MainPrek extends StatelessWidget {
  const MainPrek({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      theme: ThemeData(primaryColor: Colors.lightBlue),
      initialRoute: '/todo',
      routes: {
        '/todo': (context) => const Home(),
        '/page': (context) => const Home(),
        '/pages': (context) => const MyApp(),
        '/main': (context) => const MainScreen(),
      },
    ));
  }
}

// TEMP!!!!

