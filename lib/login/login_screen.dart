import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_adminpanel/home_screen.dart';

class loginScreen extends StatefulWidget {
  static const String id ="login Screen";
  const loginScreen({super.key,});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var username,password;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body:
      Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              Image.asset('assets/images/Final_Pizza_logo.png'),
              const Text("Admin panel",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 30),),
              const SizedBox(height: 30,),
              SizedBox(
                width: 395,
                child: TextField(
                  controller: emailController,
                  maxLength: 16,
                  style: const TextStyle(
                      color: Colors.white
                  ),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey
                      ),),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey
                      ),
                    ),
                    label: Text('E-mail'),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              SizedBox(
                width: 395,
                child: TextField(
                  style: const TextStyle(
                      color: Colors.white
                  ),
                  maxLength: 13,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey
                      ),
                    ),
                    label: Text('Password'),
                    focusColor: Colors.transparent,
                  ),
          
                ),
              ),
              SizedBox(height: 5,),
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(187, 63, 221, 1),
                      Color.fromRGBO(251, 109, 169, 1),
                      Color.fromRGBO(255, 159, 124, 1),
                    ])
                ),
                child: ElevatedButton(
                    onPressed: (){
                      saveData();
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize:  const Size(395, 55),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
          
                    ),
                    child:   const  Text("Log In",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white))),
              ),
          
            ],
          ),
        ),
      ),
    );
  }
  void saveData() async{
    await FirebaseFirestore.instance.collection("AdminAccess")
        .doc("admin").get(
    ).then((value) {
      if(value.exists){
        username = value.get('username');
        password = value.get('password');
        if(username == emailController.text.toString()){
          if(password == passwordController.text.toString()){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
          }else{
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sorry! Enter Correct Password ')));
          }
        }else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sorry!Enter Correct username ')));
        }
      }
    });
  }
}
