/// 联系人实体
/// create by shenhq on 2018/11/5.
/// @author shenhq
class ClContactInfo {
  /// 外键
  String loadOrderNo;

  /// 内键
  String bizOrderNo;

  /// 联系人姓名
  String contactName;

  /// 联系人手机号码
  String contactPhone;

  /// 联系人关系
  String contactRelationship;

 /* ClContactInfo.fromJson(Map<String, dynamic> map) {
    bizOrderNo = map['biz_order_no'];
    contactName = map['contact_name'];
    contactPhone = map['contact_phone'];
    contactRelationship = map['contact_relationship'];
  }*/
}
