import 'package:crudv3/src/models/app_user.dart';
import 'package:crudv3/src/models/product.dart';
import 'package:crudv3/src/providers/productProvider.dart';
import 'package:crudv3/src/screens/edit_product.dart';
import 'package:crudv3/src/screens/sign_in.dart';
import 'package:crudv3/src/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Products extends StatelessWidget {
  AppUser appUser;

  Products({this.appUser});

  @override
  Widget build(BuildContext context) {
    List<Product> productList = Provider.of<List<Product>>(context);
    ProductProvider productProvider = context.watch<ProductProvider>();
    AuthService authService = context.watch<AuthService>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProduct()));
                }),
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () async {
                  await authService.signOut();
                })
          ],
        ),
        body: (productList == null)
            ? Container()
            : StreamBuilder(
                stream: productProvider.productList(appUser),
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, int) {
                        return ListTile(
                          leading: Text(snapshot.data[int].name),
                          trailing: Text(snapshot.data[int].price.toString()),
                        );
                      });
                }));
  }
}
