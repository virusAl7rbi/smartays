// ignore_for_file: unused_element

import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();
  static Future<bool> _canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  Future<bool> authenticateIsAvailable() async {
    final isAvailable = await _auth.canCheckBiometrics;
    final isDeviceSupported = await _auth.isDeviceSupported();
    print("#############################################################");
    print(isAvailable);
    print(isDeviceSupported);
    print("#############################################################");

    return isAvailable && isDeviceSupported;
  }

  static Future<bool> authenticate() async {
    try {
      if (!await _canAuthenticate()) return false;

      // ignore: prefer_const_constructors
      return await _auth.authenticate(
          localizedReason: 'to check in/out',
          options: AuthenticationOptions(
            //  useErrorDialogs: false,
            //   sensitiveTransaction: false,
            stickyAuth: true,
          ),
          authMessages: [AndroidAuthMessages(), IOSAuthMessages()]);
    } catch (e) {
      debugPrint('Local Auth error $e');
      return false;
    }
  }
}
