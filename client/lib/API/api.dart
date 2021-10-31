import 'dart:convert';
import 'package:draw/draw.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

Future<Map<String, dynamic>> getUser() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  String url = "https://oauth.reddit.com/api/v1/me";
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': 'EpitechRed:1234:1.0 (by /u/uichaa>)',
      'Authorization': 'Bearer $token',
    }
  );
  String urlSettings = "https://oauth.reddit.com/api/v1/me/prefs";
  http.Response responseSettings = await http.get(
    Uri.parse(urlSettings),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': 'EpitechRed:1234:1.0 (by /u/uichaa>)',
      'Authorization': 'Bearer $token',
    }
  );
  Map jsonBodySettings = jsonDecode(responseSettings.body);
  var datasSettings = jsonBodySettings;
  Map jsonBody = jsonDecode(response.body);
  var datas = jsonBody;
  Map<String, dynamic> res = {
    "avatar": datas['snoovatar_img'],
    "name": datas['subreddit']['title'],
    "description": datas['subreddit']['public_description'],
    "subscribers": datas['subreddit']['subscribers'],
    "friends": datas['num_friends'],
    "coins": datas['coins'],
    "nightmode": datasSettings['nightmode'],
    "email_private_message": datasSettings['email_private_message'],
    "over_18": datasSettings['over_18'],
    "search_include_over_18": datasSettings['search_include_over_18'],
    "enable_followers": datasSettings['enable_followers'],
    "email_user_new_follower": datasSettings['email_user_new_follower'],
  };
  return res;
}

Future<void> changeSettings(bool change, String name) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  String url = "https://oauth.reddit.com/api/v1/me/prefs";
  var send = Map<String, dynamic>();
  send[name] = change;
  await http.patch(
    Uri.parse(url),
    headers: {
      'User-Agent': 'Redditech:1234:1.0 (by /u/RichiePo99>)',
      'Authorization': 'Bearer $token',
    },
    body: json.encode(send)
  );
}

Future<Map<String, dynamic>> getSubReddit(String query, String type) async {
  type = type.toLowerCase();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  String url = "https://oauth.reddit.com/" + query + "/about";
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': 'Redditech:1234:1.0 (by /u/RichiePo99>)',
      'Authorization': 'Bearer $token',
    }
  );
  String urlBody = "https://oauth.reddit.com/" + query + "/" + type;
  print(urlBody);
  http.Response responseBody = await http.get(
    Uri.parse(urlBody),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': 'Redditech:1234:1.0 (by /u/RichiePo99>)',
      'Authorization': 'Bearer $token',
    }
  );
  Map json = jsonDecode(response.body);
  Map jsonBody = jsonDecode(responseBody.body);
  var datas = json["data"];
  List<Map<String, dynamic>> body = [];
  var bodyDatas = jsonBody["data"]["children"];
  for (int i = 0; i < jsonBody['data']['dist']; i++) {
    final timestamp1 = bodyDatas[i]['data']['created'];
    final DateTime date1 = DateTime.fromMillisecondsSinceEpoch(timestamp1.round() * 1000);
    final compare = DateTime.now().difference(date1);
    var date = compare.inHours.toString() + "h";
    if (compare.inHours == 0) {
      date = compare.inMinutes.toString() + "min";
    }
    Map<String, dynamic> obj = {
      'subreddit': bodyDatas[i]['data']['subreddit_name_prefixed'],
      'author': 'u/' + bodyDatas[i]['data']['author'],
      'date': date,
      'title': bodyDatas[i]['data']['title'],
      'media': '',
      'type': 'text',
    };
    if (bodyDatas[i]['data']['media-metadata'] != null && bodyDatas[i]['data']['is_gallery'] == true) {
      obj['type'] = "gallery";
      obj['media'] = bodyDatas[i]['data']['media-metadata'][0]['s']['u'].toString().replaceAll("amp;", "");
    }else if (bodyDatas[i]['data']['secure_media'] != null && bodyDatas[i]['data']['secure_media']['type'] == 'youtube') {
      obj['type'] = 'youtube';
      obj['media'] = bodyDatas[i]['data']['url_overridden_by_dest'].toString().replaceAll("amp;", "");
    } else if (bodyDatas[i]['data']['secure_media'] != null && bodyDatas[i]['data']['secure_media']["reddit_video"] != null) {
      obj['type'] = 'video';
      obj['media'] = bodyDatas[i]['data']['secure_media']["reddit_video"]["fallback_url"].toString().replaceAll("amp;", "");
    } else if (bodyDatas[i]['data']['preview'] != null) {
      obj['type'] = "photo";
      obj['media'] = bodyDatas[i]['data']['preview']['images'][0]['source']['url'].toString().replaceAll("amp;", "");
    }  else if (bodyDatas[i]['data']['selftext'] != null) {
      obj['media'] = bodyDatas[i]['data']['selftext'];
    }
    body.add(obj);
  }
  Map<String, dynamic> res = {
    "community_icon": datas['community_icon'].toString().replaceAll("amp;", ""),
    "banner_background_image": datas['banner_background_image'].toString().replaceAll("amp;", ""),
    "description": datas['public_description'],
    "subscribers": datas['subscribers'],
    "title": datas['title'],
    "url": datas['display_name_prefixed'],
    "subscribed": datas['user_is_subscriber'],
    "name": datas['name'],
    "posts": body,
  };
  return res;
}

Future<bool> changeSubbed(bool subbed, String name) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  String url = "https://oauth.reddit.com/api/subscribe";
  String sub = (subbed) ? "unsub" : "sub";
  print(sub);
  print(name);
  var send = Map<String, dynamic>();
  send['action'] = sub;
  send['sr'] = name;
  http.Response response = await http.post(
    Uri.parse(url),
    headers: {
      'User-Agent': 'Redditech:1234:1.0 (by /u/RichiePo99>)',
      'Authorization': 'Bearer $token',
    },
    body: send
  );
  return !subbed;
}

Future<List<Map<String, dynamic>>> getHome(String status) async{
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  status = status.toLowerCase();
  String url = "https://oauth.reddit.com/" + status;
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      'User-Agent': 'Redditech:1234:1.0 (by /u/RichiePo99>)',
      'Authorization': 'Bearer $token',
    }
  );
  List<Map<String, dynamic>> res = [];
  Map jsonBody = jsonDecode(response.body);
  var datas = jsonBody["data"]["children"];
  for (int i = 0; i < jsonBody['data']['dist']; i++) {
    final timestamp1 = datas[i]['data']['created'];
    final DateTime date1 = DateTime.fromMillisecondsSinceEpoch(timestamp1.round() * 1000);
    final compare = DateTime.now().difference(date1);
    var date = compare.inHours.toString() + "h";
    if (compare.inHours == 0) {
      date = compare.inMinutes.toString() + "min";
    }
    Map<String, dynamic> obj = {
      'subreddit': datas[i]['data']['subreddit_name_prefixed'],
      'author': 'u/' + datas[i]['data']['author'],
      'date': date,
      'title': datas[i]['data']['title'],
      'media': '',
      'type': 'text',
    };
    if (datas[i]['data']['media-metadata'] != null && datas[i]['data']['is_gallery'] == true) {
      obj['type'] = "gallery";
      obj['media'] = datas[i]['data']['media-metadata'][0]['s']['u'].toString().replaceAll("amp;", "");
    }else if (datas[i]['data']['secure_media'] != null && datas[i]['data']['secure_media']['type'] == 'youtube') {
      obj['type'] = 'youtube';
      obj['media'] = datas[i]['data']['url_overridden_by_dest'].toString().replaceAll("amp;", "");
    } else if (datas[i]['data']['secure_media'] != null && datas[i]['data']['secure_media']["reddit_video"] != null) {
      obj['type'] = 'video';
      obj['media'] = datas[i]['data']['secure_media']["reddit_video"]["fallback_url"].toString().replaceAll("amp;", "");
    } else if (datas[i]['data']['preview'] != null) {
      obj['type'] = "photo";
      obj['media'] = datas[i]['data']['preview']['images'][0]['source']['url'].toString().replaceAll("amp;", "");
    }  else if (datas[i]['data']['selftext'] != null) {
      obj['media'] = datas[i]['data']['selftext'];
    }
    res.add(obj);
  }
  return res;
}