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

    return Scaffold(// Menambahkan drawer menu
        body: FutureBuilder(
            future: request
                .get("https://do-nasi.up.railway.app/auth/get_user_json/"),
            // request.get("http://127.0.0.1:8000/auth/get_user_json/"),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
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
                  // child: Text("${snapshot.data['data']['email']}"),
                  return Column(children: [
                    const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Center(
                            child: Text(
                          "My Profile",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ))),
                    Padding(
                      // Menggunakan padding sebesar 8 pixels
                      padding: const EdgeInsets.only(top: 30),
                      child: RichText(
                        text: TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                                text: 'Email: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: snapshot.data['data']["email"]),
                          ],
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'Nama: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: snapshot.data['data']["name"]),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'Username: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: snapshot.data['data']['username'])
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'Role: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: snapshot.data['data']['role'])
                        ],
                      ),
                    ),
                    Padding(
                        // Menggunakan padding sebesar 8 pixels
                        padding: const EdgeInsets.only(top: 100),
                        child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                            ),
                            onPressed: () async {
                              print(request.loggedIn);
                              if (request.loggedIn) {
                                const url =
                                    "https://do-nasi.up.railway.app/auth/logout_flutter/";
                                // const url =
                                //     "http://127.0.0.1:8000/auth/logout_flutter/";
                                final response = await request.logout(url);
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              }
                            },
                            child: const Text(
                              "Log out",
                              style: TextStyle(color: Colors.white),
                            ))),
                    Padding(
                        // Menggunakan padding sebesar 8 pixels
                        padding: const EdgeInsets.only(top: 10),
                        child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: const Text(
                              "Back",
                              style: TextStyle(color: Colors.white),
                            )))
                  ]);
                }
              }
            }));
  }
}
