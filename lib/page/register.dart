import 'package:do_nasi/page/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:do_nasi/page/profile.dart';

import 'main_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  String? _role = 'Penyalur';

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
        automaticallyImplyLeading: false,
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
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 5),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: const Text(
                  'Create Your Account',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
                )),
            Form(
              key: _registerFormKey,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(250, 250, 250, 0.95),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _controllerName,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline,
                              color: Color.fromRGBO(200, 200, 200, 1)),
                          hintText: "Name",
                          hintStyle: const TextStyle(
                            color: Color.fromRGBO(200, 200, 200, 1),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(255, 205, 46, 1),
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
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
                          hintText: "Email",
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
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(250, 250, 250, 0.95),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _controllerUsername,
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(255, 205, 46, 1),
                            ),
                          ),
                          prefixIcon: const Icon(Icons.alternate_email,
                              color: Color.fromRGBO(200, 200, 200, 1)),
                          hintText: "Username",
                          hintStyle: const TextStyle(
                            color: Color.fromRGBO(200, 200, 200, 1),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
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
                    const SizedBox(height: 15),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: const Color.fromRGBO(150, 150, 150, 1)),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            const ListTile(
                              title: Text('Daftar sebagai:'),
                              leading: Icon(Icons.people_alt,
                                  color: Color.fromRGBO(200, 200, 200, 1)),
                            ),
                            ListTile(
                              title: const Text('Penyalur'),
                              leading: Radio<String>(
                                value: 'Penyalur',
                                groupValue: _role,
                                onChanged: (String? value) {
                                  setState(() {
                                    _role = value!;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('Donatur'),
                              leading: Radio<String>(
                                value: 'Donatur',
                                groupValue: _role,
                                onChanged: (String? value) {
                                  setState(() {
                                    _role = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 15),
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
                            if (_registerFormKey.currentState!.validate()) {
                              const url =
                                "http://127.0.0.1:8000/auth/register_flutter/";
                              //const url =
                              //    "https://do-nasi.up.railway.app/auth/register_flutter/";

                              final response = await request.post(url, {
                                "name": _controllerName.text,
                                "email": _controllerEmail.text,
                                "username": _controllerUsername.text,
                                "password": _controllerPassword.text,
                                "role": _role,
                              });

                              print("here response");
                              //
                              print(response);

                              // if (request.loggedIn) {
                              //   showAlertDialog2(context);
                              //   print("Alhamdulillah");
                              // } else {
                              //   showAlertDialog(context);
                              // }
                            } else {
                              print("tidak valid");
                            }
                          },
                          child: const Text("Submit"),
                        ))
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Sudah punya akun?'),
                TextButton(
                  child: const Text(
                    'Masuk di sini.',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 205, 46, 1),
                    ),
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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RegisterPage()));
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
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
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
