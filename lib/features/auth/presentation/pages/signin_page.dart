import 'package:flutter/material.dart';
import 'package:fyp/features/auth/presentation/pages/signup_page.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});
  

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passworcontroller = TextEditingController();
  
  @override
  void dispose() {
    emailcontroller.dispose();
    passworcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              
               TextFormField(
                                decoration: InputDecoration(hintText: 'email'),

                controller: emailcontroller,
               ),
               TextFormField(
                                decoration: InputDecoration(hintText: 'password'),

                controller: passworcontroller,
               ),
                
               TextButton(onPressed: (){}, child: Text('Sign In')),
                              TextButton(onPressed: (){
                                Get.to(SignUpPage());
                              }, child: Text('Sign Up'))

            ],
          ),
        ),
      
    );
  }
}