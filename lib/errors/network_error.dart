import 'dart:convert';

class HttpException implements Exception {
  Map<String, dynamic>? errors;

  HttpException(dynamic responseBody) {
    if (responseBody == null) {
      errors = {
        'unknown_error':
            'An unknown error occurred, no further information available'
      };
    } else {
      try {
        errors = json.decode(responseBody);
      } catch (e) {
        errors = responseBody;
      }
    }
    errors = errors;
  }

  @override
  String toString() {
    return errors!.values.toList().join(', ');
  }
}
