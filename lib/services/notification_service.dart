import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/details.dart';
import 'api_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

  final _firebaseMessaging = FirebaseMessaging.instance;
  final ApiService apiService = ApiService();

  initNotifications() async {
    await _firebaseMessaging.requestPermission(alert: true, badge: true, sound: true);
    final fCMToken = await _firebaseMessaging.getToken();
    print('$fCMToken');

    // FirebaseMessaging.onMessage.listen((RemoteMessage message){
    //   print('Message: ${message.notification?.title}');
    // });

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  Future<void> handleMessage(RemoteMessage? message) async {
    if (message != null) {
      final meal = await apiService.fetchRandom();

      navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => DetailsScreen(mealId: meal.id)),
      );
    }
    }
  }

