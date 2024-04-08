import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskly/models/model.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  _HomePageState();
  late double _deviceHeight, _deviceWidth;
  String? _newTaskTitle;
  Box? _box;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.15,
        title: const Center(
          child: Text(
            "Taskly",
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: _taskView(),
      floatingActionButton: _addTaskButtom(),
    );
  }

  Widget _taskView() {
    return FutureBuilder(
      future: Hive.openBox('tasks'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _box = snapshot.data;
          return _taskList();
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _taskList() {
    List tasks = _box!.values.toList();
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        var task = Task.fromMap(tasks[index]);
        return ListTile(
          title: Text(
            task.taskTitle,
            style: TextStyle(
              decoration: task.isDone ? TextDecoration.lineThrough : null,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(DateTime.now().toString()),
          trailing: Icon(
            task.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.red,
          ),
          onTap: () {
            task.isDone = !task.isDone;
            _box?.putAt(index, task.toMap());
            setState(() {});
          },
          onLongPress: () {
            _box?.deleteAt(index);
            setState(() {});
          },
        );
      },
    );
  }

  Widget _addTaskButtom() {
    return FloatingActionButton(
      onPressed: _displayTaskPopup,
      backgroundColor: Colors.red,
      child: const Icon(Icons.add),
    );
  }

  void _displayTaskPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add new task"),
          content: TextField(
            onSubmitted: (value) {
              if (_newTaskTitle != null) {
                var task = Task(
                    taskTitle: _newTaskTitle!,
                    taskTime: DateTime.now(),
                    isDone: false);
                _box?.add(task.toMap());
                setState(() {
                  _newTaskTitle = null;
                });
                Navigator.pop(context);
              }
            },
            onChanged: (value) {
              setState(
                () {
                  _newTaskTitle = value;
                },
              );
            },
          ),
        );
      },
    );
  }
}
