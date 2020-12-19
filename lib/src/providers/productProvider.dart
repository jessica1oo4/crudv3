import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudv3/src/models/app_user.dart';
import 'package:crudv3/src/models/product.dart';
import 'package:crudv3/src/services/firestore_service.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  String name;
  String productId;

  var firestoreService = FirestoreService();

  Stream<List<Product>> productList(AppUser appUser) {
    return firestoreService.readDb(appUser: appUser);
  }

  Future<void> save({Product product, AppUser appUser}) {
    return firestoreService.saveDb(product, appUser);
  }

  delete(Product product) {
    return firestoreService.delete(product);
  }
}
