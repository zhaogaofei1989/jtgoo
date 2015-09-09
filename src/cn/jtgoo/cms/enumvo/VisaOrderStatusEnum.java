package cn.jtgoo.cms.enumvo;


/**
 * @author Administrator
 *签证订单状态类型
 statusList.add(new ObjInfo("0","未审核"));
 statusList.add(new ObjInfo("1","已预定"));
 statusList.add(new ObjInfo("2","已收到材料"));
 statusList.add(new ObjInfo("3","已审核材料"));
 statusList.add(new ObjInfo("4","已预约"));
 statusList.add(new ObjInfo("5","已面试/送签"));
 statusList.add(new ObjInfo("6","已出签"));
 statusList.add(new ObjInfo("7","已寄回"));
 statusList.add(new ObjInfo("8","已完成"));
 statusList.add(new ObjInfo("9","已付款"));
 *
 */
public enum VisaOrderStatusEnum {
	//未审核
	NON_CHECKED,
	//已预订
	RESERVED,
	//收到材料
	RECEIVED_MATERIAL,
	//审核材料
	APPLIED_MATERIAL,
	//已预约
	APPOINTMENT,
	//已面试
	HAVA_AN_INTERVIEW,
	//已出签
	GOT_THE_VISA,
	//已寄回
	SENT_BACK,
	//已完成
	FINISHED,
	//已付款
	ACCOUNT_PAID,

}
