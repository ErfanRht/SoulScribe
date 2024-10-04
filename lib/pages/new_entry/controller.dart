import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewEntryController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController journalController = TextEditingController();
  String id = "";
  int journalCharCount = 0;
  DateTime dateTime = DateTime.now();
  bool isEdit = false;

  updateNewEntryController(
      {int? newJournalCharCount,
      DateTime? newDateTime,
      bool? isBeingEdited,
      String? newId}) {
    journalCharCount = newJournalCharCount ?? journalCharCount;
    dateTime = newDateTime ?? dateTime;
    isEdit = isBeingEdited ?? isEdit;
    id = newId ?? id;

    update();
  }
}
