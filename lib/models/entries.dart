import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soulscribe/constants/data.dart';
import 'package:soulscribe/main_controller.dart';

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
    checkSamples();
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> addEntry(
    {required String title,
    required String content,
    required DateTime dateTime,
    bool isSample = false}) async {
  try {
    if (title == "" || content == "") {
      return false;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> entries = prefs.getStringList('entries') ?? [];
      entries.add(
          "${title.replaceAll("&&+-+-&&", "")}&&+-+-&&${content.replaceAll("&&+-+-&&", "")}&&+-+-&&${dateTime.year}-${dateTime.month}-${dateTime.day}&&+-+-&&${isSample ? "isSample" : "isNotSample"}");
      prefs.setStringList('entries', entries);
      getEntries();
      return true;
    }
  } catch (e) {
    print(e);
    return false;
  }
}

List<List<String>> eachDayGetEntries(String date) {
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

Future<bool> checkSamples() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool("samples") == null) {
    prefs.setBool("samples", false);
  }
  Get.find<MainController>().isSamplesEnabled =
      prefs.getBool("samples") ?? false;
  return prefs.getBool("samples") ?? false;
}

Future<bool> enableSampleEntries() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  for (List<String> entry in sampleEntries) {
    addEntry(
        title: entry[0],
        content: entry[1],
        isSample: true,
        dateTime: dateTimeFormatter(entry[2].split("-").toList()));
  }
  prefs.setBool("samples", true);
  return true;
}

Future<bool> disableSampleEntries() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> finalEntries = [];
  List entries = Get.find<MainController>().entires;
  for (int i = entries.length - 1; i >= 0; i--) {
    var entry = entries[i];
    if (entry[3] == "isSample") {
      entries.removeAt(int.parse(entry[4]) - 1);
    }
  }

  finalEntries = entries.map((e) {
    List<String> entryParts = e;
    entryParts.removeLast();
    return entryParts.join("&&+-+-&&");
  }).toList();
  prefs.setStringList('entries', finalEntries);
  prefs.setBool("samples", false);
  getEntries();
  return true;
}
