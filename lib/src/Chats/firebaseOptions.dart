import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebaseOptions.dart';
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
    apiKey: "AIzaSyAhxVpyahVBDaWgVqJWuYkWLdCz437F0Uk",
    appId: "1:858999482242:web:6c75f82e11aae23c12919b",
    messagingSenderId: "858999482242",
    projectId: "junglegym-cd7fd",
    authDomain: "junglegym-cd7fd.firebaseapp.com",
    storageBucket: "junglegym-cd7fd.appspot.com",
    databaseURL: "https://junglegym-cd7fd-default-rtdb.asia-southeast1.firebasedatabase.app",
      measurementId: "G-YKNCMN35R7"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyCP2LhUWFcR5qTRgni_bjFm56MjTRjhaDU",
    appId: "1:858999482242:android:e37a09219a99149a12919b",
    messagingSenderId: "858999482242",
    projectId: "junglegym-cd7fd",
    storageBucket: "junglegym-cd7fd.appspot.com",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    storageBucket: '',
    iosClientId: '',
    iosBundleId: '',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    storageBucket: '',
    iosClientId: '',
    iosBundleId: '',
  );
}