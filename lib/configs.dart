import 'package:core/core.dart';

class Configs {
  static const environment =
      String.fromEnvironment('ENVIRONMENT', defaultValue: Environments.dev);

  static void configEnvironment() {
    EnvironmentConfig.setEnvironment(environment);
  }
}

// class FirebaseMessagingConfig {
//   static final _localNotificationService = FlutterLocalNotificationsPlugin();

//   static Future init() async {
//     // You may set the permission requests to "provisional" which allows the user to choose what type
//     // of notifications they would like to receive once the user receives a notification.
//     await FirebaseMessaging.instance.requestPermission(provisional: true);

//     if (Platform.isIOS) {
//       // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
//       final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
//       if (apnsToken != null) {
//         await getToken();
//       }
//     } else {
//       await getToken();
//     }

//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     IOSInitializationSettings iosInitializationSettings =
//         const IOSInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     );

//     final InitializationSettings settings = InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );

//     await _localNotificationService.initialize(
//       settings,
//       onSelectNotification: onSelectNotification,
//     );

//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }

//   static void onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) {}

//   static void onSelectNotification(String? payload) {
//     if (payload != null && payload.isNotEmpty) {
//       RemoteMessage message = RemoteMessage.fromMap(jsonDecode(payload));
//       _handleMessage(message: message);
//     }
//   }

//   static Future<void> getToken() async {
//     // Get the token for this device

//     // String? token = await FirebaseMessaging.instance.getToken();
//     //
//     // Log.i('FCM Token => $token');
//   }

//   static Future<void> setupInteractedMessage() async {
//     // Get any messages which caused the application to open from
//     // a terminated state.
//     RemoteMessage? initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();

//     // If the message also contains a data property with a "type" of "chat",
//     // navigate to a chat screen
//     if (initialMessage != null) {
//       _handleMessage(message: initialMessage);
//     }

//     // Also handle any interaction when the app is in the background via a
//     // Stream listener
//     FirebaseMessaging.onMessageOpenedApp
//         .listen((event) => _handleMessage(message: event));

//     // Also handle any interaction when the app is in the foreground via a
//     // Stream listener
//     FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
//   }

//   static Future _handleForegroundMessage(RemoteMessage message) async {
//     // showPushNotiToast(message);
//     Log.i('NOTIFICATION : ${jsonEncode(message.toMap())}');
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//     if (notification != null && android != null) {
//       final details = await _notificationDetails();
//       _localNotificationService.show(Random().nextInt(10000),
//           notification.title, notification.body, details,
//           payload: jsonEncode(message.toMap()));
//     }
//     await AppNavigator.context.read<AppCubit>().requestCountUnread();
//     await AppNavigator.context
//         .read<NotificationListCubit>()
//         .requestNotification();
//   }

//   static Future<NotificationDetails> _notificationDetails() async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       'channel_id',
//       'channel_name',
//       channelDescription: 'description',
//       importance: Importance.max,
//       priority: Priority.max,
//       playSound: true,
//     );

//     const IOSNotificationDetails iosNotificationDetails =
//         IOSNotificationDetails(sound: 'noti.wav');

//     return const NotificationDetails(
//       android: androidNotificationDetails,
//       iOS: iosNotificationDetails,
//     );
//   }

//   static void _handleMessage({RemoteMessage? message}) async {
//     Log.i('NOTIFICATION : ${jsonEncode(message?.toMap())}');
//     final appCubit = AppNavigator.context.read<AppCubit>();

//     final contentJson = jsonDecode(message!.data["body"]);
//     ContentNotificationModel content =
//         ContentNotificationModel.fromJson(contentJson);
//     //read notification
//     List<NotificationModel> listNotification =
//         await getIt.get<NotificationUseCase>().requestNotification(30, 1);
//     try {
//       final itemRead = listNotification
//           .firstWhere((element) => element.content == jsonEncode(contentJson));
//       await getIt
//           .get<NotificationUseCase>()
//           .requestReadNotification(itemRead.id);
//     } catch (_) {}
//     if (contentJson['contentType'] == 'HTML') {
//       AppNavigator.push(
//         Routes.notificationDetails,
//         contentJson['eventId'],
//       );
//     } else {
//       await onSelectNoti(content);
//     }
//     await appCubit.requestCountUnread();
//   }

//   static Future<void> onSelectNoti(ContentNotificationModel notiData) async {
//     if (notiData.dataType == 'TICKET') {
//       MiniAppManager.openDetailTicket(notiData.dataId ?? '');
//     } else if (notiData.dataType == 'COMPLAINT') {
//       MiniAppManager.pushDetailFeedback(notiData.dataId ?? '');
//     } else if (notiData.dataType == 'SURVEY') {
//     } else if (notiData.dataType == 'INCIDENT') {
//       MiniAppManager.pushDetailIncident(
//           id: notiData.dataId ?? '', waitApproval: true);
//     } else if (notiData.dataType == 'TASK') {
//       final incidentId =
//           await MiniAppManager.getIncidentId(notiData.dataId ?? '');
//       MiniAppManager.pushDetailSolutionIncident(
//           incidentId: incidentId, taskId: notiData.dataId ?? '');
//     } else if (notiData.dataType == 'SHIFT_TRANSFER') {
//       MiniAppManager.startShiftTransferApp({
//         "buildingId": "",
//         "id": "",
//         "shiftTransferId": notiData.dataId,
//         "cubit": null
//       });
//     } else if (notiData.dataType == 'SWAP_APPLICATION') {
//       MiniAppManager.startApproveShiftTransferApp({
//         "shiftId": notiData.dataId ?? '',
//       });
//     } else if (notiData.dataType == 'MY_SHIFT') {
//       MiniAppManager.startShiftManagementApp(notiData.dataId ?? "");
//     } else if (notiData.dataType == 'OT_REGISTRATION') {
//       MiniAppManager.pushOvertimeRegistrationDetailSchedule(
//           {'idSchedule': notiData.dataId ?? ''});
//     } else if (notiData.dataType == "OT_REGISTRATION_SCHEDULE") {
//       MiniAppManager.pushOvertimeRegistrationDetailSchedule(
//           {'id': notiData.dataId ?? ''});
//     } else if (notiData.dataType == "CLEANING_ATTENDANCE") {
//       // AppNavigator.push(Routes.notificationAttendance, {
//       //   'title': item.title,
//       //   'content': item.content,
//       // });
//     } else if (notiData.dataType == "SECURITY_ATTENDANCE") {
//       // AppNavigator.push(Routes.notificationAttendance, {
//       //   'title': item.title,
//       //   'content': item.content,
//       // });
//     } else if (notiData.dataType == "SHIFT_SCHEDULE") {
//       MiniAppManager.startShiftManagementApp(notiData.dataId ?? "");
//     } else {
//       AppNavigator.push(Routes.notificationNotSupported);
//     }
//   }

//   @pragma('vm:entry-point')
//   static Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     // If you're going to use other Firebase services in the background, such as Firestore,
//     // make sure you call `initializeApp` before using other Firebase services.
//     await Firebase.initializeApp();

//     Log.i('Handling a background message111 ${message.messageId}');
//   }
// }
