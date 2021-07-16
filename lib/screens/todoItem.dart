import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/utils/dbhelper.dart';

class TodoItem extends StatefulWidget {
  final List<Todo>? todos;
  const TodoItem({Key? key, this.todos}) : super(key: key);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  DbHelper db = DbHelper();

  @override
  Widget build(BuildContext context) {
    return widget.todos!.length > 0
        ? ListView.builder(
            itemCount: widget.todos!.length > 0 ? widget.todos!.length : 0,
            itemBuilder: (ctx, i) => Dismissible(
              background: Card(
                color: Colors.redAccent,
              ),
              secondaryBackground: Card(
                color: Colors.greenAccent,
              ),
              confirmDismiss: (DismissDirection direction) async {
                await db.openDb();
                if (direction == DismissDirection.startToEnd) {
                  await db.delete(widget.todos![i].id);
                  setState(() {
                    widget.todos!.removeAt(i);
                  });
                  return;
                }
                await db.update(widget.todos![i].id,
                    widget.todos![i].completed == 0 ? 1 : 0);
                setState(() {
                  widget.todos![i].completed =
                      widget.todos![i].completed == 0 ? 1 : 0;
                });
                return;
              },
              key: ValueKey<int?>(widget.todos![i].id),
              child: Card(
                elevation: 0,
                color: widget.todos![i].completed != 0
                    ? Colors.greenAccent[100]
                    : Colors.white,
                child: ListTile(
                  title: Text(widget.todos![i].title),
                ),
              ),
            ),
          )
        : Center(
            child: Text('You don\' have any todos 🤓'),
          );
  }
}
