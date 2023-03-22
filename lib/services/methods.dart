import 'dart:convert';
import 'package:flutter_application_1/utils/makeUri.dart';
import 'package:http/http.dart' as http;



class Methods {
  final http.Client client = http.Client();

  Uri makeUrl(String url, String path,
      {Map<String, dynamic>? query, bool isEdamamQuery = false}) {
    return makeUri(url, isEdamamQuery, path, query);
  }

  Future<dynamic> get(String uri, params, {String path = "", bool isEdamamQuery = false}) async {
    final url = makeUrl(uri, path, query: params, isEdamamQuery: isEdamamQuery);
    final res = await client.get(url);
    return jsonDecode(utf8.decode(res.bodyBytes));
  }
}
