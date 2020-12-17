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
  @override
  Widget build(BuildContext context) {
    List<Product> productList = Provider.of<List<Product>>(context);
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
//                AppUser appUser = context.read<AppUser>();
//                if (appUser == null) {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => SignInScreen()));
//                } else {}
              })
        ],
      ),
      body: (productList == null)
          ? Container()
          : ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(productList[index].name),
                  trailing: Text(productList[index].price.toString()),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProduct(
                                  productModel: productList[index],
                                )));
                  },
                );
              },
            ),
    );
  }
}
