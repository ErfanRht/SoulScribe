import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soulscribe/main_controller.dart';

Future<bool> getEntries() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List entries = prefs.getStringList('entries') ?? [];
    entries = entries.map((e) => e.split("&&+-+-&&")).toList();
    Get.find<MainController>().updateMainStete(newEntries: entries);
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> addEntry(
    {required String title,
    required String content,
    required DateTime dateTime}) async {
  try {
    print(title);
    if (title == "" || content == "") {
      return false;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> entries = prefs.getStringList('entries') ?? [];
      entries.add(
          "${title.replaceAll("&&+-+-&&", "")}&&+-+-&&${content.replaceAll("&&+-+-&&", "")}&&+-+-&&$dateTime");
      print("entries: $entries");
      prefs.setStringList('entries', entries);
      getEntries();
      return true;
    }
  } catch (e) {
    return false;
  }
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

// Future<bool> removeTask({@required int index}) async {
//   try {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> tasks = prefs.getStringList('tasks') ?? [];
//     tasks.removeAt(index);
//     prefs.setStringList('tasks', tasks);
//     getTasks();
//     return true;
//   } catch (e) {
//     return false;
//   }
// }

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