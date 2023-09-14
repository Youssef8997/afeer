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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBoVF1Bc7RlkM-XwFHgx0WqBhkxmAth_qA',
    appId: '1:164538397597:android:7916274ade863f070db574',
    messagingSenderId: '164538397597',
    projectId: 'afeer-2ea3a',
    databaseURL: 'https://afeer-2ea3a-default-rtdb.firebaseio.com',
    storageBucket: 'afeer-2ea3a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3ddg49hu_Kitq9XfNPx6zbravWhxhPiQ',
    appId: '1:164538397597:ios:90579f1a765ad82e0db574',
    messagingSenderId: '164538397597',
    projectId: 'afeer-2ea3a',
    databaseURL: 'https://afeer-2ea3a-default-rtdb.firebaseio.com',
    storageBucket: 'afeer-2ea3a.appspot.com',
    androidClientId: '164538397597-83qtruieno6hc8968fj6or1rv86l2ofd.apps.googleusercontent.com',
    iosClientId: '164538397597-hncruhhm0d1gidbis7hgq9gtgj6i2gco.apps.googleusercontent.com',
    iosBundleId: 'afer.yoyo.com.afeer',
  );
}