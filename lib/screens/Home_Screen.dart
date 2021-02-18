import 'package:flutter/material.dart';
import 'package:loja_codedata/tabs/Home_Tab.dart';
import 'package:loja_codedata/tabs/orders_tab.dart';
import 'package:loja_codedata/tabs/products_tab.dart';
import 'package:loja_codedata/widgets/cart_button.dart';
import 'package:loja_codedata/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
          body: ProductsTab(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: OrdersTab(),
        )
      ],
    );
  }
}