import 'package:get/get.dart';

class MainController extends GetxController {
  bool isFirstEnter = false;
  String userName = "";
  String userEmail = "";

  updateMainStete({
    bool? newFirstEnterStatus,
    String? newUserName,
    String? newUserEmail,
  }) {
    isFirstEnter = newFirstEnterStatus ?? isFirstEnter;
    userName = newUserName ?? userName;
    userEmail = newUserEmail ?? userEmail;

    update();
  }
}
