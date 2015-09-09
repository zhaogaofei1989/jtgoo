package cn.jtgoo.cms.param;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Properties;

public class Param {
	private static Properties properties;
	/**
	 * 存储路径
	 */
	public static String upload_filepath="";
	/**
	 * 存储目录
	 */
	public static final String product="product/";
	public static final String country="country/";
	
	
	public static final String excelPath="excel/";
	
	

	/**
	 * 签证产品前缀
	 */
	
	public static final String visaProductPre="VISA";
	
	static {
		InputStream inputStream = null;
		try {
			inputStream = Param.class.getClassLoader().getResourceAsStream("default.properties");
			properties = new Properties();
			properties.load(inputStream);
			upload_filepath = properties.getProperty("upload_filepath");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (inputStream != null) {
				try {
					inputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	
	
public static Map<String,String> getOccuType()
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
	
	
