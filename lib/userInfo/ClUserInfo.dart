/// 用户信息
class ClUserInfo {
  ///内单号
  String load_order_no;

  ///商户订单号
  String biz_order_no;

  ///借款人姓名
  String user_name;

  /// 性别
  String gender;

  /// 证件地址
  String idcard_address;

  /// 身份证号码
  String idcard;

  /// 手机号
  String phone_no;

  /// 身份类型：1.在职 2.在读 3.待业
  String identity_type;

  /// 身份证照片
  String idcard_photo_path;

  /// 健康状况：1.健康 2.良好 3.一般 4.较弱
  String health_status;

  /// 最高学历 1博士研究生 2硕士研究生 3大学本科 4大学专科和专科学校 5中等专业学校或中等技术学校 6技术学院 7高中 8初中 9小学 10其他 默认为其他
  String degree;

  /// 【身份类型】是2时该项必填
  String colleges;

  /// 【身份类型】是2时该项必填
  String major;

  /// 居住地址
  String residential_address;

  /// 婚姻状况 1未婚 2已婚 3丧偶 4离婚
  String marital_status;

  /// 公司名称
  String company_name;

  /// 分公司名称
  String branch_name;

  /// 公司电话
  String company_phone_no;

  /// 公司地址
  String company_address;

  /// 银行卡号
  String bank_account;

  /// 银行卡类型：1.借记卡 2.信用卡
  String bank_card_type;

  /// 预留手机号
  String reserve_phone_no;

  /// 开户行
  String bank_name;

  /// 个人总收入（元/月）
  double personal_income;

  /// 月均总支出（元/月）
  String monthly_expenditure;

  /// qq号码
  String qq;

  /// 微信号
  String wechat;

  /// 开户行所在省
  String bank_province;

  /// 开户行所在市
  String bank_city;

  /// 支行名称
  String bank_sub_branch_name;

  /// 银行编号
  String bank_code;

  /// 客户职业信息
  /// 1、各类专业，技术人员
  /// 2、国家机关，党群组织，企事业单位
  /// 3、办事人员和有关人员
  /// 4、商业工作人员
  /// 5、服务性工作人员
  /// 6、农林牧渔劳动者
  /// 7、生产工作，运输工作和部分体力
  /// 8、不便分类的其他劳动者
  String customer_professional_info;

  /// 证件到期日
  String certificate_expiry_date;

  int channel_type;

  ClUserInfo.fromJson(Map<String, dynamic> map) {

      bank_code = map['bank_code'];
      customer_professional_info = map['customer_professional_info'];
      channel_type = map['channel_type'];
      certificate_expiry_date = map['certificate_expiry_date'];

      monthly_expenditure = map['monthly_expenditure'];
      qq = map['qq'];
      wechat = map['wechat'];
      bank_province = map['bank_province'];
      bank_city = map['bank_city'];
      bank_sub_branch_name = map['bank_sub_branch_name'];

      company_address = map['company_address'];
      bank_account = map['bank_account'];
      bank_card_type = map['bank_card_type'];
      reserve_phone_no = map['reserve_phone_no'];
      bank_name = map['bank_name'];
      personal_income = map['personal_income'];

      load_order_no = map['load_order_no'];
      biz_order_no = map['biz_order_no'];
      user_name = map['user_name'];
      gender = map['gender'];
      idcard_address = map['idcard_address'];
      idcard = map['idcard'];
      phone_no = map['phone_no'];
      identity_type = map['identity_type'];
      idcard_photo_path = map['idcard_photo_path'];
      health_status = map['health_status'];
      degree = map['degree'];
      colleges = map['colleges'];
      major = map['major'];
      residential_address = map['residential_address'];
      marital_status = map['marital_status'];
      company_name = map['company_name'];
      branch_name = map['branch_name'];
      company_phone_no = map['company_phone_no'];


  }
}
