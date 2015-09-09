package cn.jtgoo.cms.util;

import javax.servlet.http.HttpServletRequest;

public class PathUtils {

	
	public static void main(String[] args) {
		System.out.println(getRootPath());
	}
	
	   /**  
     * TODO 获取根目录  
     * @return  
     * @author <a href="mailto:pheh.lin@gmail.com">PHeH</a><br>  
     * Created On 2007-5-10 15:16:21  
     */  
    public static String getRootPath(){   
        //因为类名为"Application"，因此" Application.class"一定能找到   
        String result = PathUtils.class.getResource("PathUtils.class").toString();   
        int index = result.indexOf("WEB-INF");   
        if(index == -1){   
            index = result.indexOf("bin");   
        }   
        result = result.substring(0,index);   
        if(result.startsWith("jar")){   
            // 当class文件在jar文件中时，返回"jar:file:/F:/ ..."样的路径    
            result = result.substring(10);   
        }else if(result.startsWith("file")){   
            // 当class文件在class文件中时，返回"file:/F:/ ..."样的路径    
            result = result.substring(6);   
        }   
        if(result.endsWith("/"))result = result.substring(0,result.length()-1);//不包含最后的"/"   
        return result;   
    }  
 
}
