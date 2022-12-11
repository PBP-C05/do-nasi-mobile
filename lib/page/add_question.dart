import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AddQuestionForm extends StatefulWidget {
  const AddQuestionForm({super.key});

  @override
  State<AddQuestionForm> createState() => _AddQuestionFormState();
}

class _AddQuestionFormState extends State<AddQuestionForm> {
  final _postFormKey = GlobalKey<FormState>();
  String inputTitle = "";
  String inputBody = "";
  var _controllerTitle = TextEditingController();
  var _controllerBody = TextEditingController();

  void _showPopUpAfter() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 15,
          content: const Text('Postingan Kamu berhasil ditambahkan'),
          actions: <Widget>[
            Center(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromRGBO(251, 192, 45, 1)
                  ),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(2, 1, 2, 2),
                  child: Text(
                    "Tutup",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ) ,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    // print(request.loggedIn);
    // print(request.toString());

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _postFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // TITLE INPUT
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controllerTitle,
                    // DECORATION
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.title_rounded),
                      labelText: "Judul",
                      hintText: "Tuliskan judul untuk postinganmu",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(27.0)),
                    ),
                    // VALIDATOR
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Judul harus diisi!";
                      }
                      return null;
                    },
                    // DECORATION ON TYPE
                    onChanged: (String? value) {
                      setState(() {
                        inputTitle = value!;
                      });
                    },
                    // BEHAVIOR ON STORING DATA
                    onSaved: (String? value) {
                      setState(() {
                        inputTitle = value!;
                      });
                      _controllerTitle.clear();
                    },
                  ),
                ),
                // BODY INPUT
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controllerBody,
                    // DECORATION
                    decoration: InputDecoration(
                      hintText: "Tuliskan pertanyaanmu di sini",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 9,
                    maxLines: null,
                    // VALIDATOR
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Tuliskan pertanyaanmu";
                      }
                      return null;
                    },
                    // DECORATION ON TYPE
                    onChanged: (String? value) {
                      setState(() {
                        inputBody = value!;
                      });
                    },
                    // BEHAVIOR ON STORING DATA
                    onSaved: (String? value) {
                      setState(() {
                        inputBody = value!;
                      });
                      _controllerBody.clear();
                    },
                  ),
                ),
                // SUBMIT BUTTON
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextButton(
                    onPressed: () async {
                      if (_postFormKey.currentState!.validate()) {
                        _postFormKey.currentState!.save();
                        const url =
                            // 'https://do-nasi.up.railway.app/questions/add-post/';
                            'http://127.0.0.1:8000/questions/add-post/';
                        final response = await request.post(url, {
                          'title': inputTitle,
                          'body' : inputBody,
                        });
                        _showPopUpAfter();
                      }
                    },
                    child: const Text("Kirim"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
