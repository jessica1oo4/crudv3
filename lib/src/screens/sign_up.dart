import 'package:crudv3/src/screens/products.dart';
import 'package:crudv3/src/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crudv3/src/models/app_user.dart';

class SignUpScreen extends StatefulWidget {
  Function toggleScreen;

  SignUpScreen({this.toggleScreen});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Text('Create an Account'),
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
                child: Text('Create My Account'),
                onPressed: () async {
                  AppUser appUser = await authService.signUp(
                      emailController.text.trim(), pwController.text.trim());

                  //                  if (appUser == null) {
//                  } else {
//                    Navigator.pushReplacement(
//                        context, MaterialPageRoute(builder: (_) => Products()));
//                  }
                },
              ),
              FlatButton.icon(
                onPressed: () {
                  widget.toggleScreen();
                },
                icon: Icon(Icons.perm_identity),
                label: Text('Already Have An Account'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
