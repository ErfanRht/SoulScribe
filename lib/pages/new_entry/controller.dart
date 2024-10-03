import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewEntryController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController journalController = TextEditingController();
  int journalCharCount = 0;
  DateTime dateTime = DateTime.now();

  updateNewEntryController({int? newJournalCharCount, DateTime? newDateTime}) {
    journalCharCount = newJournalCharCount ?? journalCharCount;
    dateTime = newDateTime ?? dateTime;

    update();
  }
}
