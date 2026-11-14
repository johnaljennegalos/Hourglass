import 'dart:convert';
import 'package:hourglass/models/notification_model.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';


class NotificationService {

  Future<List<NotificationModel>?> notificationList() async {
    String? authToken = AuthService.accessToken;

    if (authToken == null){
      print('Cannot fetch notification list: User is not authenticated.');
      return null;
    }

    try {
      final list = await ApiService.get(
        '/notifications/',
        token: authToken
      );

      print('NOTIF STATUS: ${list.statusCode}');
      print('NOTIF BODY: ${list.body}');

      if (list.statusCode == 200 || list.statusCode == 201) {
        final List<dynamic> notificationList = jsonDecode(list.body);
        return notificationList.map((json) => NotificationModel.fromJson(json)).toList();
      } else {
        print('Error fetching notification list: ${list.body} ${list.statusCode}');
        return [];
      }


    } catch (e) {
      print('An error occurred while fetching the list: $e');
      return null;
    }
  }


  Future<int?> getUnreadCount() async {
    String? authToken = AuthService.accessToken;

    if (authToken == null){
      print('Cannot fetch unread count: User is not authenticated.');
      return null;
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
        print('Error fetching unread count: ${unreadCount.body} ${unreadCount.statusCode}');
        return 0;
      }

    } catch (e) {
      print('An error occurred while fetching unread count: $e');
      return null;
    }
  }

  Future<bool> markAsRead(int notificationId) async {
    String? authToken = AuthService.accessToken;

    if (authToken == null){
      print('Cannot mark as read: User is not authenticated.');
      return false;
    }

    try {

      final response = await ApiService.patch(
        '/notifications/$notificationId/read/',
        body: {'is_read': true},
        token: authToken
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }

    } catch (e) {
      print('An error occurred while marking as read: $e');
      return false;
    }
  }


  Future<bool> markAllAsRead() async {
    String? authToken = AuthService.accessToken;

    if (authToken == null){
      print('Cannot marking all as read: User is not authenticated.');
      return false;
    }

    try {

      final response = await ApiService.post(
        '/notifications/mark-all-read/',
        body: {},
        token: authToken
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }

    } catch (e) {
      print('An error occurred while marking all as read: $e');
      return false;
    }

  }
}