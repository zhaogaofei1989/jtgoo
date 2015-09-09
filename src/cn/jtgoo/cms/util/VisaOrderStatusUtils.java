package cn.jtgoo.cms.util;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public class VisaOrderStatusUtils {
	public static void visaStatus(HttpServletRequest request) {
		List<ObjInfo> statusList=new ArrayList<ObjInfo>();
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
		request.setAttribute("statusList", statusList);
	}
	
}
