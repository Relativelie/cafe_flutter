import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/errors/networkError.dart';
import 'package:flutter_application_1/utils/make_uri.dart';
import 'package:http/http.dart' as http;

class Methods {
  final http.Client client = http.Client();

  Future<dynamic> get(String uri, {String path = "", params}) async {
    final url = makeUri(uri, path, params);
    final res = await client.get(url);
    final resVal = jsonDecode(utf8.decode(res.bodyBytes));

    if (res.statusCode == 200) {
      return resVal;
    } else {
      print("exeption");
      throw HttpException(res.body);
    }
  }
}
