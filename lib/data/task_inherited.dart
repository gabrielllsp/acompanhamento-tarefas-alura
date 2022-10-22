import 'package:flutter/material.dart';

import '../components/tesk.dart';

class TaskInherited extends InheritedWidget {
   TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
    Task('Aprender Flutter', 'assets/images/dash.png', 3),
    Task('Andar de Bicicleta', 'assets/images/bicicleta.jpeg', 2),
    Task('Ler', 'assets/images/biblia.jpg', 5),
    Task('Jogar', 'assets/images/xadrez.jpg', 2),
    Task('Caminhada', 'assets/images/caminhada.jpeg', 3),
    Task('Esporte', 'assets/images/sport.png', 3)
  ];

  void newTask(String name, String photo, int difficulty){
    taskList.add(Task(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result = context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
