import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _fullnamecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _form,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Full Name";
                      } else {
                        return null;
                      }
                    },
                    controller: _emailcontroller,
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter email";
                      } else {
                        return null;
                      }
                    },
                    obscureText: true,
                    controller: _passcontroller,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  SizedBox(height: 20,),


                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter password";
                      } else if (value.length < 6) {
                        return 'Enter Strong Passwrod';
                      } else {
                        return null;
                      }
                    },
                    obscureText: true,
                    controller: _passcontroller,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(height: 20,),

                  OutlinedButton(onPressed: () {
                    if (_form.currentState!.validate()){
                      print("Successfully");
                    }
                  }, child: Text('Signup'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
