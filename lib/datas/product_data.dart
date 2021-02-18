import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String category;
  String id;
  String title;
  String description;
  double price;
  List images;
  List sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    title = snapshot.get("title");
    price = snapshot.get("price");
    description = snapshot.get("description");
    images = snapshot.get("images");
    sizes = snapshot.get("sizes");
  }

  Map<String, dynamic> toResumedMap() {
    return {
      "title": title,
      "description": description,
      "price": price,
    };
  }
}