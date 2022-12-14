import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:do_nasi/model/page_overview_model.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';


Future<List<PageOverview>> fetchPageOverview(request) async {
  // TODO: Ganti ke url railway
  // var url = 'http://127.0.0.1:8000/group/$group_name/json-flutter/';
  var url = 'https://do-nasi.up.railway.app/page_overview/json/';

  var response = await request.get(url);

// melakukan decode response menjadi bentuk json
//   var data = jsonDecode(utf8.decode(response.bodyBytes));

  var data = response;

// melakukan konversi data json menjadi object ToDo
  List<PageOverview> listPost = [];
  for (var d in data) {
    if (d != null) {
      listPost.add(PageOverview.fromJson(d));
    }
  }
  return listPost;
}