
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demoappfoodorder/pages/provider/cart_provider.dart';
import 'package:demoappfoodorder/widgets/my_button.dart';
import 'package:demoappfoodorder/widgets/single_cart_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();

    return Scaffold(
      bottomNavigationBar: cartProvider.getCartList.isEmpty
          ? Text("")
          : MyButton(
              text: "Check Out",
              onPressed: () {

              },
            ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: cartProvider.getCartList.isEmpty
          ? Center(
              child: Text("No Product"),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: cartProvider.getCartList.length,
              itemBuilder: (ctx, index) {
                var data = cartProvider.cartList[index];
                return SingleCartItem(
                  productId: data.productId,
                  productImage: data.productImage,
                  productPrice: data.productPrice,
                  productQuantity: data.productQuantity,
                  productName: data.productName,
                );
              },
            ),
    );
  }
}
