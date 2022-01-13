import 'package:flutter/material.dart';
import 'package:demoappfoodorder/pages/login/login_page.dart';
import 'package:demoappfoodorder/pages/signup/signup_page.dart';
import 'package:demoappfoodorder/route/routing_page.dart';
import 'package:demoappfoodorder/widgets/my_button.dart';

class EndPart extends StatelessWidget {
  const EndPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyButton(
          onPressed: () {
            RoutingPage.goTonext(
              context: context,
              navigateTo: LoginPage(),
            );
          },
          text: "LOG IN",
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            RoutingPage.goTonext(
              context: context,
              navigateTo: SignupPage(),
            );
          },
          child: Text(
            "SIGNUP",
            style: TextStyle(
              color: Color(0xff797b7a),
            ),
          ),
        )
      ],
    );
  }
}
