import 'package:flutter/material.dart';

import 'user-email.dart';
import 'user-name.dart';

Future<bool> UpdateUserData({String? name, String? email}) async {
  if (name != null && name != "") {
    setUserName(userName: name);
  }
  if (email != null && email != "") {
    setUserEmail(userEmail: email);
  }
  return true;
}
