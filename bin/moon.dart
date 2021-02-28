import 'dart:convert';
import 'package:http/http.dart';


Future<String> moonCommand(int timestamp) async {
  var client = Client();
  var response = await client.get('https://api.farmsense.net/v1/moonphases/?d=${timestamp}');

  Map moon = json.decode(response.body)[0];
  var moonStr = 'The moon is a ${moon['Moon'][0]}, and is currently in phase ${moon['Phase']}';
  return moonStr;
}

