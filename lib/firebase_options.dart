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
    apiKey: 'AIzaSyD1RG7zhaDQ0CVp594ExPfc_UHeyaPZK9E',
    appId: '1:412354226846:web:ca50e733018b7e575ae98f',
    messagingSenderId: '412354226846',
    projectId: 'doctor-app-48bd7',
    authDomain: 'doctor-app-48bd7.firebaseapp.com',
    storageBucket: 'doctor-app-48bd7.firebasestorage.app',
    measurementId: 'G-MYGK61CDFN',
  );

  // Run: flutterfire configure

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChpO5VsH5m94SPdLvAhxIYXFWl4WG5SlM',
    appId: '1:412354226846:android:a1d973b7426351745ae98f',
    messagingSenderId: '412354226846',
    projectId: 'doctor-app-48bd7',
    storageBucket: 'doctor-app-48bd7.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDL0Ytv3ppnh8WCBI7xUwNBbAg4EqMKY_I',
    appId: '1:412354226846:ios:d883c40e094886be5ae98f',
    messagingSenderId: '412354226846',
    projectId: 'doctor-app-48bd7',
    storageBucket: 'doctor-app-48bd7.firebasestorage.app',
    iosBundleId: 'com.example.docAppSw',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDL0Ytv3ppnh8WCBI7xUwNBbAg4EqMKY_I',
    appId: '1:412354226846:ios:d883c40e094886be5ae98f',
    messagingSenderId: '412354226846',
    projectId: 'doctor-app-48bd7',
    storageBucket: 'doctor-app-48bd7.firebasestorage.app',
    iosBundleId: 'com.example.docAppSw',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD1RG7zhaDQ0CVp594ExPfc_UHeyaPZK9E',
    appId: '1:412354226846:web:a7f3456f9874f4365ae98f',
    messagingSenderId: '412354226846',
    projectId: 'doctor-app-48bd7',
    authDomain: 'doctor-app-48bd7.firebaseapp.com',
    storageBucket: 'doctor-app-48bd7.firebasestorage.app',
    measurementId: 'G-GE64R903VL',
  );

}