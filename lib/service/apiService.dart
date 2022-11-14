// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_element

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient extends GetxController {
  FlutterSecureStorage localStorage = FlutterSecureStorage();

  Uri _fullUrl(String parameter) {
    // stander url https://smartays.com/api/auth/
    return Uri.parse("https://smartays.com/api/auth/$parameter");
  }

  Future<Map<String, dynamic>> request(
      {String? url, Map<String, String>? requestBody}) async {
    try {
      var request = http.MultipartRequest('POST', _fullUrl(url!))
        ..fields.addAll(requestBody!);
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      print(respStr);
      return jsonDecode(respStr);
    } catch (error) {
      print(error);
      return {"error": error};
    }
  }

  Future<Map> login(String email, String password) async {
    late Map result;

    await request(
            url: 'login', requestBody: {"email": email, "password": password})
        .then((response) => result = response['data']);
    // save token
    localStorage.write(key: "token", value: result["access_token"]);
    return result;
  }

  Future<Map> getMap() async {
    late Map result;
    String? token = await localStorage.read(key: "token");

    await request(url: 'user_get_map', requestBody: {"token": token!})
        .then((response) => result = response['data']);
    return result;
  }

  Future<Map> getTimework() async {
    late Map result;
    String? token = await localStorage.read(key: "token");

    await request(url: 'user_get_timeworke', requestBody: {"token": token!})
        .then((response) => result = response);
    return result;
  }

  Future<List> attendanceRecord() async {
    List result = [];
    String? token = await localStorage.read(key: "token");

    await request(
            url: 'user_get_timeworke_presences', requestBody: {"token": token!})
        .then((response) => result = response['data']);
    return result;
  }

  Future<Map> logout() async {
    late Map result;
    String? token = await localStorage.read(key: "token");
    await request(url: 'logout', requestBody: {"token": token!})
        .then((response) => result = response['data']);
    return result;
  }

  Future<Map> getProfile() async {
    Map result = {};
    String? token = await localStorage.read(key: "token");
    await request(url: 'user-profile', requestBody: {"token": token!})
        .then((response) => result = response['data']);
    return result;
  }

  Future<Map> editProfile(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    Map result = {};
    String? token = await localStorage.read(key: "token");

    await request(url: 'user_edit_profile', requestBody: {
      "token": token!,
      "name": name,
      "password": password,
      "phone": phone
    }).then((response) => result = response['data']);
    return result;
  }

  Future<String> userAskPermission(String reason) async {
    String? result;
    String? token = await localStorage.read(key: "token");

    await request(
            url: 'user_ask_perm',
            requestBody: {"token": token!, "reason": reason})
        .then((response) => result = response['message']);
    return result!;
  }

  Future<Map> checkDevice(String deviceId) async {
    Map result = {};
    String? token = await localStorage.read(key: "token");
    await request(url: 'user_check_device', requestBody: {"token": token!})
        .then((response) => result = response['data']);
    return result;
  }

  Future<String> checkIn(
      {required String lat,
      required String lon,
      required String deviceId}) async {
    String result = "";
    String? token = await localStorage.read(key: "token");

    await request(url: 'presence', requestBody: {
      "token": token!,
      "lat": lat,
      "lon": lon,
      "deviceId": deviceId
    }).then((response) => result = response['message']);
    return result;
  }

  Future<String> checkOut(
      {required String lat,
      required String lon,
      required String deviceId}) async {
    String result = "";
    String? token = await localStorage.read(key: "token");
    await request(url: 'leave', requestBody: {
      "token": token!,
      "lat": lat,
      "lon": lon,
      "deviceId": deviceId
    }).then((response) => result = response['message']);
    return result;
  }
}
