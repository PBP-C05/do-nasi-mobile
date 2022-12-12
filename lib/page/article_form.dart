import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:convert' as convert;

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    String title = "";
    String body = "";
    String slug = "";
    DateTime date = DateTime.now();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Tambah Artikel'),
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Container(
              margin: const EdgeInsets.all(2),
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.grey),
              //   borderRadius: BorderRadius.circular(5),

              // padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                Container(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),

                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Masukkan judul",
                      labelText: "Judul Artikel",
                      // Menambahkan icon agar lebih intuitif
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        title = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        title = value!;
                        slug = value.replaceAll(RegExp(' +'), '-');
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Judul tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 7,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Masukkan Body Artikel",
                        labelText: "Body Artikel",
                        // Menambahkan icon agar lebih intuitif
                        // Menambahkan circular border agar lebih rapi
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      // Menambahkan behavior saat nama diketik
                      onChanged: (String? value) {
                        setState(() {
                          body = value!;
                        });
                      },
                      // Menambahkan behavior saat data disimpan
                      onSaved: (String? value) {
                        setState(() {
                          body = value!;
                        });
                      },
                      // Validator sebagai validasi form
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Body tidak boleh kosong!';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            var url =
                                "https://do-nasi.up.railway.app/article/add_article/";
                            final response = await request.post(url,
                                {'title': title, 'body': body, 'slug': slug});

                            // print(response);

                            // if (response['status'] == 'success') {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //           content: Text(
                            //               "Artikel telah berhasil dipublikasikan")));
                            //   Navigator.pop(context);
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(content: Text("Coba lagi")));
                            // }
                            Navigator.pop(context);
                            setState(() {});
                          }
                        },
                        child: Text('Simpan'),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 5.0),
                    //   child: Row(children: [
                    //     Expanded(
                    //       child: ElevatedButton(
                    //         onPressed: () {
                    //           Navigator.pop(context);
                    //         },
                    //         child: Text('Kembali'),
                    //       ),
                    //     )
                    //   ]),
                    // )
                  ]),
                )
              ]),
            ))));
  }
}
