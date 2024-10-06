import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:soulscribe/main_controller.dart';

Future<void> fetchQuotes(List<String>? tags) async {
  tags = tags ??
      [
        "Change",
        "Future",
        "Happiness",
        "Inspirational",
        "Motivational",
      ];
  HttpOverrides.global = MyHttpOverrides();
  List<List<String>> quotes = [];
  final response = await http.get(Uri.parse(
      'https://api.quotable.io/quotes/random?tags=${tags.join('|')}&limit=50&maxLength=140'));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    var quoteResults = data;

    for (var quote in quoteResults) {
      quotes.add([quote['content'], quote['author']]);
    }
    quotes.shuffle();

    Get.find<MainController>().updateMainStete(newQuotes: quotes);
  } else {
    print('Failed to fetch data');
  }
}

Future<void> reloadQuotes() async {
  List<List<String>> quotes = Get.find<MainController>().quotes;
  Get.find<MainController>().updateMainStete(newQuotes: []);
  await Future.delayed(const Duration(milliseconds: 1500));
  quotes.shuffle();
  Get.find<MainController>().updateMainStete(newQuotes: quotes);
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
