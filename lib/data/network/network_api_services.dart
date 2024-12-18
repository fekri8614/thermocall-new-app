import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:thermocall_new2/data/app_exceptions.dart';
import 'package:thermocall_new2/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getApi({required String url, required String userId}) async {
    if (kDebugMode) {
      print("GET url +> $url");
    }

    dynamic responseJson;

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {"user-id": userId},
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw TimeoutException('');
    }

    return responseJson;
  }

  @override
  Future postApi({
    required String url,
    data,
    required String userId,
  }) async {
    if (kDebugMode) {
      print("POST url +> $url");
      print("POST data +> $data");
    }

    dynamic responseJson;

    try {
      final response = await http.post(
        Uri.parse(url),
        body: data,
        headers: {"user-id": userId},
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    if (kDebugMode) {
      print("RESPONSE-JSON +> $responseJson");
    }
    return responseJson;
  }

  @override
  Future updateApi({
    required String url,
    required String sensorId,
    Object? data,
    required String userId,
  }) async {
    if (kDebugMode) {
      print("PATCH url +> $url/$sensorId");
      print('PATCH data +> $data');
    }

    dynamic responseJson;

    try {
      final response = await http
          .patch(
            Uri.parse("$url/$sensorId"),
            headers: {"user-id": userId},
            body: data,
          )
          .timeout(
            const Duration(seconds: 10),
          );

      responseJson = response;
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }

    if (kDebugMode) {
      print("PATCH-DATA +> $responseJson");
    }

    return responseJson;
  }

  @override
  Future deleteApi(
      {required String url,
      required String sensorId,
      Object? data,
      required String userId}) async {
    if (kDebugMode) {
      print("DELETE url +> $url/$sensorId");
      print('PATCH data +> $data');
    }

    dynamic responseJson;

    try {
      final response = await http.delete(
        Uri.parse("$url/$sensorId"),
        headers: {
          'user-id': userId,
        },
      ).timeout(
        const Duration(seconds: 10),
      );

      responseJson = response;
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }

    if (kDebugMode) {
      print("DELETE-DATA +> $responseJson");
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201: // Handling 201 status code
        // Check if the response body is valid JSON before decoding
        if (_isJson(response.body)) {
          dynamic responseJson = jsonDecode(response.body);
          return responseJson;
        } else {
          return response.body; // Return raw response if it's not JSON
        }
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw FetchDataException(
            'Error occurred while communicating with server ${response.statusCode}\nData:${response.body}');
    }
  }

// Helper method to check if a string is valid JSON
  bool _isJson(String str) {
    try {
      jsonDecode(str);
      return true;
    } catch (e) {
      return false;
    }
  }
}
