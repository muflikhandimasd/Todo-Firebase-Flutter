import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:do_fire/models/todo.dart';
import 'package:do_fire/services/todo_services.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo App with Firebase',
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Consumer<TodoServices>(
        builder: (context, value, child) => ListView.builder(
          itemBuilder: (context, index) => ListTile(
            title: Text(value.todos[index].title ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    TextEditingController titleController =
                        TextEditingController(text: value.todos[index].title);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: TextField(
                          controller: titleController,
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              var tempTodo = Todo(title: titleController.text);
                              tempTodo.id = value.todos[index].id;
                              context.read<TodoServices>().updateTodo(tempTodo);
                              Navigator.pop(context);
                            },
                            child: const Text('Update'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.amber,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context
                        .read<TodoServices>()
                        .removeTodo(value.todos[index].id);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          itemCount: value.todos.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          TextEditingController titleController = TextEditingController();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: TextField(
                controller: titleController,
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black54),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    context.read<TodoServices>().addTodo(
                          Todo(title: titleController.text),
                        );
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
