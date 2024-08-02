import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin;

  ConnectivityService(this._localNotificationsPlugin) {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _showToast(result);
      _showNotification(result);
    }).onError((error) {
      print('Connectivity listener error: $error');
    });
    print('ConnectivityService initialized');
  }

  void _showToast(ConnectivityResult result) {
    String message;
    switch (result) {
      case ConnectivityResult.mobile:
        message = "Connected to Mobile Network";
        break;
      case ConnectivityResult.wifi:
        message = "Connected to WiFi";
        break;
      case ConnectivityResult.none:
      default:
        message = "No Internet Connection";
    }

    print('Connectivity result: $result'); // Debugging print statement
    print('Displaying toast message: $message');
    
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0
    ).then((value) => print('Toast shown: $value'))
    .catchError((error) => print('Toast error: $error'));
  }

  void _showNotification(ConnectivityResult result) async {
    String message;
    switch (result) {
      case ConnectivityResult.mobile:
        message = "Connected to Mobile Network";
        break;
      case ConnectivityResult.wifi:
        message = "Connected to WiFi";
        break;
      case ConnectivityResult.none:
      default:
        message = "No Internet Connection";
    }

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'connectivity_channel', // id
      'Connectivity Changes', // name
      channelDescription: 'Notification for connectivity changes', // description
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _localNotificationsPlugin.show(
      0,
      'Connectivity Status',
      message,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
