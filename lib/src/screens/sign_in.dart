import 'package:crudv3/src/models/app_user.dart';
import 'package:crudv3/src/providers/auth_provider.dart';
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
  GlobalKey<FormState> _signInKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    AuthProvider authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text('Welcome to this learning appp!')),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Form(
            key: _signInKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (s) {
                    return s.isEmpty ? 'Type in Your Email Address' : null;
                  },
                  decoration: InputDecoration(labelText: 'Email Address'),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                ),
                TextFormField(
                  validator: (s) {
                    return s.length < 6
                        ? 'Your password must be at least 6 characters long'
                        : null;
                  },
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: pwController,
                ),
                RaisedButton(
                  child: Text('Sign In'),
                  onPressed: () async {
                    if (_signInKey.currentState.validate()) {
                      AppUser appUser = await authService.signIn(
                          emailController.text.trim(),
                          pwController.text.trim());
                      if (appUser == null) {
                        authProvider
                            .setError('Error Cannot Sign In. Check your shit.');
                      }
                    }
                  },
                ),
                Text(authProvider.error),
                RaisedButton(
                    child: Text(
                      'Create An Account Instead',
                    ),
                    onPressed: () {
                      widget.toggleScreen();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
