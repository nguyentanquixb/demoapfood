import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoappfoodorder/pages/detailPage/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:demoappfoodorder/route/routing_page.dart';
import 'single_product.dart';

 class GridViewWidget extends StatelessWidget {
  final String id;
  final String collection;

  const GridViewWidget({
    Key? key,
    required this.id,
    required this.collection,
  }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("categories")
                .doc(id)
                .collection(collection).get(),
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshort){
              if(!snapshort .hasData){
                return Center(child: CircularProgressIndicator(),);
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 7,
                      shadowColor: Colors.grey[300],
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          fillColor: Colors.white,
                          hintText: "Search Your Product",
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: snapshort.data!.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.6,
                       crossAxisCount: 2,
                       mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                  itemBuilder: (context,index){
                      var data = snapshort.data!.docs[index];
                    return SingleProduct(
                      onTap: (){
                        RoutingPage.goTonext(
                          context: context,
                          navigateTo: DetailsPage(
                            productId:  data["productId"],
                            productImage: data["productImage"],
                            productName: data["productName"],
                            productPrice: data["productPrice"],
                            productRate: data["productRate"],
                            productDescription: data["productDescription"],
                          ),
                        );

                      },
                        image: data["productImage"],
                        name: data["productName"],
                        price: data["productPrice"],
                    );
                  }
              ),
                ],
              );
            }
        ),



        //
        //     // FutureBuilder(
        //     //     future: FirebaseFirestore.instance
        //     //         .collection("categories")
        //     //         .doc(id)
        //     //         .collection(collection).get(),
        //     //     builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshort){
        //     //       return GridView.builder(
        //     //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     //               crossAxisCount: 2,
        //     //           ),
        //     //           itemBuilder: (context,index){
        //     //             return Container(
        //     //               color: Colors.red,
        //     //
        //     //             );
        //     //
        //     //           }
        //     //       );
        //     //
        //     //     }
        //     // ),
        //   ],
        // ),

      );
  }

 }



