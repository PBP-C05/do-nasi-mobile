import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:do_nasi/page/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        body: FutureBuilder(
            future:
                request.get("https://do-nasi.up.railway.app/auth/get_user_json/"),
                //request.get("http://127.0.0.1:8000/auth/get_user_json/"),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              }
              else {
                if (!snapshot.hasData) {
                  return Column(
                    children: const [
                      Text(
                        "Silakan log in terlebih dahulu.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 30, top: 15),
                      child: ListView(children: <Widget>[
                        Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image:
                                        AssetImage('assets/images/user.png')))),
                        const SizedBox(height: 10),
                        const Center(
                            child: Text(
                          "My Profile",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )),
                        const SizedBox(height: 10),
                        Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                            Color.fromRGBO(200, 200, 200, 1)))),
                            child: ListTile(
                              leading: const Icon(Icons.person_outline),
                              title: const Text("Name"),
                              subtitle:
                                  Text("${snapshot.data['data']['name']}"),
                            )),
                        const SizedBox(height: 1),
                        Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                            Color.fromRGBO(200, 200, 200, 1)))),
                            child: ListTile(
                              leading: const Icon(Icons.email),
                              title: const Text("Email"),
                              subtitle:
                                  Text("${snapshot.data['data']['email']}"),
                            )),
                        const SizedBox(height: 1),
                        Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                            Color.fromRGBO(200, 200, 200, 1)))),
                            child: ListTile(
                              leading: const Icon(Icons.alternate_email),
                              title: const Text("Username"),
                              subtitle:
                                  Text("${snapshot.data['data']['username']}"),
                            )),
                        const SizedBox(height: 1),
                        Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                            Color.fromRGBO(200, 200, 200, 1)))),
                            child: ListTile(
                              leading: const Icon(Icons.people_alt),
                              title: const Text("Role"),
                              subtitle:
                                  Text("${snapshot.data['data']['role']}"),
                            )),
                        const SizedBox(height: 20),
                        Container(
                            height: 35,
                            child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromRGBO(255, 205, 46, 1)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                ),
                                onPressed: () async {
                                  if (request.loggedIn) {
                                    const url =
                                        "https://do-nasi.up.railway.app/auth/logout_flutter/";
                                    //const url =
                                    //     "http://127.0.0.1:8000/auth/logout_flutter/";
                                    final response = await request.logout(url);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                                  } else {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                                  }
                                },
                                child: const Text(
                                  "Log out",
                                  style: TextStyle(color: Colors.black),
                                ))),
                      ]));
                }
              }
            }));
  }
}
