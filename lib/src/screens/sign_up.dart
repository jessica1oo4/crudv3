import 'package:crudv3/src/providers/auth_provider.dart';
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
  GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = context.watch<AuthService>();
    AuthProvider authProvider = context.watch<AuthProvider>();
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Form(
            key: _signUpKey,
            child: Column(
              children: [
                Text('Create an Account'),
                TextFormField(
                  validator: (s) {
                    if (s.isEmpty || !s.contains('@')) {
                      return 'Please provide an email address pleaseee';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(labelText: 'Email Address'),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                ),
                TextFormField(
                  validator: (s) {
                    if (s.length < 6) {
                      return 'your password must be at least 6 characters long';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: pwController,
                ),
                RaisedButton(
                  child: Text('Create My Account'),
                  onPressed: () async {
                    if (_signUpKey.currentState.validate()) {
                      AppUser appUser = await authService.signUp(
                          emailController.text.trim(),
                          pwController.text.trim());
                      if (appUser == null) {
                        authProvider.setError(
                            'Error Creating Account. Check Your SHIT.');
                      }
                    }
                  },
                ),
                Text(
                  authProvider.error,
                  style: TextStyle(color: Colors.pinkAccent),
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
      ),
    );
  }
}
