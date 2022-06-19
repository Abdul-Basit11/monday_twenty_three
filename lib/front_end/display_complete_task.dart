import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monday_twenty_three/back_end/services/task_service.dart';
import 'package:provider/provider.dart';

import '../back_end/model/task_model.dart';



class DisplayCompletedTask extends StatefulWidget {


    DisplayCompletedTask({Key? key}) : super(key: key);

  @override
  State<DisplayCompletedTask> createState() => _DisplayCompletedTaskState();
}

class _DisplayCompletedTaskState extends State<DisplayCompletedTask> {
  final TaskServices _taskServices=TaskServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade800,
        title:  Text(
          'Complete Task',
          style: GoogleFonts.bebasNeue(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              wordSpacing: 10,
              letterSpacing: 5),
        )
      ),
      body: StreamProvider.value(
        value: _taskServices.fetchCompletedTask(),
        initialData: [TaskModel()],
        builder: (context, child) {
          List<TaskModel> _tasksList = context.watch<List<TaskModel>>();
          return ListView.builder(
              itemCount: _tasksList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tasksList[index].taskTitle.toString()),
                  subtitle: Text(_tasksList[index].description.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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