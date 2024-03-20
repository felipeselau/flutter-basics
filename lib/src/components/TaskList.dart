// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class Task {
  String name;
  bool completed;

  Task({required this.name, required this.completed});
}

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [];

  void addTask(String taskName) {
    setState(() => tasks.add(Task(name: taskName, completed: false)));
  }

  void removeTask(int index) {
    setState(() => tasks.removeAt(index));
  }

  void toggleTaskComplete(int index) {
    setState(() => tasks[index].completed = !tasks[index].completed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        title: const Text(
          "Lista de Tarefas",
          textAlign: TextAlign.center,
        ),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: tasks.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Não há tarefas adicionadas',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    "Adicione uma tarefa clicando no '+'",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  )
                ],
              ),
            )
          : ListView.separated(
              itemCount: tasks.length,
              separatorBuilder: (context, index) => const Divider(
                indent: 12,
                endIndent: 32,
              ),
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Row(
                    children: <Widget>[
                      Checkbox(
                        value: task.completed,
                        onChanged: (value) => toggleTaskComplete(index),
                        fillColor: MaterialStateProperty.resolveWith<Color?>(
                            (states) => states.contains(MaterialState.selected)
                                ? Colors.blue
                                : Colors.white24),
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                      ),
                      Text(
                        task.name,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            decoration: task.completed
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    onPressed: () => removeTask(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    TextEditingController taskController = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Nova Tarefa'),
            content: TextField(
              controller: taskController,
              decoration:
                  const InputDecoration(hintText: 'Digite uma nova tarefa'),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  addTask(taskController.text);
                  Navigator.of(context).pop();
                },
                child: const Text('Adicionar'),
              ),
            ],
          );
        });
  }
}
