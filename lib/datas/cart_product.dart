import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_codedata/datas/product_data.dart';

class CartProduct {
  String cid;
  String pid;
  String category;
  String size;
  int quantity;

  ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.id;
    category = document.get("category");
    pid = document.get("pid");
    quantity = document.get("quantity");
    size = document.get("size");
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "size": size,
      "product": productData.toResumedMap(),
    };
  }
}