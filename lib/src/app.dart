import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudv3/src/providers/productProvider.dart';
import 'package:crudv3/src/screens/home.dart';
import 'package:crudv3/src/screens/products.dart';
import 'package:crudv3/src/screens/sign_in.dart';
import 'package:crudv3/src/services/auth_service.dart';
import 'package:crudv3/src/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
//        StreamProvider(
//          create: (_) => AuthService(FirebaseAuth.instance).authStateChanges,
//        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();
    if (user == null) {
      return SignInScreen();
    } else {
      return Products();
    }
  }
}
