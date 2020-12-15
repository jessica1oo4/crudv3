import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudv3/src/models/product.dart';
import 'package:crudv3/src/services/firestore_service.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  String name;
  String productId;

  var firestoreService = FirestoreService();

  Future<void> save(Product product) {
    return firestoreService.saveDb(product);
  }

  delete(Product product) {
    return firestoreService.delete(product);
  }
}
