import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:do_nasi/page/profile.dart';
import 'package:do_nasi/page/register.dart';

import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool isPasswordVisible = false;
  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/icon.ico', fit: BoxFit.cover),
            Image.asset('assets/images/logo.png', fit: BoxFit.cover),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: const Text(
                  'Log in to Your Account',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
                )),
            Form(
              key: _loginFormKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(250, 250, 250, 0.95),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _controllerEmail,
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(255, 205, 46, 1),
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          hintText: 'Email',
                          prefixIcon: const Icon(Icons.email,
                              color: Color.fromRGBO(200, 200, 200, 1)),
                          hintStyle: const TextStyle(
                            color: Color.fromRGBO(200, 200, 200, 1),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(250, 250, 250, 0.95),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _controllerPassword,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(255, 205, 46, 1),
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.lock,
                              color: Color.fromRGBO(200, 200, 200, 1)),
                          suffixIcon: IconButton(
                            color: const Color.fromRGBO(200, 200, 200, 1),
                            splashRadius: 1,
                            icon: Icon(isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            onPressed: togglePasswordView,
                          ),
                          hintStyle: const TextStyle(
                            color: Color.fromRGBO(200, 200, 200, 1),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                        width: 100,
                        height: 35,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(255, 205, 46, 1)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          onPressed: () async {
                            if (_loginFormKey.currentState!.validate()) {
                              // const url =
                              //     "http://127.0.0.1:8000/auth/login_flutter/";
                              const url =
                                  "https://do-nasi.up.railway.app/auth/login_flutter/";

                              final response = await request.login(url, {
                                "email": _controllerEmail.text,
                                "password": _controllerPassword.text
                              });

                              print("here response");
                              print(response);
                              // cara get responsenya
                              print(response['status']);
                              // kalo not authenticated nanti datanya null aja
                              // (ini bisa)
                              print(response['data' == null]);
                              // buat cek role nanti
                              if (response['status'] == true) {
                                print("ya bisa");
                              }

                              if (request.loggedIn) {
                                showAlertDialog2(context);
                                print("Alhamdulillah");
                              } else {
                                showAlertDialog(context);
                              }
                            } else {
                              print("tidak valid");
                            }
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(fontSize: 15),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Belum punya akun?'),
                TextButton(
                  child: const Text(
                    'Daftar di sini.',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 205, 46, 1),
                    ),
                  ),
                  onPressed: () {
                    //signup screen
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget tryButton = TextButton(
    child: const Text(
      "Try Again",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color.fromRGBO(255, 205, 46, 1),
      ),
    ),
    onPressed: () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text(
      "Invalid Log In",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w600,
      ),
    ),
    content: const Text(
      "Email and password did not match, please try again.",
      textAlign: TextAlign.center,
    ),
    actions: [
      tryButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialog2(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text(
      "Start Exploring",
      style: TextStyle(
        color: Color.fromRGBO(255, 205, 46, 1),
      ),
    ),
    onPressed: () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text(
      "Successfully Logged In",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w600,
      ),
    ),
    content: const Text(
      "Welcome back! :)",
      textAlign: TextAlign.center,
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
