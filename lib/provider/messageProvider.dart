import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_project_testing/config/databaseConfig.dart';
import 'package:http/http.dart' as http;

import '../modal/messageBox.dart';

class MessageProvider extends ChangeNotifier {
  List<MessageBox>? _message = [];
  List<Map<String, dynamic>>? _listOfReceiver = [];

  List<MessageBox>? get message {
    return [...?_message];
  }

  List<Map<String, dynamic>>? get listOfReceiver {
    return [...?_listOfReceiver];
  }

  getMessageBoxList(bool usertype) async {
    List<Map<String, dynamic>>? resultList;

    final url = Uri.parse(databaseURL() + 'api/All/getAllReceiver');

    String data = jsonEncode({
      'userType': usertype,
    });

    try {
      final response = await http.post(url, body: data, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);

        resultList =
            jsonList.map((json) => Map<String, dynamic>.from(json)).toList();
      }
    } catch (e) {}

    _listOfReceiver = resultList;
    notifyListeners();
  }

  getAllMessage(int sender, int receiver) async {
    List<MessageBox> resultList = [];
    MessageBox result;

    final url = Uri.parse(databaseURL() + 'api/All/getAllMessage');

    String data = jsonEncode({
      'senderID': sender,
      'receiverID': receiver,
    });

    try {
      final response = await http.post(url, body: data, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      if (response.statusCode == 200) {
        final messageList = json.decode(response.body);
        for (var item in messageList) {
          for (var sc in item) {
            result = MessageBox.fromJson(sc);
            resultList.add(result);
          }
        }
      }
    } catch (e) {}
    _message = resultList;
    notifyListeners();
  }

  Future<bool> sendMessage(String data) async {
    final url = Uri.parse(databaseURL() + 'api/All/sendMessage');

    try {
      final response = await http.post(url, body: data, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
