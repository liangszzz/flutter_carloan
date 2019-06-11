///签约代扣信息
class UserSign {
  String userName;
  String idCard;
  String reservePhone;
  String bankCard;
  String bankCode;
  int index;

  static List bankList=_getBankList();

  static List _getBankList() {
    List list = new List();
    list.add("中国工商银行");
    list.add("中国农业银行");
    list.add("中国银行");
    list.add("中国建设银行");
    list.add("中国交通银行");
    list.add("招商银行");
    list.add("中国邮政储蓄银行");
    list.add("中国民生银行");
    list.add("中国光大银行");
    list.add("兴业银行");
    list.add("中信银行");
    list.add("华夏银行");
    list.add("广发银行");
    list.add("北京银行");
    list.add("上海银行");
    list.add("平安银行");
    list.add("上海浦东发展银行");
    list.add("广州银行");
    list.add("渤海银行");
    list.add("浙商银行");
    return list;
  }

  UserSign.fromJson(Map<String, dynamic> map) {
    userName = map['user_name'];
    idCard = map['idcard'];
    reservePhone = map['reserve_phone_no'];
    bankCard = map['bank_card'];
    index = map['index'];
    bankCode = map['bank_code'];
//    bankNameList = map['bank_name_list'];
  }
}
