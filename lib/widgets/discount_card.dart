import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_codedata/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      elevation: 3.0,
      child: ExpansionTile(
        title: Text(
          "Cupom de Desconto",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu cupom",
              ),
              initialValue: CartModel.of(context).cupomCode ?? "",
              onFieldSubmitted: (text) {
                FirebaseFirestore.instance.collection("cupons").doc(text).get().then((docSnap) {
                  if (docSnap.data() != null) {
                    CartModel.of(context).setCupom(text, docSnap.get("percent"));
                    
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Desconto de ${docSnap.get("percent")}% aplicado!"),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );
                  } else {
                    CartModel.of(context).setCupom(null, 0);

                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Cupom não existente!"),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
