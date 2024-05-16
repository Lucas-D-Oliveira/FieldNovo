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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAGwW684uLO3iAvOwy72b7iAi7JUCRpg28',
    appId: '1:780430676071:web:00a9aefef5401cd34544c2',
    messagingSenderId: '780430676071',
    projectId: 'testecampo-4aaaa',
    authDomain: 'testecampo-4aaaa.firebaseapp.com',
    databaseURL: 'https://testecampo-4aaaa-default-rtdb.firebaseio.com',
    storageBucket: 'testecampo-4aaaa.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB81gK6OuaWHQlgzfKhOWIBOAFmEe-1u7M',
    appId: '1:780430676071:android:b16940234711ffed4544c2',
    messagingSenderId: '780430676071',
    projectId: 'testecampo-4aaaa',
    databaseURL: 'https://testecampo-4aaaa-default-rtdb.firebaseio.com',
    storageBucket: 'testecampo-4aaaa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBG5YFoNRFdSDvtqHPJuLKyQGLx7enrees',
    appId: '1:780430676071:ios:215194310098c7a14544c2',
    messagingSenderId: '780430676071',
    projectId: 'testecampo-4aaaa',
    databaseURL: 'https://testecampo-4aaaa-default-rtdb.firebaseio.com',
    storageBucket: 'testecampo-4aaaa.appspot.com',
    iosBundleId: 'com.example.fieldTeste',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBG5YFoNRFdSDvtqHPJuLKyQGLx7enrees',
    appId: '1:780430676071:ios:215194310098c7a14544c2',
    messagingSenderId: '780430676071',
    projectId: 'testecampo-4aaaa',
    databaseURL: 'https://testecampo-4aaaa-default-rtdb.firebaseio.com',
    storageBucket: 'testecampo-4aaaa.appspot.com',
    iosBundleId: 'com.example.fieldTeste',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAGwW684uLO3iAvOwy72b7iAi7JUCRpg28',
    appId: '1:780430676071:web:32f113669d28d5d94544c2',
    messagingSenderId: '780430676071',
    projectId: 'testecampo-4aaaa',
    authDomain: 'testecampo-4aaaa.firebaseapp.com',
    databaseURL: 'https://testecampo-4aaaa-default-rtdb.firebaseio.com',
    storageBucket: 'testecampo-4aaaa.appspot.com',
  );
}