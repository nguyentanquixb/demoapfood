import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoappfoodorder/pages/detailPage/detail_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demoappfoodorder/model/user_model.dart';
import 'package:demoappfoodorder/route/routing_page.dart';
import 'package:demoappfoodorder/widgets/build_drawer.dart';
import 'package:demoappfoodorder/widgets/grid_view_widget.dart';
import 'package:demoappfoodorder/widgets/single_product.dart';

late UserModel userModel;

Size? size;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future getCurrentUserDataFunction() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
          (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          userModel = UserModel.fromDocument(documentSnapshot);
        } else {
          print("Document does not exist the database");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    getCurrentUserDataFunction();
    return Scaffold(
      drawer: BuildDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
         Padding(
             padding: const EdgeInsets.all(8.0),
           child:  Material(
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
               )
           ),
         ),
          ListTile(
            leading: Text(
              "Categories",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            height: 100,
            child: StreamBuilder(
               stream:
                  FirebaseFirestore.instance.collection("categories").snapshots(),
                   builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshort) {
                     if (!streamSnapshort.hasData) {
                       return Center(child: const CircularProgressIndicator());
                     }
                     return ListView.builder(
                       scrollDirection: Axis.horizontal,
                       physics: BouncingScrollPhysics(),
                       itemCount: streamSnapshort.data!.docs.length,
                       itemBuilder: (ctx, index) {
                         return Categories(
                           onTap: () {
                             Navigator.of(context).push(
                               MaterialPageRoute(
                                 builder: (context) => GridViewWidget(
                                   collection: streamSnapshort.data!.docs[index]
                                   ["categoryName"],
                                   id: streamSnapshort.data!.docs[index].id,
                                 ),
                               ),
                             );
                           },
                           categoryName: streamSnapshort.data!.docs[index]
                           ["categoryName"],
                           image: streamSnapshort.data!.docs[index]["categoryImage"],
                         );
                       },
                     );
                   },
            ),
          ),
          ListTile(
            leading: Text(
              "product",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
            Container(
                  height: 280,
                  child: StreamBuilder(
                     stream:
                        FirebaseFirestore.instance.collection("products").snapshots(),
                         builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshort) {
                           if (!streamSnapshort.hasData) {
                             return Center(child: const CircularProgressIndicator());
                           }
                           return ListView.builder(
                             scrollDirection: Axis.horizontal,
                             physics: BouncingScrollPhysics(),
                             itemCount: streamSnapshort.data!.docs.length,
                             itemBuilder: (ctx, index) {
                               return SingleProduct(
                                 onTap: () {
                                   RoutingPage.goTonext(context: context,
                                       navigateTo: DetailsPage(
                                         productId:streamSnapshort.data!.docs[index]["productId"] ,
                                         productName: streamSnapshort.data!.docs[index]["productName"],
                                         productDescription: streamSnapshort.data!.docs[index]["productDescription"],
                                         productPrice: streamSnapshort.data!.docs[index]["productPrice"],
                                         productRate: streamSnapshort.data!.docs[index]["productRate"],
                                         productImage: streamSnapshort.data!.docs[index]["productImage"],
                                       ));
                                 },
                                 name: streamSnapshort.data!.docs[index]
                                 ["productName"],
                                 image: streamSnapshort.data!.docs[index]["productImage"],
                                 price: streamSnapshort.data!.docs[index]["productPrice"],
                               );
                             },
                           );
                         },
                  ),
            ),
        ],
      ),
    );
  }

}



class Categories extends StatelessWidget {
  final String image;
  final String categoryName;
  final Function()? onTap;
  const Categories({
    Key? key,
    required this.onTap,
    required this.categoryName,
    required this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.all(12.0),
          height: 100,
          width: 150,
          decoration: BoxDecoration(
             image: DecorationImage(
                fit: BoxFit.cover,
                 image: NetworkImage(
                   image,
                 )
             ) ,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.6),
            ),
            child: Center(
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )  ,
      ),
    );
  }
}

