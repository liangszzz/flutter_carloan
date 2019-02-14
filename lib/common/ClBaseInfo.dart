
///借款基本信息，还款信息Entity
class ClBaseInfo{
	
	///内单号
	String load_order_no;

	/// 商户订单号
	String biz_order_no;

	/// 订单状态：
	/// 19 等待审核, 20 审核中, 21 机审拒绝, 22 人工审核拒绝, 60 审核通过, 61 机构拒绝  , 62 放款失败, 64 还款中/放款成功, 68 已还清
	int order_status;

	/// 合同号
	String contract_no;

	/**
	 * 合作渠道
	 */
	String coop_channel;

	/// 借款用途
	 String borrow_usage;

	/// 放款日期
	 String load_date;

	/// 还款方式：1利随本清  2等额本息还款法
	 String repayment_method;

	/// 评估价格
	 double evaluation_car_price;

	/// 申请金额（分）
	 double apply_amount;

	/**
	 * 渠道贷款总额
	 */                       
	 double actual_amount;

	/// 年利率
	 double annual_interest_rate;

	/// 签约所在省
	 String signing_province;

	/// 签约所在市
	 String signing_city;

	/// 是否续期
	 String whether_renew;

	/// 抵押权人
	 String mortgagee;

	/// 借款人还款方式
	 String borrower_repayment_method;

	/// 期限，还款次数，整数
	 String repayment_terms;

	/// 月份：借款分几个月还
	 String repayment_times;

	/// 合同开始日期
	 String contract_start_date;

	/// 合同结束日期
	 String contract_end_date;

	/// 合同天数
	 String contract_due_days;

	/// 放款银行
	 String lenders_bank;

	/// 出款账户
	 String lenders_account;

	/// 放款状态
	 String lenders_status;

	/// 支付订单编号
	 String lenders_order_no;

	/// 机构名称
	 String institution_name;

	/// 机构所在省
	 String institution_province;

	/// 机构所在城市
	 String institution_city;

	/// 转账金额
	 double transfer_amount;

	/// 实际审批金额
	 double approve_amount;

	/// 产品名
	 String product_name;

	/// 产品明细
	 String product_details;

	/// 居间服务协议签约时间
	 String intermediary_service_agreement_signing_time;

	/// 居间服务协议查看地址
	 String intermediary_service_agreement_view_address;

	/// CA授权协议签约时间
	 String ca_license_protocol_signing_time;

	/// CA授权协议查看地址
	 String ca_license_protocol_view_address;

	/// 代扣协议签约时间
	 String withholding_agreement_signing_time;

	/// 代扣协议查看地址
	 String withholding_protocol_view_address;

	/// 线上标识：1.线上订单 0.线下订单
	 String on_line;

	/// 支付明细
	 String payment_details;

	/// 是否代付
	 String whether_paid;

	/// 是否代扣
	 String whether_deduct;

	/// 居间服务费金额
	 double intermediary_service_fee_amount;

	/// 对公开户行
	 String public_bank_name;

	/// 对公开户行公司名称
	 String public_bank_company_name;

	/// 对公开户行编号
	 String public_bank_no;

	/// 对公开户行卡号
	 String public_bank_account;

	/// 对公开户行省
	 String public_bank_province;

	/// 对公开户行市
	 String public_bank_city;


	 String create_by;
	 String create_date;
	 String audit_name;
	 String audit_date;

	/// 放款方式
	/// 0:微神马  1:自行放款
	 int loan_employers;

	/// 分公司名称
	 String branch_name;

	/// 车辆抵押登记时间
	 String car_pledge_register_date;

	 int wx_app_confirm;

	 String openid;

	 int channel_type;

	/// 0:未通过人脸识别
	/// 1：通过人脸识别
	 int video_faceliveness;




}