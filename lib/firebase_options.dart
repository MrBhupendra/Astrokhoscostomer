import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD0g8YgTmWxamh0Xioqry1uSn7bob3L4UE',
    appId: '1:945494063494:android:95e21a9207e5ee51309407',
    messagingSenderId: '945494063494',
    projectId: 'astrokhosh-app',
    databaseURL:
        'https://astrokhosh-app-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'astrokhosh-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3PYqx3-GAQNwBw_pdUX6PoY408ZYKfso',
    appId: '1:945494063494:ios:4e7e4162a2b1c99f309407',
    messagingSenderId: '945494063494',
    projectId: 'astrokhosh-app',
    databaseURL:
        'https://astrokhosh-app-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'astrokhosh-app.firebasestorage.app',
    iosBundleId: 'com.astrokhosh.customer.ios',
  );
}
