// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiLogin {
  String? user;
  String? pass;
  int response;
  String pesan;

  ApiLogin(
      {required this.user,
      required this.pass,
      required this.response,
      required this.pesan}); //data yang di ambil;
  factory ApiLogin.createPost(Map<String, dynamic> object) {
    return ApiLogin(
        user: object['user'],
        pass: object['pass'],
        response: object['response'],
        pesan: object['pesan']);
  }

  static Future<ApiLogin> login(String user, String pass) async {
    String baseURL =
        "https://lokdon.jambiprov.go.id/app2/api/Login"; //link api login nya
    var loginResult =
        await http.post(Uri.parse(baseURL), body: {"user": user, "pass": pass});
    var jsonObject = jsonDecode(loginResult.body);
    return ApiLogin.createPost(jsonObject);
  }
}
