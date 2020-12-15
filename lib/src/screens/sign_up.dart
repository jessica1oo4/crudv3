import 'package:crudv3/src/screens/products.dart';
import 'package:crudv3/src/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
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
                  User user = await authService.signUp(
                    emailController.text.trim(),
                    pwController.text.trim(),
                  );
                  if (user != null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Products()));
                  } else {
                    print('user is null');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
