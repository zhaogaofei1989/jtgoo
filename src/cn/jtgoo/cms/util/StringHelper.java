package cn.jtgoo.cms.util;

import java.lang.reflect.Field;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

/**
 * @author alex
 *反射字段
 */
public class StringHelper {

	public static void reflect(Object obj) {  
        if (obj == null) return;  
        Field[] fields = obj.getClass().getDeclaredFields();  
        for (int j = 0; j < fields.length; j++) {  
            fields[j].setAccessible(true);  
            // 字段名  

            // 字段值  
            if (fields[j].getType().getName().equals(  
                    java.lang.String.class.getName())) {  
                // String type  
                try {  
                    System.out.print(fields[j].get(obj));  
                    fields[j].setAccessible(true); 
                    
                    fields[j].set(fields[j], replace(fields[j].get(obj).toString()));
                    fields[j].setAccessible(false); 
                } catch (IllegalArgumentException e) {  
                    // TODO Auto-generated catch block  
                    e.printStackTrace();  
                } catch (IllegalAccessException e) {  
                    // TODO Auto-generated catch block  
                    e.printStackTrace();  
                }  
            } 
            // 其他类型。。。  
        }  
    }  
	
	
	/**
	 * 将所有的\r\n 替换成br 进行显示
	 * @param myString
	 * @return
	 */
	 public static String replace(String myString){  
		 String newString=null;  
		 if(StringUtils.isNotEmpty(myString))
		 {
		     Pattern CRLF = Pattern.compile("(\r\n|\r|\n|\n\r)");  
		        Matcher m = CRLF.matcher(myString);  
		        if (m.find()) {  
		          newString = m.replaceAll("<br/>");  
		          return newString;
		        }  
		 }
	        return myString;  
	    }  
	
}
