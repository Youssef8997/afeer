import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class NotificationsHandler {
  static  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static Future init() async {

    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true
    );
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    var inAppMessaging = FirebaseInAppMessaging.instance;

    inAppMessaging.setAutomaticDataCollectionEnabled(true);



    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings("@mipmap/ic_launcher");
    const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (notf) {
        });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      var vibrationPattern = Int64List(4);
      vibrationPattern[0] = 0;
      vibrationPattern[1] = 1000;
      vibrationPattern[2] = 5000;
      vibrationPattern[3] = 2000;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                notification.android!.channelId??"orders",
                notification.android!.channelId??"orders",
                icon: android.smallIcon,
                category: AndroidNotificationCategory.recommendation,
                channelShowBadge: true,
                enableVibration: true,
                fullScreenIntent: true,
                importance: Importance.max,
                playSound: true,
                priority: Priority.max,
                ongoing: true,
                visibility: NotificationVisibility.public,
                audioAttributesUsage: AudioAttributesUsage.notification,
                vibrationPattern: vibrationPattern,
                enableLights: true,

              ),
              // iOS: DarwinNotificationDetails(
              //   badgeNumber: int.tryParse(apple!.badge!)??0,
              //   presentAlert: true,
              //   presentBadge: true,
              //   presentSound: true,
              //   subtitle: apple.subtitle,
              // )
            ));
      }
      foregroundHandler();
    });
    foregroundHandler();
  }
  static Future foregroundHandler() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      var vibrationPattern = Int64List(4);
      vibrationPattern[0] = 0;
      vibrationPattern[1] = 1000;
      vibrationPattern[2] = 5000;
      vibrationPattern[3] = 2000;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                notification.android!.channelId!,
                notification.android!.channelId!,
                icon: android.smallIcon,
                category: AndroidNotificationCategory.recommendation,
                channelShowBadge: true,
                enableVibration: true,
                fullScreenIntent: true,
                importance: Importance.max,
                playSound: true,
                priority: Priority.max,
                ongoing: true,
                visibility: NotificationVisibility.public,
                audioAttributesUsage: AudioAttributesUsage.notificationRingtone,
                vibrationPattern: vibrationPattern,
                enableLights: true,

              ),
              // iOS: DarwinNotificationDetails(
              //   badgeNumber: int.tryParse(apple!.badge!)??0,
              //   presentAlert: true,
              //   presentBadge: true,
              //   presentSound: true,
              //   subtitle: apple.subtitle,
              // )
            ));
      }
    });
  }
}
