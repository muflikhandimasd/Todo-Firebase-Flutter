import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:do_fire/models/todo.dart';

class TodoServices with ChangeNotifier {
  List<Todo> todos = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addTodo(Todo todo) async {
    // todos.add(todo);
    await firestore.collection('todos').add({
      'title': todo.title,
    }).then((value) {
      todo.id = value.id;
      todos.add(todo);
    });
    notifyListeners();
  }

  void updateTodo(Todo todo) async {
    var _index = todos.indexWhere((element) => element.id == todo.id);
    if (_index != -1) {
      await firestore.collection('todos').doc(todo.id).update({
        'title': todo.title,
      });
      todos[_index] = todo;
    }

    notifyListeners();
  }

  void removeTodo(String id) async {
    var index = todos.indexWhere((element) => element.id == id);
    if (index != -1) {
      await firestore.collection('todos').doc(id).delete();
      todos.removeAt(index);
    }

    notifyListeners();
  }
}
