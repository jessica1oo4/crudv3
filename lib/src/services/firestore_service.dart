import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudv3/src/models/app_user.dart';
import 'package:crudv3/src/models/product.dart';
import 'package:crudv3/src/providers/productProvider.dart';

class FirestoreService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> createUser(AppUser appUser) async {
    return await firebaseFirestore
        .collection('users')
        .doc(appUser.uid)
        .set(appUser.toMap());
  }

  Future<void> saveDb(Product product, AppUser appUser) async {
    return await firebaseFirestore
        .collection('users')
        .doc(appUser.uid)
        .collection('products')
        .doc(product.productId)
        .set(product.toMap());
  }

  Stream<List<Product>> readDb({AppUser appUser}) {
    return firebaseFirestore
        .collection('users')
        .doc(appUser.uid)
        .collection('products')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList());
  }

  Future<void> delete(Product product) async {
    return await firebaseFirestore
        .collection('products')
        .doc(product.productId)
        .delete();
  }
}
