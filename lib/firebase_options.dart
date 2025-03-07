// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB5IIxIbWMn3gwqYOtv_IRjb-roQSfpAUc',
    appId: '1:1011022334480:web:2af696a948c8eab2e25895',
    messagingSenderId: '1011022334480',
    projectId: 'swine-care',
    authDomain: 'swine-care.firebaseapp.com',
    storageBucket: 'swine-care.firebasestorage.app',
    measurementId: 'G-SNVLQF5E1D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCpsauI2BDsuy8cqh4fISWC8mOtEgsgrTg',
    appId: '1:1011022334480:android:690ba91ca4309dbee25895',
    messagingSenderId: '1011022334480',
    projectId: 'swine-care',
    storageBucket: 'swine-care.firebasestorage.app',
  );
}
