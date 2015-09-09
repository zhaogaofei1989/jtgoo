package cn.jtgoo.cms.util;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * @author  作者 zhaogaofei
 * @version  创建时间：May 25, 2015 3:20:37 PM
 * @email   zhaogaofei2012@163.com 
 * 类说明
 */
public class CustomerOcc {
	
	
	public static Map<String, String> getOccInfo()
	{
		
		Map<String, String> occuMap=new LinkedHashMap<String, String>();
		occuMap.put("1", "在职人员");
		occuMap.put("2", "退休人员");
		occuMap.put("3", "学生及未成年");
		occuMap.put("4","自由职业");
		occuMap.put("5", "不分职业");
		return occuMap;
	}

}
