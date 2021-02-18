import 'package:flutter/material.dart';
import 'package:loja_codedata/screens/cart_screen.dart';

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart, color: Theme.of(context).primaryColor),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartScreen()));
      },
      backgroundColor: Colors.white,
    );
  }
}
