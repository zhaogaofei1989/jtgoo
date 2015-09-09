package cn.jtgoo.cms.util;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

public class NumberFormatTools {
	
	public static void main(String[] args) {
		System.out.println(getCurrentDay2());
	}
	/**
	 * @param String类型的数字   如"150"
	 * @param 格式化格式  ，如“00000”
	 * @return 格式化后的字符串
	 */
	public static String formatNumber(String str, String formatAs) {
		DecimalFormat df = new DecimalFormat(formatAs);
		String str2 = df.format(Integer.parseInt(str));
		return str2;
	}

	/**
	 * @param int数字   如150
	 * @param 格式化格式  ，如“00000”
	 * @return 格式化后的字符串
	 */
	public static String formatNumber(int num, String formatAs) {
		DecimalFormat df = new DecimalFormat(formatAs);
		String str2 = df.format(num);
		return str2;
	}

	/**
	 * dateformat
	 */

	public static String getCurrentTime() {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return df.format(System.currentTimeMillis());
	}

	/**
	 * 获取时间 当天
	 * @return
	 */
	public static String getCurrentDay() {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		return df.format(new Date());
	}
	public static String getCurrentDay2() {
		DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		return df.format(new Date());
	}
	/**
	 * 计算间隔天机
	 * @return
	 * str1 为
	 * @throws ParseException 
	 */
	public static long the_interval(String str1,String str2)  {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		System.out.println(str1);
		System.out.println(str2);
		   long days =0;
		try {
			Date d1 = df.parse(str1);
		    Date d2 = df.parse(str2);
		    long diff = d1.getTime() - d2.getTime();
		     days = diff / (1000 * 60 * 60 * 24);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return days;
	}
	/**字符数组转换为长整型数组
	 * @param values
	 * @return
	 */
	public static Long[] converToLong(String[] values) { //如果values不为空，且values的长度大于0的话，才进行转换操作
		Long[] longs = null;

		if (values != null && values.length > 0) {
			longs = new Long[values.length]; //声明long类型的数组
			//循环遍历string里面的数组，并将String数组里面的内容赋值给long数组
			for (int i = 0; i < values.length; i++) {
				String str = values[i];
				long lg = Long.valueOf(str);
				longs[i] = lg;
			}
		}
		return longs;
	}
	/**字符数组转换为长整型数组
	 * @param values
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List<String> arrayconverToList(String[] values) { //如果values不为空，且values的长度大于0的话，才进行转换操作
		List<String> list =null;

		if (values != null && values.length > 0) {
			list=new ArrayList();
			//循环遍历string里面的数组，并将String数组里面的内容赋值给long数组
			for (int i = 0; i < values.length; i++) {
				list.add(values[i]);
			}
		}
		return list;
	}

	public static Integer[] arrayconverToIntegerarray(String[] values) { //如果values不为空，且values的长度大于0的话，才进行转换操作
		Integer[]  tempLong =new Integer[values.length];
		
		if (values != null && values.length > 0) {
			//循环遍历string里面的数组，并将String数组里面的内容赋值给long数组
			for (int i = 0; i < values.length; i++) {
				tempLong[i]=Integer.valueOf(values[i]);
			}
		}
		return tempLong;
	}
	public static Long[] arrayconverToLongarray(String[] values) { //如果values不为空，且values的长度大于0的话，才进行转换操作
		Long[]  tempLong =new Long[values.length];
		if (values != null && values.length > 0) {
			//循环遍历string里面的数组，并将String数组里面的内容赋值给long数组
			for (int i = 0; i < values.length; i++) {
				tempLong[i]=Long.valueOf(values[i]);
			}
		}
		return tempLong;
	}

	
	public static List<String> arrayconverToStringList(String[] values) { //如果values不为空，且values的长度大于0的话，才进行转换操作
		List<String> list =null;
		if (values != null && values.length > 0) {
			list=new ArrayList();
			for (int i = 0; i < values.length; i++) {
				list.add(values[i]);
			}
		}
		return list;
	}
	//将数组转为带有小括号的 字符串 作为查询条件
	public static String convertListToString(List<String> list)
	{
		if(list!=null&&list.size()>0)
		{
		String strBuf="";
		for(String str:list)
		{
			if(StringUtils.isNotEmpty(str))
			{
			strBuf=strBuf+str+",";
			}
		}
		System.out.println(strBuf.substring(0, strBuf.length()-1)+")");
		return strBuf.substring(0, strBuf.length()-1);	
		}
		return "";
	}
}
