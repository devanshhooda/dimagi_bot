import 'dart:convert';

import 'package:dimagi_bot/controller/constants/constants.dart';
import 'package:dimagi_bot/model/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatController with ChangeNotifier {
  ChatController() {
    _initSP().then((_) => _fetchChatMessageList());
  }

  // var employeesData = {
  //   "name": {"location": "loc name", "inOffice": true}
  // };

  List? chatMessages;

// shared pref instance
  late SharedPreferences _sharedPreference;

  Future _initSP() async {
    _sharedPreference = await SharedPreferences.getInstance();
  }

  _getChatMessagesList() => _sharedPreference.get(Constants.chatMessagesList);

  _getEmployeesData() => _sharedPreference.get(Constants.employeesData);

  _setChatMessagesList(String messagesList) async => await _sharedPreference
      .setString(Constants.chatMessagesList, messagesList);

  _setEmployeesData(String employeesData) async =>
      await _sharedPreference.setString(Constants.employeesData, employeesData);

  _fetchChatMessageList() async {
    var messages = _getChatMessagesList();

    if (messages == null) {
      chatMessages = [];
    } else {
      List messagesList = jsonDecode(messages)[Constants.messages];
      chatMessages = messagesList;
    }

    await Future.delayed(const Duration(seconds: 1));

    notifyListeners();
  }

  bool sendMessage(String messageText) {
    // Adding local message
    chatMessages?.add(ChatMessageModel(
            messageContent: messageText, messageType: Constants.receiver)
        .toJson());

    notifyListeners();

    // Adding remote message
    ChatMessageModel replyMessage = _processReply(messageText);

    chatMessages?.add(replyMessage.toJson());
    notifyListeners();

    _setChatMessagesList(jsonEncode({Constants.messages: chatMessages}));
    return true;
  }

  ChatMessageModel _processReply(String messageText) {
    List expression = messageText.split(" ");

    String command = expression[0];
    String? reply;

    switch (command) {
      // HELP
      case "help":
        reply = Constants.helpMessage;

      // Ping
      case "ping":
        reply = Constants.pingMessage;

      // Say something
      case "say":
        {
          String args = messageText.substring(3);
          reply = args;
        }

      // Set Location
      case "hereiam":
        {
          if (expression.length < 3) {
            reply = Constants.argumentsError;
            break;
          }
          bool isLocationSaved = _setLocationData(expression[1], expression[2]);
          if (isLocationSaved == true) {
            reply = "Ok, I'll remeber that for you :)";
          }
        }

      // Get Location
      case "whereis":
        {
          if (expression.length < 2) {
            reply = Constants.argumentsError;
            break;
          }

          var locationData = _getLocationData(expression[1]);

          if (locationData == null) {
            reply = Constants.dataNotFound;
          } else {
            reply = locationData[Constants.location];
          }
        }

      default:
        reply = Constants.errorMessage;
    }

    reply ??=
        "Seems like there was an error can you please try again? Kindly refer 'help' for more...";

    return ChatMessageModel(
        messageContent: reply, messageType: Constants.sender);
  }

  bool _setLocationData(String employeeName, String locationName) {
    var data = _getEmployeesData();

    var employeesData = {};

    if (data != null) {
      employeesData = jsonDecode(data);
    }

    if (employeesData[employeeName] == null) {
      employeesData[employeeName] = {};
    }

    employeesData[employeeName][Constants.location] = locationName;

    _setEmployeesData(jsonEncode(employeesData));

    return true;
  }

  dynamic _getLocationData(String employeeName) {
    var data = _getEmployeesData();

    var employeesData = {};

    if (data != null) {
      employeesData = jsonDecode(data);
    }

    return employeesData[employeeName];
  }
}
