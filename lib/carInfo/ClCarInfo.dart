
/// 车辆信息Entity
class ClCarInfo {

	/// 内单号
	 String load_order_no;

	/// 商户订单号
	 String biz_order_no;

	/// 车牌号
	 String car_no;

	/// 车辆品牌
	 String car_brand;

	/// 车辆型号
	 String car_model;

	/// 车颜色
	 String car_color;

	/// 车架号
	 String car_frame_no;

	/// 车发动机号
	 String car_engine_no;

	/// 车辆行驶里程
	 String car_driving_mileage;

	/// 车辆使用年限
	 String car_service_life;

	/// 是否有过重大事故
	/// 0:否  1：是
	 String major_accident;

	/// 事故类型：
	/// 0.无 1.水淹车 2.事故车 3.盗抢车
	 String accident_type;

	 int channel_type;

  ClCarInfo.fromJson(Map<String, dynamic> dataMap) {

		biz_order_no = dataMap['biz_order_no'];
		car_no = dataMap['car_no'];
		car_brand = dataMap['car_brand'];
		car_color = dataMap['car_color'];
		car_driving_mileage = dataMap['car_driving_mileage'];
		car_engine_no = dataMap['car_engine_no'];
		car_model = dataMap['car_model'];
		car_service_life = dataMap['car_service_life'];
		accident_type = dataMap['accident_type'];
		car_frame_no = dataMap['car_frame_no'];
		major_accident = dataMap['major_accident'];
	}
}