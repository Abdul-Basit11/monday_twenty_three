import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monday_twenty_three/back_end/model/task_model.dart';
import 'package:monday_twenty_three/back_end/services/task_service.dart';
import 'package:monday_twenty_three/front_end/display_complete_task.dart';
import 'package:monday_twenty_three/front_end/display_incom_task.dart';
import 'package:monday_twenty_three/front_end/first_screen.dart';
import 'package:monday_twenty_three/front_end/update_task_view.dart';
import 'package:provider/provider.dart';

class Displayscreen extends StatefulWidget {
  const Displayscreen({Key? key}) : super(key: key);

  @override
  State<Displayscreen> createState() => _DisplayscreenState();
}

class _DisplayscreenState extends State<Displayscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push((context), MaterialPageRoute(builder: (context)=>DisplayCompletedTask()));
          }, icon: Icon(Icons.checklist)),
          IconButton(onPressed: (){
            Navigator.push((context), MaterialPageRoute(builder: (context)=>DisplayInCompleteTasks()));

          }, icon: Icon(Icons.mark_chat_read_outlined)),
        ],
        backgroundColor: Colors.purple.shade800,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Display Task',
          style: GoogleFonts.bebasNeue(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              wordSpacing: 10,
              letterSpacing: 5),
        ),
      ),
      body: StreamProvider.value(
        value: TaskServices().fetchAllTask(),
        initialData: [TaskModel()],
        builder: (context, child) {
          List<TaskModel> _list = context.watch<List<TaskModel>>();
          return ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(_list[i].taskTitle.toString()),
                  subtitle: Text(_list[i].description.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        splashRadius: 18,
                        splashColor: Colors.red,
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          TaskServices().deleteTask(_list[i].docId.toString());
                        },
                      ),
                      IconButton(
                        splashRadius: 18,
                        splashColor: Colors.blue,
                        icon: Icon(Icons.edit, color: Colors.red),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateTaskView(_list[i])));
                        },
                      ),
                      IconButton(onPressed: (){
                        TaskServices().markTaskAsCompleted(_list[i].docId.toString());
                      }, icon: Icon(Icons.done,color: Colors.green,))
                    ],
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.purple.shade800.withOpacity(0.8),
        onPressed: (){
          Navigator.push((context), MaterialPageRoute(builder: (context)=>Firstscreen()));
        },child: Icon(Icons.add),
      ),
    );
  }
}
