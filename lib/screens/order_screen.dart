import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final String orderId;

  OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido Realizado"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check, color: Theme.of(context).primaryColor, size: 80.0,),
            Text("Pedido Realizado com Sucesso!", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
            Text("Código do Pedido: ${orderId}", style: TextStyle(fontSize: 16.0),),
          ],
        ),
      ),
    );
  }
}
