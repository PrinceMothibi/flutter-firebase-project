// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAFu0c8qUFo7Ivg94nclrZaa3uABVdZCu8',
    appId: '1:908591164086:web:8c739996c0e22ff100d417',
    messagingSenderId: '908591164086',
    projectId: 'times-for-rome',
    authDomain: 'times-for-rome.firebaseapp.com',
    databaseURL: 'https://times-for-rome-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'times-for-rome.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAGFBQiy5oTeYUwK8XSXZ7tvtjMrt3eCcc',
    appId: '1:908591164086:android:9ea1206cdc05dfa800d417',
    messagingSenderId: '908591164086',
    projectId: 'times-for-rome',
    databaseURL: 'https://times-for-rome-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'times-for-rome.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAAXgO7WoyjqTXpig9ksOfgV0jXLQ40s1M',
    appId: '1:908591164086:ios:3163b9bfb054943000d417',
    messagingSenderId: '908591164086',
    projectId: 'times-for-rome',
    databaseURL: 'https://times-for-rome-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'times-for-rome.appspot.com',
    iosBundleId: 'za.co.wethinkcode.widgetsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAAXgO7WoyjqTXpig9ksOfgV0jXLQ40s1M',
    appId: '1:908591164086:ios:3163b9bfb054943000d417',
    messagingSenderId: '908591164086',
    projectId: 'times-for-rome',
    databaseURL: 'https://times-for-rome-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'times-for-rome.appspot.com',
    iosBundleId: 'za.co.wethinkcode.widgetsApp',
  );
}