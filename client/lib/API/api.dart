import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Map<String, dynamic>>> getAutocomplete({query = "a"}) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  String url = "https://oauth.reddit.com/api/subreddit_autocomplete_v2?query=" + query;
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': 'Redditech:1234:1.0 (by /u/RichiePo99>)',
      'Authorization': 'Bearer $token',
    }
  );
  List<Map<String, dynamic>> res = [];
  Map jsonBody = jsonDecode(response.body);
  var datas = jsonBody["data"]["children"];
  for (int i = 0; i < jsonBody['data']['dist']; i++) {
    if (datas[i]['kind'] == "t5") {
      Map<String, dynamic> obj = {
        'name': datas[i]['data']['display_name_prefixed'],
        'img': (datas[i]['data']['icon_img'] != '' && datas[i]['data']['icon_img'] != null) ? datas[i]['data']['icon_img'] : "https://upload.wikimedia.org/wikipedia/fr/thumb/f/fc/Reddit-alien.png/220px-Reddit-alien.png"
      };
      res.add(obj);
    } else if (datas[i]['kind'] == "t2") {
      Map<String, dynamic> obj = {
        'name': datas[i]['data']['subreddit']["display_name_prefixed"],
        'img': (datas[i]['data']['snoovatar_img'] != ''&& datas[i]['data']['snoovatar_img'] != null) ?  datas[i]['data']['snoovatar_img'] : "https://upload.wikimedia.org/wikipedia/fr/thumb/f/fc/Reddit-alien.png/220px-Reddit-alien.png"
      };
      res.add(obj);
    }
  }
  print(res);
  return res;
}