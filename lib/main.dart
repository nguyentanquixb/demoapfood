import 'package:demoappfoodorder/pages/provider/cart_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demoappfoodorder/pages/home/home_page.dart';
import 'package:demoappfoodorder/pages/login/components/login_auth_provider.dart';
import 'package:demoappfoodorder/pages/signup/components/signup_auth_provider.dart';
import 'package:demoappfoodorder/pages/welcome/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDSN0_hMUH_h49SqiChpOMQG1nG336i-Us",
      appId: "1:813711038608:android:9cbfd01077c27901c2e015",
      messagingSenderId: "813711038608",
      projectId: "demotestapp-fa7c9",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SignupAuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginAuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo Food App',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnp) {
            if (userSnp.hasData) {
              return HomePage();
            }
            return WelcomePage();
          },
        ),
        // home: SignupPage(),
      ),
    );
  }
}
