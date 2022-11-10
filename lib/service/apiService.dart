// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient extends GetxController {
  FlutterSecureStorage localStorage = FlutterSecureStorage();

  fullUrl(String parameter) {
    // stander url https://smartays.com/api/auth/
    return "https://smartays.com/api/auth/$parameter";
  }

  Future<Map> login(String email, String password) async {
    late Map result;
    await http.post(fullUrl("login"),
        body: {"email": email, "password": password}).then((response) {
      result = jsonDecode(response.body)['data'];
      localStorage.write(key: "token", value: result["access_token"]);
    });

    return result;
  }

  Future<Map> getMap() async {
    late Map result;
    String? token = await localStorage.read(key: "token");
    await http
        .post(fullUrl("user_get_map"), body: {"token": token}).then((response) {
      result = jsonDecode(response.body)["data"];
    });
    return result;
  }

  Future<List> getTimework() async {
    late List result;
    String? token = await localStorage.read(key: "token");
    await http.post(fullUrl("user_get_timeworke"), body: {"token": token}).then(
        (response) {
      result = jsonDecode(response.body)["data"];
    });
    return result;
  }

  Future<Map> user_get_timeworke_presences() async {
    //! for what????
    Map result = {};
    String? token = await localStorage.read(key: "token");
    await http.post(fullUrl("user_get_timeworke_presences"),
        body: {"token": token}).then((response) {
      result = jsonDecode(response.body)["data"];
    });
    return result;
  }

  Future<Map> logout() async {
    late Map result;
    String? token = await localStorage.read(key: "token");
    await http.post(fullUrl("logout"), body: {"token": token}).then((response) {
      result = jsonDecode(response.body);
    });
    return result;
  }

  Future<Map> getProfile() async {
    Map result = {};
    String? token = await localStorage.read(key: "token");
    await http
        .post(fullUrl("user-profile"), body: {"token": token}).then((response) {
      result = jsonDecode(response.body)['data'];
    });
    return result;
  }

  Future<Map> editProfile(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    Map result = {};
    String? token = await localStorage.read(key: "token");
    await http.post(fullUrl("user_edit_profile"), body: {
      "token": token,
      "name": name,
      "email": email,
      "password": password,
      "phone": phone
    }).then((response) {
      result = jsonDecode(response.body)['data'];
    });
    return result;
  }

  Future<Map> userAskPermission(String reason) async {
    Map result = {};
    String? token = await localStorage.read(key: "token");
    await http.post(fullUrl("user_ask_perm"),
        body: {"token": token, "reason": reason}).then((response) {
      result = jsonDecode(response.body)['message'];
    });
    return result;
  }

  Future<Map> checkDevice(String deviceId) async {
    Map result = {};
    String? token = await localStorage.read(key: "token");
    await http.post(fullUrl("user_check_device"),
        body: {"token": token, "visit": deviceId}).then((response) {
      result = jsonDecode(response.body);
    });
    return result;
  }
}
