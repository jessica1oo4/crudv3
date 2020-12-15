import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudv3/src/models/product.dart';
import 'package:crudv3/src/providers/productProvider.dart';

class FirestoreService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> saveDb(Product product) {
    return firebaseFirestore
        .collection('products')
        .doc(product.productId)
        .set(product.toMap());
  }

  Stream<List<Product>> readDb() {
    return firebaseFirestore.collection('products').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList());
  }

  Future<void> delete(Product product) {
    return firebaseFirestore
        .collection('products')
        .doc(product.productId)
        .delete();
  }
}
