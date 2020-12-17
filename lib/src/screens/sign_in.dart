import 'package:crudv3/src/models/app_user.dart';
import 'package:crudv3/src/screens/sign_up.dart';
import 'package:crudv3/src/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  Function toggleScreen;

  SignInScreen({this.toggleScreen});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text('Welcome to this learning appp!')),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Email Address'),
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                controller: pwController,
              ),
              RaisedButton(
                child: Text('Sign In'),
                onPressed: () async {
                  AppUser appUser = await authService.signIn(
                      emailController.text.trim(), pwController.text.trim());
                  print(appUser);
                },
              ),
              RaisedButton(
                  child: Text('Create An Account Instead'),
                  onPressed: () {
                    widget.toggleScreen();

//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => SignUpScreen(),
//                      ),
//                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
