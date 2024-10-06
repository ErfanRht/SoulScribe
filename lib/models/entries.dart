import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soulscribe/main_controller.dart';
import 'package:soulscribe/pages/new_entry/controller.dart';

Future<bool> getEntries() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List entries = prefs.getStringList('entries') ?? [];
    int idCounter = 1;
    entries = entries.map((e) {
      List<String> entryParts = e.split("&&+-+-&&");
      entryParts.add(idCounter.toString());
      idCounter++;
      return entryParts;
    }).toList();
    Get.find<MainController>().updateMainStete(newEntries: entries);
    List<String> entriesDate = [];
    List<List<String>> entriesDate2 = [];
    for (int i = 0; i < entries.length; i++) {
      if (!entriesDate.contains(entries[i][2])) {
        entriesDate.add((entries[i][2]));
      }
    }
    entriesDate2 = entriesDate.map((e) => e.split("-")).toList();
    for (int i = 0; i < entriesDate2.length; i++) {
      entriesDate2[i].add(dateDifference(entriesDate2[i]).toString());
    }
    entriesDate2.sort((a, b) => int.parse(a[3]).compareTo(int.parse(b[3])));
    Get.find<MainController>().updateMainStete(newEntriesDates: entriesDate2);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> addEntry(
    {required String title,
    required String content,
    required DateTime dateTime}) async {
  try {
    if (title == "" || content == "") {
      return false;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> entries = prefs.getStringList('entries') ?? [];
      entries.add(
          "${title.replaceAll("&&+-+-&&", "")}&&+-+-&&${content.replaceAll("&&+-+-&&", "")}&&+-+-&&${dateTime.year}-${dateTime.month}-${dateTime.day}");
      prefs.setStringList('entries', entries);
      getEntries();
      return true;
    }
  } catch (e) {
    print(e);
    return false;
  }
}

Future<List<List<String>>> eachDayGetEntries(String date) async {
  List<List<String>> dayEntries = [];
  List entries = Get.find<MainController>().entires;
  for (int i = 0; i < entries.length; i++) {
    if (entries[i][2] == date) {
      dayEntries.add(entries[i]);
    }
  }
  return dayEntries;
}

dateTimeFormatter(List<String> date) {
  return DateTime(int.parse(date[0]), int.parse(date[1]), int.parse(date[2]));
}

dateDifference(List<String> date) {
  return dateTimeFormatter(date).difference(DateTime.now()).inDays.abs();
}

// Future<bool> updateTask({@required int index}) async {
//   try {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> tasks = prefs.getStringList('tasks') ?? [];
//     if (Get.find<MainController>().tasks[index][2] == "not-done") {
//       tasks[index] = tasks[index].replaceFirst("not-done", "done");
//     } else {
//       tasks[index] = tasks[index].replaceFirst("done", "not-done");
//     }
//     prefs.setStringList('tasks', tasks);
//     getTasks();
//     return true;
//   } catch (e) {
//     return false;
//   }
// }

Future<bool> removeEntry({required String index}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> finalEntries = [];
    List entries = Get.find<MainController>().entires;

    entries.removeAt(int.parse(index) - 1);

    finalEntries = entries.map((e) {
      List<String> entryParts = e;
      entryParts.removeLast();
      return entryParts.join("&&+-+-&&");
    }).toList();
    prefs.setStringList('entries', finalEntries);
    getEntries();
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

// Future<bool> removeAllTasks() async {
//   try {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('tasks');
//     getTasks();
//     return true;
//   } catch (e) {
//     return false;
//   }
// }