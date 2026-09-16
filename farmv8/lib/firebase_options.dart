// File generated manually based on Firebase Console configuration.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        // Note: Android requires google-services.json in android/app/
        // These values are placeholders until Android app is fully registered.
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBeF-T8fpCis6YHie1es5shXYTNYOGV2Ig',
    appId: '1:131698588163:web:9301e62192ae9ca331ac36',
    messagingSenderId: '131698588163',
    projectId: 'agri-grow-eb3da',
    authDomain: 'agri-grow-eb3da.firebaseapp.com',
    storageBucket: 'agri-grow-eb3da.firebasestorage.app',
    measurementId: 'G-0K2STRSRJQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAX4q2SHTaFl7RfDxFa3jw82Qq9aAdW1EI',
    appId: '1:131698588163:android:07d04cbf8a93daa231ac36',
    messagingSenderId: '131698588163',
    projectId: 'agri-grow-eb3da',
    storageBucket: 'agri-grow-eb3da.firebasestorage.app',
  );
}
