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
    apiKey: 'AIzaSyAyXP82NldHUMFPZS31PWlmyZJvMJuDgEA',
    appId: '1:1062436775546:web:9169bfa3c87f0605947dc3',
    messagingSenderId: '1062436775546',
    projectId: 'fir-flutter-codelab-d3e6f',
    authDomain: 'fir-flutter-codelab-d3e6f.firebaseapp.com',
    databaseURL: 'https://fir-flutter-codelab-d3e6f-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fir-flutter-codelab-d3e6f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9_QifnU0qvD2gD508npb3h4YEmw2vgOs',
    appId: '1:1062436775546:android:9ed49708e8e868b3947dc3',
    messagingSenderId: '1062436775546',
    projectId: 'fir-flutter-codelab-d3e6f',
    databaseURL: 'https://fir-flutter-codelab-d3e6f-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fir-flutter-codelab-d3e6f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1gw5cN71LwATzVTy8RqK11o_B-_Hqjn0',
    appId: '1:1062436775546:ios:c52216473a545596947dc3',
    messagingSenderId: '1062436775546',
    projectId: 'fir-flutter-codelab-d3e6f',
    databaseURL: 'https://fir-flutter-codelab-d3e6f-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fir-flutter-codelab-d3e6f.appspot.com',
    iosClientId: '1062436775546-fitghrqvaqsfkv3ug92pvmcl2fsr4ceb.apps.googleusercontent.com',
    iosBundleId: 'com.example.gtkFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB1gw5cN71LwATzVTy8RqK11o_B-_Hqjn0',
    appId: '1:1062436775546:ios:c52216473a545596947dc3',
    messagingSenderId: '1062436775546',
    projectId: 'fir-flutter-codelab-d3e6f',
    databaseURL: 'https://fir-flutter-codelab-d3e6f-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fir-flutter-codelab-d3e6f.appspot.com',
    iosClientId: '1062436775546-fitghrqvaqsfkv3ug92pvmcl2fsr4ceb.apps.googleusercontent.com',
    iosBundleId: 'com.example.gtkFlutter',
  );
}