import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/core/helpers/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart'
    show FirebaseMessaging, RemoteMessage;

Future<void> requestNotificationPermissions() async {
  await FirebaseMessaging.instance.requestPermission();
}

Future<void> setupNotificationTapHandler() async {
  // Case 1: App opened from terminated state
  await FirebaseMessaging.instance.getInitialMessage().then((message) async {
    if (message != null) {
      await _handleNotificationTap(message);
    }
  });

  // Case 2: App in background
  FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
}

Future<void> _handleNotificationTap(RemoteMessage message) async {
  final String? receiverId = message.data['receiverId'];
  if (receiverId == null) {
    return;
  }

  final DocumentSnapshot<Map<String, dynamic>> receiverDoc =
      await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .get();
  if (!receiverDoc.exists) {
    return;
  }

  final receiverUser = UserEntity.fromMap(receiverDoc.data());
  await chatNavigation(navigatorKey.currentContext!, extra: receiverUser);
}
