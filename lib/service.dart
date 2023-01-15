import 'dart:convert';
import 'package:http/http.dart';

enum RequestAPIStatus{
  initial,
  success,
  fail
}

Future<dynamic> getData({
  required String url,
  bool decode = true,
}) async {
  final response = await get(
    Uri.parse(
      url,
    ),
  );
  if (decode) {
    return json.decode(response.body);
  } else {
    return response.body;
  }
}