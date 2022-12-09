import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:do_nasi/page/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) {
          CookieRequest request = CookieRequest();
          return request;
        },
        child: MaterialApp(
            title: 'do-nasi',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'Poppins'
            ),
            home: LoginPage(),
            routes: {
              // PENTING: ini nanti bakal diarahin ke on boarding page ya guys (menyusul)
              "/login": (context) => LoginPage(),
            }
        ),
    );
  }
}

