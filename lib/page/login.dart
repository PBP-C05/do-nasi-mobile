import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:do_nasi/page/profile.dart';

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
          backgroundColor: Colors.white,
          actions: [],
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
            child: ListView(children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: const Text(
                    'Log in to Your Account',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 22),
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
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                hintText: 'Email',
                                prefixIcon: const Icon(Icons.email),
                                hintStyle: const TextStyle(
                                  color: Color.fromRGBO(200, 200, 200, 1),
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                hintText: 'Password',
                                prefixIcon: const Icon(Icons.lock),
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                              width: double.infinity,
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
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
                                child: const Text("Masuk"),
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
                    ),
                    onPressed: () {
                      //signup screen
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => LoginPage(),
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
  Widget okButton = TextButton(
    child: const Text("Coba Lagi"),
    onPressed: () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Gagal!"),
    content: const Text("Email dan password tidak cocok!"),
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

showAlertDialog2(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("Close"),
    onPressed: () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const MainPage()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Selamat!"),
    content: const Text("Anda berhasil login"),
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
