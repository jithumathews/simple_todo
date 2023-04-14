import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/todo_provider.dart';

class Todo_Base extends StatelessWidget {
  const Todo_Base({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<TodoProvider>(context);
    return ListView.builder(
      itemCount: task.allTasks.length,
      itemBuilder: ((context, index) => ListTile(
            leading: Checkbox(
              value: task.allTasks[index].completed,
              onChanged: ((_) => task.toggleTask(task.allTasks[index])),
            ),
            title: Text(task.allTasks[index].todoTitle),
            trailing: IconButton(
                onPressed: () {
                  task.deleteTask(task.allTasks[index]);
                },
                icon: const Icon(Icons.delete)),
          )),
    );
  }
}
