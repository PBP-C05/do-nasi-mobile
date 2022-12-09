import 'dart:math';

import 'package:do_nasi/model/page_overview_model.dart';
import 'package:do_nasi/utils/page_overview_utils.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MyFormPage extends StatefulWidget {
  final setparent;
  const MyFormPage({super.key, required this.setparent});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  TextEditingController dateinputcontrol = TextEditingController();
  DateTime dateinput = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  String _judul = "";
  String _desc = "";

  @override
  void initState() {
    dateinputcontrol.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Donasi'),
      ), // Menambahkan drawer menu
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _judul = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        _judul = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _desc = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        _desc = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(15),
                    height: 150,
                    child: Center(
                        child: TextField(
                          controller: dateinputcontrol, //editing controller of this TextField
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Enter Date" //label text of field
                          ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));
                        if (pickedDate == null) {
                          print("Date is not selected");
                        }
                        else {
                          print(pickedDate);
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(formattedDate);
                          setState(() => dateinputcontrol.text = formattedDate);
                          setState(() => dateinput = pickedDate);
                        }
                      },
                    ))),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      const url = 'https://do-nasi.up.railway.app/page_overview/add/';
                      final response = await request.post(url, {'title' : _judul, 'description' : _desc, 'deadline' : dateinput.toString()});
                      widget.setparent();
                      _formKey.currentState?.reset();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            insetPadding: const EdgeInsets.all(10),
                            elevation: 15,
                            child: ListView(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              shrinkWrap: true,
                              children: <Widget>[
                                const Center(
                                    child: Text('Berhasil Ditambahkan')),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow[900], // Background color
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Page Overview')) ],
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: const Text(
                    "SAVE",
                    style: TextStyle(color: Colors.white),
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
