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
    apiKey: 'AIzaSyDBlPeOEjsX3KoCmhl16ZC1enTfMrlq4oo',
    appId: '1:90626071184:web:f8916c091095cff60e1615',
    messagingSenderId: '90626071184',
    projectId: 'flutter-booking-project',
    authDomain: 'flutter-booking-project.firebaseapp.com',
    storageBucket: 'flutter-booking-project.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCRuAKEjK3H5T9_ZUcHcdG_YuYZNoqHcLY',
    appId: '1:90626071184:android:9be6bed8e0a509260e1615',
    messagingSenderId: '90626071184',
    projectId: 'flutter-booking-project',
    storageBucket: 'flutter-booking-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC-L7C02Q4-_sPzTm9X5KrUL0Vj_rttndc',
    appId: '1:90626071184:ios:130ec17081651bba0e1615',
    messagingSenderId: '90626071184',
    projectId: 'flutter-booking-project',
    storageBucket: 'flutter-booking-project.appspot.com',
    iosBundleId: 'com.example.bookingApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC-L7C02Q4-_sPzTm9X5KrUL0Vj_rttndc',
    appId: '1:90626071184:ios:d5d97437c6e425810e1615',
    messagingSenderId: '90626071184',
    projectId: 'flutter-booking-project',
    storageBucket: 'flutter-booking-project.appspot.com',
    iosBundleId: 'com.example.bookingApp.RunnerTests',
  );
}
