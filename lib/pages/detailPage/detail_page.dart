import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoappfoodorder/cartPage/cart_page.dart';
import 'package:demoappfoodorder/route/routing_page.dart';
import 'package:demoappfoodorder/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String productName;
  final int productPrice;
  final int productRate;
  final String productDescription;
  final String productImage;
  final String productId;
  const DetailsPage({
    Key? key,
    required this.productImage,
    required this.productDescription,
    required this.productName,
    required this.productPrice,
    required this.productRate,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
            child: Container(
            width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(productImage),
                ),
              ),
            ),
          ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(

                  children: [
                    Text( "\$$productPrice"),

                  ],
                ),
                Divider(thickness: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color(0xff027f47),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          productRate.toString(),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "10 Review",
                      style: TextStyle(
                        color: Color(0xff027f47),
                      ),
                    ),
                  ],
                ),

                Divider(thickness: 2),
                Text(
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(productDescription),
                MyButton(
                  onPressed: () {
                      FirebaseFirestore.instance
                          .collection("cart")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("userCart")
                          .doc(productId)
                          .set(
                        {
                          "productId": productId,
                          "productImage": productImage,
                          "productName": productName,
                          "productPrice": productPrice,
                          "productRate": productRate,
                          "productDescription": productDescription,
                          "productQuantity": 1,
                        },
                      );
                      RoutingPage.goTonext(
                        context: context,
                        navigateTo: CartPage(),
                      );
                  },
                  text: "Add to Cart",
                ),

              ],
            ))



          ],
        ),
      ),
    );
  }
}
