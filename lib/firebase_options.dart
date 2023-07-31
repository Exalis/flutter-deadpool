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
    apiKey: 'AIzaSyCFzQkAUtmJ-Ud7GvIa4CONWcaiQJF4ZW4',
    appId: '1:944047478764:web:bbb05ddf5d8e3f08e692c9',
    messagingSenderId: '944047478764',
    projectId: 'flutter-deadpool',
    authDomain: 'flutter-deadpool.firebaseapp.com',
    storageBucket: 'flutter-deadpool.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMS1oButo5vYmbvZ1y1wlTVx8ZXumYB4M',
    appId: '1:944047478764:android:1b1a90ecb72746c3e692c9',
    messagingSenderId: '944047478764',
    projectId: 'flutter-deadpool',
    storageBucket: 'flutter-deadpool.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLvBZH0EJtVcmd9oH99hnV8YJdCcHnJPU',
    appId: '1:944047478764:ios:0b32b9d9989cf2ebe692c9',
    messagingSenderId: '944047478764',
    projectId: 'flutter-deadpool',
    storageBucket: 'flutter-deadpool.appspot.com',
    iosClientId: '944047478764-1dqugkdv3nab7en8rtcj4grs6eiaq3ig.apps.googleusercontent.com',
    iosBundleId: 'com.example.deadpool',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCLvBZH0EJtVcmd9oH99hnV8YJdCcHnJPU',
    appId: '1:944047478764:ios:3ecbfbb2bf645549e692c9',
    messagingSenderId: '944047478764',
    projectId: 'flutter-deadpool',
    storageBucket: 'flutter-deadpool.appspot.com',
    iosClientId: '944047478764-kiso8sjar26201b2p8g0qjmdgtejngj8.apps.googleusercontent.com',
    iosBundleId: 'com.example.deadpool.RunnerTests',
  );
}