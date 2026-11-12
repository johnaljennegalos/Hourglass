import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:hourglass/models/notification_model.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';


class NotificationService {

  Future<List<NotificationModel>?> notificationList() async {
    String? authToken = AuthService.accessToken;

    if (authToken == null){
      print('Cannot fetch notification list: User is not authenticated.');
      return [];
    }

    try {
      final list = await ApiService.get(
        '/api/notifications/',
        token: authToken
      );

      if (list.statusCode == 200 || list.statusCode == 201) {
        final List<NotificationModel> notificationList = jsonDecode(list.body);
        return notificationList;
      } else {
        print('Error fetching notification list: ${list.body} ${list.statusCode}');
        return [];
      }


    } catch (e) {
      print('An error occurred while fetching the list: $e');
      return [];
    }
  }


  Future<int?> getUnreadCount() async {
    String? authToken = AuthService.accessToken;

    if (authToken == null){
      print('Cannot fetch unread count: User is not authenticated.');
      return 0;
    }

    try {
      final unreadCount = await ApiService.get(
        '/notifications/unread-count/',
        token: authToken
      );

      if(unreadCount.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(unreadCount.body);
        return data['unread_count'] ?? 0;
      } else {
        print('Error fetching notification list: ${unreadCount.body} ${unreadCount.statusCode}');
        return 0;
      }

    } catch (e) {
      print('An error occurred while fetching unread count: $e');
      return 0;
    }
  }
}