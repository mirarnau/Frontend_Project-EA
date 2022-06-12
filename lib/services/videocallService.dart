import 'dart:convert';
import 'package:flutter_tutorial/config.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'dart:io' show Platform;

class VideocallService{
  static Future <String> getAgoraToken (String channelName) async {
  var baseUrl = apiURL + "/api/videocall/";
    var res = await http.get(Uri.parse(baseUrl + channelName),
      headers: {'content-type': 'application/json', 'authorization': LocalStorage('key').getItem('token')});
    Object data = jsonDecode(res.body);
    var agoraToken = AgoraToken.fromJson(await jsonDecode(res.body)).tokenValue;
    return agoraToken;
    print ("token aogra;");
    print(agoraToken);
    }
}

class AgoraToken {
  final String tokenValue;

  AgoraToken({
    required this.tokenValue,
  });

  factory AgoraToken.fromJson(Map<String, dynamic> json) {
    return AgoraToken(
      tokenValue: json['rtcToken'] as String,
    );
  }
 
 @override
  String toString() {
    return tokenValue;
  }
}
