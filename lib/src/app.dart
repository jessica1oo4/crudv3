import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudv3/src/providers/productProvider.dart';
import 'package:crudv3/src/screens/home.dart';
import 'package:crudv3/src/screens/products.dart';
import 'package:crudv3/src/screens/sign_in.dart';
import 'package:crudv3/src/screens/sign_up.dart';
import 'package:crudv3/src/services/auth_service.dart';
import 'package:crudv3/src/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/app_user.dart';
import 'models/product.dart';
import 'services/auth_service.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(),
        ),
        StreamProvider<List<Product>>(
          create: (_) => FirestoreService().readDb(),
        ),
        StreamProvider<AppUser>.value(
          value: AuthService().checkAuthState,
        ),
      ],
      child: MaterialApp(
        home: AuthenticationWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  bool showSignInScreen = true;

  void toggleRegistrationScreen() {
    setState(() {
      showSignInScreen = !showSignInScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().checkAuthState,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            AppUser appUser = snapshot.data;

            //if user is not logged in
            if (appUser == null) {
              if (showSignInScreen) {
                return SignInScreen(
                  toggleScreen: toggleRegistrationScreen,
                );
              }
              return SignUpScreen(
                toggleScreen: toggleRegistrationScreen,
              );
            } else {
              return Products();
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
