import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/colors.dart';
import 'package:movie_app/utils/text.dart';
import 'package:movie_app/widgets/auth_method.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailcontrol = TextEditingController();
  final TextEditingController _passcontrol = TextEditingController();
  final TextEditingController _usernamecontrol = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailcontrol.dispose();
    _passcontrol.dispose();
    _usernamecontrol.dispose();
  }

  void mySignUp() async {
    MyAuthMethods(FirebaseAuth.instance).mySignupUser(
        email: _emailcontrol.text,
        password: _passcontrol.text,
        username: _usernamecontrol.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobilebackgroundcolor,
      appBar: AppBar(
          title: const Center(
        child: Text('Sign up'),
      )),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 24,
              ),
              const CircleAvatar(
                radius: 64,
                backgroundColor: Color.fromARGB(179, 89, 86, 86),
                child: Icon(
                  CupertinoIcons.person,
                  size: 50,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //Textfield for username
              TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your Username',
                  ),
                  controller: _usernamecontrol,
                  keyboardType: TextInputType.text),
              const SizedBox(
                height: 24,
              ),
              //Textfield for email
              TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your Email',
                  ),
                  controller: _emailcontrol,
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(
                height: 24,
              ),
              //Textfield for password
              TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your Password',
                  ),
                  controller: _passcontrol,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  mySignUp();
                },
                //for register   button
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: maincolor,
                  ),
                  child: ModifiedText(
                    text: 'Register',
                    size: 15,
                    color: mobilebackgroundcolor,
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
