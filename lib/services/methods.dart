import 'dart:convert';
import 'package:flutter_application_1/utils/makeUri.dart';
import 'package:http/http.dart' as http;

class Methods {
  final http.Client client = http.Client();

  Future<dynamic> get(String uri,
      {String path = "", bool isEdamamQuery = false, params}) async {
    final url = makeUri(uri, isEdamamQuery, path, params);
    final res = await client.get(url);
    return jsonDecode(utf8.decode(res.bodyBytes));
  }
}
