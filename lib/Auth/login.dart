import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monday_twenty_three/Auth/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailcontroller=TextEditingController();
  TextEditingController _passcontroller=TextEditingController();
  final _form=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _form,
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Text('Log In',style: GoogleFonts.palanquinDark(fontSize: 20,fontWeight: FontWeight.w800)),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter Email";
                        }
                        else
                        {
                          return null;
                        }
                      },
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                       border: OutlineInputBorder(),
                        hintText: 'Email',
                      ),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter Password";
                        }
                        else if(value.length<6){
                          return "Enter Strong Password";
                        }
                        else
                        {
                          return null;
                        }
                      },
                      obscureText: true,
                      controller: _passcontroller,
                      decoration: InputDecoration(
                       border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                    ),
                    SizedBox(height: 20,),
                    OutlinedButton(

                        onPressed: (){
                    if(_form.currentState!.validate()){
                      print("Successfully");
                    }
                    }, child: Text('Login')),
                    SizedBox(height: 20,),
                    Text("Dont have an Account?",style: GoogleFonts.anticSlab(),),
                    SizedBox(height: 20,),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                        },
                        child: Text("sign up" )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
