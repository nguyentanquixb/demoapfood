import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String productId;
  final int productRate;
  final String productImage;
  final int productPrice;
  final String productName;
  final String productDescription;
  final int productQuantity;
  CartModel({
    required this.productRate,
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productQuantity,

  });
  factory CartModel.fromDocument(QueryDocumentSnapshot doc) {
    return CartModel(
      productId: doc.data().toString().contains('productId') ? doc.get('productId') : '',
      productImage: doc.data().toString().contains('productImage') ? doc.get('productImage') : '',
      productPrice:   doc.get('productPrice'),
      productDescription: doc.data().toString().contains('productDescription') ? doc.get('productDescription') : '',
      productName: doc.data().toString().contains('productName') ? doc.get('productName') : '',
      productRate:  doc.get('productRate'),
      productQuantity:  doc.get('productQuantity'),

    );
  }
}


