import 'package:flutter_application_1/config.dart';



Uri makeUri(
  String serverUrl,
  bool isEdamamQuery, [
  String path = "",
  Map<String, dynamic>? query,
]) {
  final Uri uriServer = Uri.parse(serverUrl);

  final uri = Uri(
    scheme: uriServer.scheme,
    host: uriServer.host,
    port: uriServer.port,
    path: path.isNotEmpty ? path : uriServer.path,
    queryParameters: query,
  );
print('uri ${uri}');
  return uri;
}
