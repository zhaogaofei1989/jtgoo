package cn.jtgoo.cms.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.StringUtils;

import cn.jtgoo.cms.param.Param;
import cn.jtgoo.cms.util.JdbcUtils;
import cn.jtgoo.cms.util.UploadFileUtils;

public class UploadFileServlet extends HttpServlet {
	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		//最大尺寸 不设限
		long maxSize = -1;
		//缓存大小 1MB
		int cacheSize = 1 * 1024 * 1024;
//		BufferedInputStream in = null;
//		BufferedOutputStream out = null;
//		long st = System.currentTimeMillis();
		//初始化上传文件的临时存放目录
		//File tempDir = new File(uploadTempPath);
		//记录文件大小
		long count = 0;
     	String id=uploadMethod(request, maxSize, cacheSize, count);
		out.println(id);
		out.close();
	}
	private String uploadMethod(HttpServletRequest request, long maxSize,
			int cacheSize, long count) {
		 String attachmentId="";
		 String attId=request.getParameter("attchmentId");
	String orderId=request.getParameter("orderId");
		 System.out.println(request.getParameter("attchmentId"));
		 System.out.println(request.getParameterMap());
		 System.out.println(request.getParameterNames());
		 int tempId=0;
		try {
			
			//检查表单中是否有文件
			boolean isMultipart = ServletFileUpload.isMultipartContent(request);

			if (isMultipart) {
				//创建磁盘工厂，利用构造器实现内存数据储存量和临时储存路径  
				DiskFileItemFactory factory = new DiskFileItemFactory();

				//指定在内存中缓存数据大小,单位为byte,这里设为1Mb  
				factory.setSizeThreshold(cacheSize);

				//设置一旦文件大小超过getSizeThreshold()的值时数据存放在硬盘的目录  
				//factory.setRepository(tempDir);

				ServletFileUpload sfu = new ServletFileUpload(factory);

				sfu.setFileSizeMax(maxSize);

				//指定一次上传多个文件的总尺寸,单位:字节，这里不设限
				sfu.setSizeMax(-1);

				//设置编码，页面的编码是utf-8
				sfu.setHeaderEncoding("UTF-8");

				//解析request请求 
				FileItemIterator fii = sfu.getItemIterator(request);
				//设置上传的目录

				while (fii.hasNext()) {
					//从集合中获得一个文件流 
					FileItemStream fis = fii.next();
					//过滤掉表单中非文件域
					if (!fis.isFormField() && fis.getName().length() > 0) {
						//如果 attchmentId="" 证明没有上传过资料,就添加新记录
						//如果 attchmentId!=null  证明已经存在附件，就删除当前附件，更新附件路径
						String path=UploadFileUtils.saveUploadFile(request, fis);
					
						if(StringUtils.isEmpty(attId))
						{
						 tempId=JdbcUtils.addAttment(orderId,fis.getName(),path.replaceAll("\\\\", "/"),request.getParameter("type"));
						 attachmentId= String.valueOf(tempId);
						}
						else
						{
						
						String oldPath=JdbcUtils.updateAttment(attId,fis.getName(),path.replaceAll("\\\\", "/"),request.getParameter("type"));
							//更新后，原来的文件
							if(StringUtils.isNotEmpty(oldPath))
							{
								File oldFile=new File(Param.upload_filepath+oldPath);
								if(oldFile.exists())
								{
									oldFile.delete();
								}
							}
						attachmentId=attId;
						}
					}
				}
			}
			
		} 
		catch (Exception e) {
			e.printStackTrace();
}
		return attachmentId;
	}
}