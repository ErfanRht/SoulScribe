import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  List entires = [];
  List<List<String>> entriesDates = [];
  List<List<String>> quotes = [];
  bool isFirstEnter = false;
  String userName = "";
  String userEmail = "";

  updateMainStete({
    bool? newFirstEnterStatus,
    String? newUserName,
    String? newUserEmail,
    List? newEntries,
    List<List<String>>? newEntriesDates,
    List<List<String>>? newQuotes,
  }) {
    isFirstEnter = newFirstEnterStatus ?? isFirstEnter;
    userName = newUserName ?? userName;
    userEmail = newUserEmail ?? userEmail;
    entires = newEntries ?? entires;
    entriesDates = newEntriesDates ?? entriesDates;
    quotes = newQuotes ?? quotes;

    update();
  }
}
