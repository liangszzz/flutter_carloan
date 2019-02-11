import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class FileUtil {
  String path;

  FileUtil(this.path);

  Future<String> read() async {
    var appDocDir = (await getApplicationDocumentsDirectory()).path;
    print(appDocDir);
    File file = new File('$appDocDir/$path');
    return file.readAsStringSync();
  }

  void write(String str) async {
    var appDocDir = (await getApplicationDocumentsDirectory()).path;
    print(appDocDir);
    File file = new File('$appDocDir/$path');
    file.writeAsStringSync(str);
  }
}
