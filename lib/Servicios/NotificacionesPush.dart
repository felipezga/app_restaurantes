import 'package:firebase_messaging/firebase_messaging.dart';

class NotificacionesPush{
  //FirebaseMessaging _messaging = FirebaseMessaging();
  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  initNotification() async {

    // Initialize the Firebase app
    //await Firebase.initializeApp();

    // On iOS, this helps to take the user permissions
    /*_messaging.requestNotificationPermissions(
      IosNotificationSettings(
        alert: true,
        badge: true,
        provisional: false,
        sound: true,
      ),
    );*/
    // For handling the received notifications

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage received: $message.notification');
    });

    /*FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        print('onMessage received: $notification');
      }
    });*/

    /*_messaging.configure(
      onMessage: (message) async {
        print('onMessage received: $message');
      },
      //onBackgroundMessage: _firebaseMessagingBackgroundHandler,
      onLaunch: (message) async {
        print('onLaunch: $message');
      },
      onResume: (message) async {
        print('onResume: $message');
      },
    );*/


    // Used to get the current FCM token
    _messaging.getToken().then((token) {
      print('Token: $token');
    }).catchError((e) {
      print("Fallo revisar codigo aqui!!!");
      print(e);
    });

  }
}


class PushNotification {
  PushNotification({
    this.title,
    this.body,
    this.dataTitle,
    this.dataBody,
  });

  String title;
  String body;
  String dataTitle;
  String dataBody;

  factory PushNotification.fromJson(Map<String, dynamic> json) {
    return PushNotification(
      title: json["notification"]["title"],
      body: json["notification"]["body"],
      dataTitle: json["data"]["title"],
      dataBody: json["data"]["body"],
    );
  }
}


