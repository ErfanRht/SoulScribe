import 'dart:convert';
import 'dart:io';

import 'package:cli_util/cli_logging.dart';
import 'package:fhir_yaml/fhir_yaml.dart';
import 'package:http/http.dart' as http;
import 'package:yaml/yaml.dart';

part 'model.dart';

void main(List<String> args) async {
  final _illustrations = _updateIllustrations(await _getIllustrations());
  final _enumList = _getEnuns(_illustrations);
  final _baseUrl =
      'https://42f2671d685f51e10fc6-b9fcecea3e50b3b59bdc28dead054ebc.ssl.cf5.rackcdn.com/illustrations';
  final _identifierAndUrl = _getIdentifierAndUrl(_illustrations);
  await _updateFile(_enumList, _baseUrl, _identifierAndUrl);

  logger.stdout('Formatting file');
  await Process.run(
      'dart', ['format', '--fix', '.\\lib\\illustrations.g.dart']);
  logger.stdout('File formatted');

  if (args.contains('--publish') && await _hasChanges()) {
    await _updateLibraryVersion();
    await _commitChanges();
    await _pushingChanges();
    await _updateLibrary();
  }
}

List<IllustrationElement> _updateIllustrations(
    List<IllustrationElement> illustrations) {
  illustrations.sort((ia, ib) => ia.title.compareTo(ib.title));

  Map<String, List<IllustrationElement>> titleMap = {};
  for (var illustration in illustrations) {
    if (!titleMap.containsKey(illustration.title)) {
      titleMap[illustration.title] = [];
    }
    titleMap[illustration.title]!.add(illustration);
  }

  for (var title in titleMap.keys) {
    if (titleMap[title]!.length >= 2) {
      titleMap[title]![1].title = titleMap[title]![1].title + "_var";
    }
  }

  return titleMap.values.expand((element) => element).toList();
}

Future<bool> _hasChanges() async {
  var gitStatusOutput = await Process.run('git', ['status']);
  return !gitStatusOutput.stdout
      .toString()
      .contains('nothing to commit, working tree clean');
}

_updateLibraryVersion() async {
  final pubspec = File('./pubspec.yaml');
  var doc = Map<String, dynamic>.from(loadYaml(await pubspec.readAsString()));
  doc['version'] = (doc['version'] as String).split('+')[0] +
      '+' +
      (int.parse((doc['version'] as String).split('+')[1]) + 1).toString();
  pubspec.writeAsString(json2yaml(doc));
  final changelog = File('./changelog.md');
  var list = await changelog.readAsLines();
  changelog.writeAsString([
    list.removeAt(0),
    ...[
      '',
      '## [${doc['version']}] - ${DateTime.now().toIso8601String().split('T')[0]}',
      '',
      '* More illustrations added or updated',
    ],
    ...list
  ].join('\n'));
}

_updateLibrary() async {
  var process = await Process.start(
    'pub.bat',
    ['publish'],
  );
  process.stdout.listen((event) {
    if (event.contains('Do you want to publish ms_undraw')) {
      process.stdin.write('y');
      process.stdin.writeln();
    }
  });
}

_pushingChanges() async {
  var process = await Process.start(
    'git',
    ['push', 'origin', 'master'],
  );

  process.stdout.listen((event) {
    if (event.contains('Enter passphrase for')) {
      process.stdin.write(Platform.environment['GIT_PASSWORD']);
      process.stdin.writeln();
    }
  });
}

_commitChanges() async {
  await Process.run(
    'git',
    ['commit', '-a', '-m', 'update undraw illustrations'],
  );
}

Logger logger = Logger.standard();
final _startNum = RegExp(r"^\d");

List<String> _getEnuns(List<IllustrationElement> illustrations) {
  logger.stdout('Transforming enums');

  final list = (illustrations..sort((ia, ib) => ia.title.compareTo(ib.title)))
      .map((illustration) {
    return '''
/// Title: ${illustration.title}
/// <br/>
/// <img src="${illustration.image}" alt="${illustration.title}" width="200"/>
${_kebabCase(illustration.title)}''';
  }).toList();

  logger.stdout('Enums transformed');
  return list;
}

List<String> _getIdentifierAndUrl(List<IllustrationElement> illustrations) {
  logger.stdout('Transforming illustrations');
  final list = illustrations
      .map((ill) =>
          "UnDrawIllustration.${_kebabCase(ill.title)}: '\$baseUrl/${ill.image.split('/').last}'")
      .toList();
  logger.stdout('Illustrations transformed');
  return list;
}

Future<List<IllustrationElement>> _getIllustrations() async {
  logger.stdout('Downloading undraw illustration list');
  var _isEnd = false;
  var _page = 0;
  List<IllustrationElement> _illustrations = [];
  do {
    logger.write('Downloading page $_page\r');
    final http.Response response = await http
        .get(Uri.parse("https://undraw.co/api/illustrations?page=$_page"));
    final illustrations = Illustration.fromMap(jsonDecode(response.body));
    _isEnd = illustrations.hasMore!;
    _page = illustrations.nextPage!;
    _illustrations.addAll(illustrations.illustrations!);
  } while (_isEnd);
  logger.stdout('Downloading page $_page');
  logger.stdout('${_illustrations.length} undraw illustration list downloaded');

  return _illustrations;
}

String _kebabCase(String value) => value
    .toLowerCase()
    .trim()
    .replaceAll(' ', '_')
    .replaceAll('-', '_')
    .replaceAllMapped(_startNum, (match) => '_${match.group(0)}')
    .replaceFirst('void', 'void_');

Future _updateFile(
    List<String> enuns, String baseUrl, List<String> identifierAndUrl) async {
  logger.stdout('Writing in file');
  final File _illustrations = File('./lib/illustrations.g.dart');
  final content = '''
// ignore_for_file: unused_field
/// Enums to help locate the correct illustration
enum UnDrawIllustration {${enuns.join(',')}}

/// Base url for the illustrations
const baseUrl = "$baseUrl";

/// Map of illustrations with url to download
const illustrationMap = const <UnDrawIllustration, String>{
  ${identifierAndUrl.join(',')}
};

''';
  if (!await _illustrations.exists())
    await _illustrations.create(recursive: true);
  await _illustrations.writeAsString(content,
      encoding: Encoding.getByName('utf-8')!);
  logger.stdout('File writed');
}
