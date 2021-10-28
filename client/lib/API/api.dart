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
      'User-Agent': 'EpitechRed:1234:1.0 (by /u/uichaa>)',
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
  return res;
}

Future<Map<String, dynamic>> getSubReddit(query) async {
  // final prefs = await SharedPreferences.getInstance();
  // final token = prefs.getString('access_token');
  // String url = "https://oauth.reddit.com/" + query + "/about";
  // http.Response response = await http.get(
  //   Uri.parse(url),
  //   headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'User-Agent': 'Redditech:1234:1.0 (by /u/RichiePo99>)',
  //     'Authorization': 'Bearer $token',
  //   }
  // );
  // Map jsonBody = jsonDecode(response.body);
  // var datas = jsonBody["data"];
  // Map<String, dynamic> res = {
  //   "community_icon": datas['community_icon'].toString().replaceAll("amp;", ""),
  //   "banner_background_image": datas['banner_background_image'].toString().replaceAll("amp;", ""),
  //   "description": datas['public_description'],
  //   "subscribers": datas['subscribers'],
  //   "title": datas['title']
  // };
  Map<String, dynamic> res = {
    "community_icon": "https://styles.redditmedia.com/t5_2xd5g/styles/communityIcon_4ekfriatydw61.jpg?width=256&s=c90a5bf7774e7108bcbd74cb6e51c0e0a88f74a1",
    "banner_background_image": "https://styles.redditmedia.com/t5_2xd5g/styles/bannerBackgroundImage_xke9ikfe78051.jpg?width=4000&s=8db0f22d171f0903597ecff140f678e8394db3fa",
    "description": "Anything related to KSI.",
    "subscribers": 2298773,
    "title": "KSI"
  };
  print(res);
  return res;
}