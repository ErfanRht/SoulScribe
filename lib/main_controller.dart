import 'package:get/get.dart';

class MainController extends GetxController {
  List entires = [];
  bool isFirstEnter = false;
  String userName = "";
  String userEmail = "";

  updateMainStete(
      {bool? newFirstEnterStatus,
      String? newUserName,
      String? newUserEmail,
      List? newEntries}) {
    isFirstEnter = newFirstEnterStatus ?? isFirstEnter;
    userName = newUserName ?? userName;
    userEmail = newUserEmail ?? userEmail;
    entires = newEntries ?? entires;

    update();
  }
}
