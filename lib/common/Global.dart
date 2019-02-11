import 'package:flutter_carloan/common/Token.dart';
import 'package:flutter_carloan/common/User.dart';

///全局共享信息
class Global {
  
  Token token;

  User user;

  factory Global() => _getInstance();

  static Global _instance;

  Global._internal() {}

  static Global _getInstance() {
    if (_instance == null) {
      _instance = new Global._internal();
    }
    return _instance;
  }
}
