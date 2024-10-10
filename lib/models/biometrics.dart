import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> doesDeviceSupportBiometrics() async {
  final LocalAuthentication auth = LocalAuthentication();
  final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
  final bool canAuthenticate =
      canAuthenticateWithBiometrics || await auth.isDeviceSupported();
  return canAuthenticate;
}

Future<bool> authenticateWithBiometricsStatus({bool? status}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (status != null) {
    prefs.setBool("fingerprint_auth", status);
    return status;
  } else {
    return prefs.getBool("fingerprint_auth") ?? false;
  }
}
