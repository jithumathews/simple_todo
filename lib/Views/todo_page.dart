import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo/Widget/todo_widget_list.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_todo/database/database.dart';
import '../Provider/todo_provider.dart';

class Todo_Page extends StatefulWidget {
  const Todo_Page({Key? key}) : super(key: key);

  @override
  _Todo_PageState createState() => _Todo_PageState();
}

class _Todo_PageState extends State<Todo_Page> {
  final _textFieldController = TextEditingController();
  String newTask = '';
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    db.loadData();

    super.initState();
    _textFieldController.addListener(() {
      newTask = _textFieldController.text;
    });
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  void _submit() {
    Provider.of<TodoProvider>(context, listen: false).addTask(newTask);
    db.toDoList.add(newTask);
    Navigator.pop(context);
    _textFieldController.clear();
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showAddTextDialog() async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Add a new Task"),
              content: TextField(
                autofocus: true,
                controller: _textFieldController,
                decoration: const InputDecoration(hintText: "Add New Task"),
                onSubmitted: (_) => _submit(),
              ),
              actions: [
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text("Submit"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(120, 40)),
                )
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              actionsAlignment: MainAxisAlignment.center,
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Todo"),
      ),
      body: Todo_Base(),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          _showAddTextDialog();
        }),
        child: const Icon(Icons.add),
        tooltip: "Add a todo",
      ),
    );
  }
}
