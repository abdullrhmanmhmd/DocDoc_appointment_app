// File generated for Firebase configuration
// Replace with actual Firebase configuration from Firebase Console
// To generate this file properly, run: flutterfire configure

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import firebase_options.dart;
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
        return windows;
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

  // NOTE: Replace these with your actual Firebase project configuration

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAsfgy7yVP4I7Z4Y3Sg_7KR5YCFugl3emU',
    appId: '1:289750308538:web:2e01ecad7780a177175483',
    messagingSenderId: '289750308538',
    projectId: 'docdoc-a6dd4',
    authDomain: 'docdoc-a6dd4.firebaseapp.com',
    storageBucket: 'docdoc-a6dd4.firebasestorage.app',
    measurementId: 'G-6GKK4HN7N8',
  );

  // Run: flutterfire configure

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDasbjjs2tjzVcAqQIeQphS-oblxvG4r8c',
    appId: '1:289750308538:android:db1053d2c6efc084175483',
    messagingSenderId: '289750308538',
    projectId: 'docdoc-a6dd4',
    storageBucket: 'docdoc-a6dd4.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB9R7n-QWMpXIaKgI6KASWp6qqAs9LhwGk',
    appId: '1:289750308538:ios:4669b0845cc6e2e5175483',
    messagingSenderId: '289750308538',
    projectId: 'docdoc-a6dd4',
    storageBucket: 'docdoc-a6dd4.firebasestorage.app',
    iosBundleId: 'com.example.docAppSw',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB9R7n-QWMpXIaKgI6KASWp6qqAs9LhwGk',
    appId: '1:289750308538:ios:4669b0845cc6e2e5175483',
    messagingSenderId: '289750308538',
    projectId: 'docdoc-a6dd4',
    storageBucket: 'docdoc-a6dd4.firebasestorage.app',
    iosBundleId: 'com.example.docAppSw',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAsfgy7yVP4I7Z4Y3Sg_7KR5YCFugl3emU',
    appId: '1:289750308538:web:7f529b38ea2d05dc175483',
    messagingSenderId: '289750308538',
    projectId: 'docdoc-a6dd4',
    authDomain: 'docdoc-a6dd4.firebaseapp.com',
    storageBucket: 'docdoc-a6dd4.firebasestorage.app',
    measurementId: 'G-PHRT7CSV71',
  );

}