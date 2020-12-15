import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudv3/src/models/product.dart';
import 'package:crudv3/src/providers/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class EditProduct extends StatefulWidget {
  Product productModel;
  EditProduct({this.productModel});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.productModel == null) {
      CircularProgressIndicator();
    } else {
      nameController.text = widget.productModel.name;
      priceController.text = widget.productModel.price.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit/Record Product'),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration:
                  InputDecoration(labelText: 'What are you getting now?!'),
              controller: nameController,
            ),
            TextField(
              decoration:
                  InputDecoration(labelText: 'How much does that cost?!'),
              controller: priceController,
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: () {
                if (widget.productModel == null) {
                  productProvider.save(Product(
                      name: nameController.text,
                      price: double.parse(priceController.text),
                      productId: Uuid().v4()));
                } else {
                  productProvider.save(Product(
                      name: nameController.text,
                      price: double.parse(priceController.text),
                      productId: widget.productModel.productId));
                }
                Navigator.pop(context);
              },
            ),
            (widget.productModel == null)
                ? Container()
                : RaisedButton(
                    child: Text('RETURN IT NOW!'),
                    onPressed: () {
                      productProvider.delete(widget.productModel);
                      Navigator.pop(context);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
