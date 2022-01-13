import 'package:flutter/cupertino.dart';

class SingleProduct extends StatelessWidget {

  final image;
  final price;
  final name;
  final Function()? onTap;
  const SingleProduct({
    Key? key,
    required this.image,
    required this.price,
    required this.name,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Column(

        children: [
          Container(
            margin: EdgeInsets.all(12.0),
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      image,
                    )
                ) ,
                borderRadius: BorderRadius.circular(10)
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(width: 20),
              Text(
                "\$$price",
                style: TextStyle(

                  fontWeight: FontWeight.bold,
                ),
              ),


            ],
          )
        ],
      ),
    );

  }
}