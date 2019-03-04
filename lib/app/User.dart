class User {
  ///真实姓名
  String userName;

  ///昵称
  String nickName;

  ///头像
  String avatarUrl;

  ///手机号
  String phone;

  ///身份证号
  String idCard;

  ///银行名称
  String bankName;

  ///银行卡号 后四位
  String barkCard;

  User.fromJson(Map<String, dynamic> map) {
    userName = map['userName'];
    nickName = map['nickName'];
    avatarUrl = map['avatarUrl'];
    phone = map['phone'];
    idCard = map['idcard'];
    bankName = map['bankName'];
    barkCard = map['barkCard'];
  }
}
