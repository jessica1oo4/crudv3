import 'package:uuid/uuid.dart';

class Product {
  String name;
  double price;
  String productId;

  Product({this.name, this.price, this.productId});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'productId': productId,
    };
  }

  Product.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    price = map['price'];
    productId = map['productId'];
  }
}
