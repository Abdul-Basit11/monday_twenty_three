import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monday_twenty_three/front_end/display_task_detail.dart';
import 'package:monday_twenty_three/front_end/update_task_view.dart';
import 'package:provider/provider.dart';


import '../back_end/model/task_model.dart';
import '../back_end/services/task_service.dart';


class DisplayInCompleteTasks extends StatelessWidget {

  final TaskServices _taskServices = TaskServices();

  DisplayInCompleteTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade800,
        title: Text("InCompleted Tasks",style:GoogleFonts.bebasNeue(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            wordSpacing: 10,
            letterSpacing: 5),),
      ),
      body: StreamProvider.value(
        value: _taskServices.fetchIncompleteTask(),
        initialData: [TaskModel()],
        builder: (context, child) {
          List<TaskModel> _tasksList = context.watch<List<TaskModel>>();
          return ListView.builder(
              itemCount: _tasksList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DisplayTaskDetail(
                                _tasksList[index].taskTitle.toString(),
                                _tasksList[index].description.toString(),
                                _tasksList[index].isCompleted!)));
                  },
                  title: Text(_tasksList[index].taskTitle.toString()),
                  subtitle: Text(_tasksList[index].description.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        splashColor: Colors.blue,
                        icon: const Icon(Icons.done),
                        onPressed: () {
                          _taskServices.markTaskAsCompleted(
                              _tasksList[index].docId.toString());
                          showDialog(
                              context: context,
                              builder: (context) {
                                if (_tasksList[index].isCompleted == true) {
                                  return AlertDialog(
                                    title: const Text("Message!"),
                                    content:
                                    const Text("Task Already completed"),
                                    actions: [
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Okay"))
                                    ],
                                  );
                                } else {
                                  return AlertDialog(
                                    title: const Text("Message!"),
                                    content: const Text("Task Marked complete"),
                                    actions: [
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Okay"))
                                    ],
                                  );
                                }
                              });
                        },
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateTaskView(_tasksList[index])));
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                        splashColor: Colors.red,
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _taskServices
                              .deleteTask(_tasksList[index].docId.toString());
                        },
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}