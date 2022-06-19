import 'package:flutter/material.dart';
import 'package:monday_twenty_three/back_end/model/task_model.dart';
import 'package:monday_twenty_three/back_end/services/task_service.dart';

class UpdateTaskView extends StatefulWidget {
  final TaskModel _model;

  UpdateTaskView(this._model);

  @override
  State<UpdateTaskView> createState() => _UpdateTaskViewState();
}

class _UpdateTaskViewState extends State<UpdateTaskView> {
  TextEditingController _titleController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _titleController =
        TextEditingController(text: widget._model.taskTitle.toString());
    _descriptionController =
        TextEditingController(text: widget._model.description.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade800,
        title: Text("Update Task",style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              cursorColor: Colors.purple.shade800,
              cursorWidth: 5,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: Colors.purple.shade800, width: 5)),
                  hintText: 'Enter Task Title',
                  hintStyle: TextStyle(fontSize: 18)),
              controller: _titleController,
            ),
            SizedBox(
              height: 25,
            ),
            TextFormField(
              cursorColor: Colors.purple.shade800,
              cursorWidth: 5,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: Colors.purple.shade800, width: 5)),
                  hintText: 'Enter Task Title',
                  hintStyle: TextStyle(fontSize: 18)),
              controller: _descriptionController,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Colors.purple.shade800,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.2),
              onPressed: () {
                TaskServices()
                    .updateTask(TaskModel(
                        docId: widget._model.docId.toString(),
                        taskTitle: _titleController.text,
                        description: _descriptionController.text))
                    .then((value) {
                  Navigator.pop(context);
                });
              },
              child: Text(
                "Update Task",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
