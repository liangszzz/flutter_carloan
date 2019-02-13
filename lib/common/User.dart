class User {
  ///昵称
  String nickName;

  ///头像
  String avatarUrl;

  ///手机号
  String phone;

  ///身份证号
  String idcard;

  ///银行名称
  String bankName;

  ///银行卡号 后四位
  String barkCard;

  User.fromJson(Map<String, String> map) {
    nickName = map['nickName'];
    avatarUrl = map['avatarUrl'];
    phone = map['phone'];
    idcard = map['idcard'];
    bankName = map['bankName'];
    barkCard = map['barkCard'];
  }
}
