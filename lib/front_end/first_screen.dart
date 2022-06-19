import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:monday_twenty_three/back_end/model/task_model.dart';
import 'package:monday_twenty_three/back_end/services/task_service.dart';
import 'package:monday_twenty_three/front_end/display_screen.dart';

class Firstscreen extends StatefulWidget {
  const Firstscreen({Key? key}) : super(key: key);

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen> {
  final TaskServices _taskServices = TaskServices();
  final TextEditingController _controllertitle = TextEditingController();
  final TextEditingController _controllerdescription = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  'To Do App',
                  style: GoogleFonts.bebasNeue(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      wordSpacing: 10,
                      letterSpacing: 5),
                )),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _controllertitle,
                  cursorColor: Colors.purple.shade800,
                  cursorWidth: 5,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: Colors.purple.shade800, width: 5)),
                      hintText: 'Enter Task Title',
                      hintStyle: GoogleFonts.rubik(fontSize: 18)),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  cursorColor: Colors.purple.shade800,
                  cursorWidth: 5,
                  controller: _controllerdescription,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: Colors.purple.shade800, width: 5)),
                      hintText: 'Title Description',
                      hintStyle: GoogleFonts.rubik(fontSize: 18)),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple.shade800,
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.3,
                          vertical: 15)),
                  onPressed: () async {
                    makeLoadingTrue();
                    await _taskServices
                        .createTask(TaskModel(
                            taskTitle: _controllertitle.text,
                            description: _controllerdescription.text))

                        /// then function call if run successfully
                        .then((value) {
                      makeLoadingFalse();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.grey,
                              title: Text('Message'),
                              content: Text('TaskCreated Successfully'),
                              actions: [
                                FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Displayscreen()));
                                  },
                                  child: Text(
                                    'Okay',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.grey.shade800,
                                )
                              ],
                            );
                          });
                    })

                        /// error function if we get some error
                        .onError((error, stackTrace) {
                      makeLoadingFalse();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Alert'),
                              content: Text('A undefined error occured'),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Try Again'))
                              ],
                            );
                          });
                    });
                  },
                  child: Text('Create Task'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  makeLoadingTrue() {
    setState(() {
      isLoading = true;
    });
  }

  makeLoadingFalse() {
    setState(() {
      isLoading = false;
    });
  }
}
