import 'package:flutter/material.dart';
import 'package:hourglass/models/notification_model.dart';
import 'package:hourglass/views/pages/student/notifications/widgets/notification_tile.dart';
import 'package:hourglass/services/notification_service.dart';

class StudentNotificationsPage extends StatefulWidget {
  final VoidCallback? onUnreadCountChange;

  const StudentNotificationsPage({super.key, this.onUnreadCountChange});

  @override
  State<StudentNotificationsPage> createState() => _StudentNotificationsPageState();
}

class _StudentNotificationsPageState extends State<StudentNotificationsPage> {
  List<NotificationModel> _notifications = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState(){
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    _errorMessage = null;

    if(_notifications.isEmpty) {
      setState(() {
        _isLoading = true;
      });
    }

    try{

      final data = await NotificationService().notificationList();

      if (!mounted) return;

      setState(() {
        _notifications = data ?? [];
        _isLoading = false;
      });

      widget.onUnreadCountChange?.call();

    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _handleNotificationTap(NotificationModel notification) async {
    if (!notification.isRead) {

      final index = _notifications.indexWhere((n) => n.id == notification.id);

      if (index != -1) {
        setState(() {
          _notifications[index] = notification.copyWith(isRead: true);
        });
      }

      try {

        await NotificationService().markAsRead(notification.id);

        widget.onUnreadCountChange?.call();

      } catch (e) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'))
        );
      }

    }
  }

  Future<void> _handleMarkAllAsRead() async {

    try {

      setState(() {
        _notifications = _notifications.map((n) => n.copyWith(isRead: true)).toList();
      });

      await NotificationService().markAllAsRead();

      widget.onUnreadCountChange?.call();

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'))
      );
    }
  }

  Widget _buildBody() {
    if (_isLoading){
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_errorMessage!),
          ElevatedButton(
            onPressed: _loadNotifications,
            child: const Text('Retry'),
          )
        ],
      );
    }


    if(_notifications.isEmpty) {
      return RefreshIndicator(
        onRefresh: _loadNotifications,
        child: ListView(
          children: const [
            SizedBox(height: 160),
            Icon(Icons.notifications_none, size: 64, color: Colors.grey),
            SizedBox(height: 12),
            Center(child: Text('No notifications yet')),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadNotifications,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return NotificationTile(
            notification: notification,
            onTap: () => _handleNotificationTap(notification),
          );
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final hasUnread = _notifications.any((n) => !n.isRead);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (hasUnread) ...[
            TextButton(
              onPressed: _handleMarkAllAsRead,
              child: const Text('Mark all as read'),
            )
          ]
        ],
      ),
      body: _buildBody(),
    );
  }
}
