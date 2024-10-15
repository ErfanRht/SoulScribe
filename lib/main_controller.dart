import 'package:get/get.dart';

class MainController extends GetxController {
  List entires = [];
  List<List<String>> entriesDates = [];
  List<List<String>> quotes = [];
  bool isFirstEnter = false;
  bool isSamplesEnabled = false;
  String userName = "";
  String userEmail = "";
  String imageUrl = "";

  updateMainStete({
    bool? newFirstEnterStatus,
    String? newUserName,
    String? newUserEmail,
    String? newImageUrl,
    List? newEntries,
    List<List<String>>? newEntriesDates,
    List<List<String>>? newQuotes,
  }) {
    isFirstEnter = newFirstEnterStatus ?? isFirstEnter;
    userName = newUserName ?? userName;
    userEmail = newUserEmail ?? userEmail;
    imageUrl = newImageUrl ?? imageUrl;
    entires = newEntries ?? entires;
    entriesDates = newEntriesDates ?? entriesDates;
    quotes = newQuotes ?? quotes;

    update();
  }
}
