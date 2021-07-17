import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/todoItem.dart';
import 'package:todo/utils/dbhelper.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  DbHelper db = DbHelper();
  List<Todo> todos = [];

  @override
  void initState() {
    _getTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? _value;

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20.0, bottom: 20.0),
            child: Text(
              '🙏\nhello there',
              style: TextStyle(
                fontSize: 34.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(child: TodoItem(todos: todos))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Add Todo'),
              content: SingleChildScrollView(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'What will you do?',
                  ),
                  onChanged: (v) {
                    _value = v;
                  },
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    // print(_value);
                    await db.openDb();
                    await db.insert(new Todo(_value!));

                    setState(() {
                      _getTodo();
                    });

                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                )
              ],
            ),
          )
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _getTodo() async {
    await db.openDb();
    todos = await db.getAll();
    setState(() {});
  }
}
