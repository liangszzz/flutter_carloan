import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class FileUtil {
  String path;

  FileUtil(this.path);

  Future<String> read() async {
    var appDocDir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$appDocDir/$path');
    if (await file.exists()) {
      return file.readAsStringSync();
    }
    return null;
  }

  void write(String str) async {
    var appDocDir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$appDocDir/$path');
    file.writeAsStringSync(str, mode: FileMode.write);
  }
}
