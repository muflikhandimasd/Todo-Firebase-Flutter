import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:do_fire/pages/todo_list.dart';
import 'package:do_fire/services/todo_services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoServices>(
      create: (context) => TodoServices(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodoList(),
      ),
    );
  }
}
