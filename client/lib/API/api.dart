import 'dart:convert';
// ignore: unused_import
import 'dart:io';
import 'package:http/http.dart' as http;
// ignore: unused_import
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Map<String, dynamic>>> getAutocomplete({query = "a"}) async {
  // ignore: avoid_print
  print("starting autocomplete");
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  // ignore: avoid_print
  print("token : " + token.toString());
  // ignore: avoid_print
  print("query : " + query);
  String url = "https://oauth.reddit.com/api/subreddit_autocomplete_v2?query=" + query;
  // ignore: avoid_print
  print("url : " + url);
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }
  );
  List<Map<String, dynamic>> res = [];
  Map jsonBody = jsonDecode(response.body);
  var datas = jsonBody["data"]["children"];
  if (datas.length >= 5) {
    for (int i = 0; i < 5; i++) {
      if (datas[i]['kind'] == "t5") {
  // ignore: avoid_print
        print("imgt5 : " + datas[i]['data']['icon_img']);
        Map<String, dynamic> obj = {
          'name': datas[i]['data']['display_name_prefixed'],
          'img': (datas[i]['data']['icon_img'] != '') ? datas[i]['data']['icon_img'] : "https://upload.wikimedia.org/wikipedia/fr/thumb/f/fc/Reddit-alien.png/220px-Reddit-alien.png"
        };
        res.add(obj);
      } else if (datas[i]['kind'] == "t2") {
  // ignore: avoid_print
        print("imgt2 : " + datas[i]['data']['icon_img']);
        Map<String, dynamic> obj = {
          'name': datas[i]['data']['subreddit']["display_name_prefixed"],
          'img': (datas[i]['data']['snoovatar_img'] != '') ?  datas[i]['data']['snoovatar_img'] : "https://upload.wikimedia.org/wikipedia/fr/thumb/f/fc/Reddit-alien.png/220px-Reddit-alien.png"
        };
        res.add(obj);
      }
    }
  }
  return res;
}