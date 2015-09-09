package cn.jtgoo.cms.util;


import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import jxl.Workbook;
import jxl.format.UnderlineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

/**
 * 传入各个属性并将数据写入excel
 * 通用报表格式
 * 修改内容：修改条件显示的格式，由原来的一行显示两个条件信息修改为一行显示一个条件信息，使报表看起来更直观，更简洁
 *
 */
public class ExportUtils {
	private String title="报表";//标题
	private String[] header;//表头
	private String[] f_name;//条件名称
	private String[] f_value;//条件值
	private boolean isVerticalFreeze=true;//是否需要对行进行窗口冻结（默认不冻结）
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		List<String[]> list=new ArrayList<String[]>();
		list.add(new String[]{"2013-05-12","user1","user1登入了系统"});
		list.add(new String[]{"2013-05-13","user2","user2登入了系统"});
		list.add(new String[]{"2013-05-14","user3","user3登入了系统"});
		ExportUtils deh=new ExportUtils();
		
		deh.setTitle("订单报表");//添加报表标题
		String[] title={"操作时间","操作人员","操作内容"};
		deh.setHeader(title);
		//添加报表的查询字段名称
//		String[] fname={"开始时间","结束时间","操作用户"};
//		deh.setF_name(fname);//没有查询字段则直接赋值null
		//添加报表的查询字段值
//		String[] fvalue={"2012-01-03","2012-01-11","admin","2013-05-06"};
//		deh.setF_value(fvalue);//没有查询字段则直接赋值null
		deh.setIsVerticalFreeze(true);//是否对header进行冻结，让表头随着滚动条而滚动。默认：false
//		boolean bool=deh.write(list,"c:\\workOrder.xls");//第一个参数：数据集合；第二个参数：存储路径（我这里是本地路径），如果是在servlet中则是：request.getSession().getServletContext().getRealPath("/")+"项目中的文件夹名字/workOrder.xls";
//		System.out.println(bool);
	
	}
	
	
	
	/**
	 *<br>方法说明：写入文件操作
	 *<br>输入参数：数据和输出路径
	 *<br>返回类型：boolean
	 */
	  public boolean write(List<String[]> list,String path,String fileName){
		  boolean bool=true;
	    try{
	    	File file=new File(path);
	    	if(!file.exists())
	    	{
	    		file.mkdir();
	    	}
	    	File excel=new File(path+fileName);
	    	  int lenght=5;
		      //根据表头的长度来确认合并单元格添加标题
		       if(this.getHeader()!=null && this.getHeader().length>0){
		    	   lenght=this.getHeader().length;
		       }else{//判断文件表头是否存在
		    	   System.out.println("缺少文件表头");
		    		return false;
		       }
	        //创建一个可写入的excel文件对象
	        WritableWorkbook workbook = Workbook.createWorkbook(excel); 
	        //使用第一张工作表，将其命名为“操作记录日志”
	        WritableSheet sheet = workbook.createSheet("sheet", 0);
	      
	      //去掉整个sheet中的网格线 
	        sheet.getSettings().setShowGridLines(true);     
	   
	      //定义标题单元格样式
	        WritableCellFormat wcf_title = this.getTitle_Font();
	      //定义条件单元格样式
	        WritableCellFormat wcf_filter = this.getFilter_Font();
	      //定义表头单元格样式
	        WritableCellFormat wcf_head = this.getHeader_Font();  
	      //定义表格内容单元格样式
	        WritableCellFormat wcf_table = this.getTable_Font();  
	        wcf_table.setWrap(true);
	      //左边单元格的样式
	        WritableCellFormat wcf_leftCell = this.getLeftCell_Font();
	       int line_num=0;//从第1行开始放数据
	      //根据表头的长度来确认合并单元格添加标题
	        sheet.mergeCells(0, line_num, lenght, line_num);//合并第line_num行的地1到this.getHeader().length个单元格
	        Label label = new Label(0, line_num, this.getTitle(),wcf_title); 
	        sheet.addCell(label); 
	        
	        //放查询条件的名称和值
	        line_num+=2;//从第几行开始放条件
	        if(this.getF_name()!=null){
	        	//String content="";
	        	for(int i=0;i<this.getF_name().length;i++){
	        		Label fn_label = new Label(1, line_num, this.getF_name()[i]+":",wcf_leftCell); 
    		        sheet.addCell(fn_label); 
	        		sheet.mergeCells(2, line_num, 4, line_num);//合并第line_num行的地1到5个单元格
	        		Label fv_label = new Label(2, line_num,this.getF_value()[i],wcf_filter); 
    		        sheet.addCell(fv_label); 
    		        line_num++;
	        	}
	        }
	      //添加报表生产日期
	        Label reportDate_label=new Label(1,line_num,"报表日期：",wcf_leftCell);
	        sheet.addCell(reportDate_label);
	        sheet.mergeCells(2, line_num, 4, line_num);//合并第line_num行的第2到5个单元格
    		Label reportDate_value = new Label(2, line_num,new SimpleDateFormat("yyyy-MM-dd").format(new Date()),wcf_filter); 
	        sheet.addCell(reportDate_value);
	        
	        //表头
	        String[] header=this.getHeader();
	        line_num++;//从另一行开始添加表头数据
	        for(int i=0;i<header.length;i++){
	        	Label title_label = new Label(i, line_num, header[i],wcf_head); 
		        sheet.addCell(title_label); 
		        sheet.setColumnView(i, 20); //设置列的高度
	        }
	        line_num++;//从另一行开始添加数据
	      //是否需要从表头开始对行进行冻结
	        if(this.getIsVerticalFreeze()){
	        	sheet.getSettings().setVerticalFreeze(line_num);
	        }
	        
	      //如果list是null或者没有数据
	        if(list!=null && list.size()>0){
	        for(int i=0;i<list.size();i++){
	        	String[] content=(String[])list.get(i);
	        	for(int j=0;j<content.length;j++){
	        			//普通字符
	        	        Label labelCFC = new Label(j, line_num, content[j],wcf_table); 
	        	        sheet.addCell(labelCFC); 
	        	}
	        	line_num++;
	        }
	        }
	        //关闭对象，释放资源
	        workbook.write(); 
	        workbook.close(); 

	    }catch(Exception e){
	    	bool=false;
	     e.printStackTrace();
	    }
	    return bool;
	  }

	  /**
	   * 定义标题单元格样式 
	   * @return
	   * @throws WriteException
	   */
	  public WritableCellFormat getTitle_Font() throws WriteException{	   
	          //单元格样式 
	        WritableFont wf_title = new WritableFont(WritableFont.ARIAL, 20,  
	                WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,  
	                jxl.format.Colour.BLACK); // 定义格式 字体 下划线 斜体 粗体 颜色  
	        WritableCellFormat wcf_title = new WritableCellFormat(wf_title); // 单元格定义  
	       // wcf_title.setBackground(jxl.format.Colour.BLACK); // 设置单元格的背景颜色  
	        wcf_title.setAlignment(jxl.format.Alignment.CENTRE); // 设置对齐方式  
	        
	        return wcf_title;
	    
	  }
	  /**
	   * 定义条件单元格样式 
	   * @return
	   * @throws WriteException
	   */
	  public WritableCellFormat getFilter_Font() throws WriteException{	   
	          //单元格样式 
	        WritableFont wf_filter = new WritableFont(WritableFont.ARIAL, 10,  
	                WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,  
	                jxl.format.Colour.BLACK); // 定义格式 字体 下划线 斜体 粗体 颜色  
	        WritableCellFormat wcf_filter = new WritableCellFormat(wf_filter); // 单元格定义  
	        //wcf_filter.setBackground(jxl.format.Colour.BLACK); // 设置单元格的背景颜色  
	        wcf_filter.setAlignment(jxl.format.Alignment.LEFT); // 设置对齐方式  
	        return wcf_filter;
	    
	  }
	  /**
	   * 表头单元格样式
	   * @return
	   * @throws WriteException
	   */
	  public WritableCellFormat getHeader_Font() throws WriteException{
		//单元格样式 
	        WritableFont wf_head = new WritableFont(WritableFont.ARIAL, 14,  
	                WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,  
	                jxl.format.Colour.GREEN); // 定义格式 字体 下划线 斜体 粗体 颜色  
	        
	        WritableCellFormat wcf_head = new WritableCellFormat(wf_head); // 单元格定义    
	        //wcf_head.setBackground(jxl.format.Colour.BLACK);  // 设置单元格的背景颜色   
	        wcf_head.setAlignment(jxl.format.Alignment.CENTRE); // 设置对齐方式    
	        return wcf_head;
	       
	  }
	  /**
	   * 表格内容单元格样式
	   * @return
	   * @throws WriteException
	   */
	  public WritableCellFormat getTable_Font() throws WriteException{
			//单元格样式 
	        WritableFont wf_table = new WritableFont(WritableFont.ARIAL, 10,  
	                WritableFont.NO_BOLD, false, UnderlineStyle.NO_UNDERLINE,  
	                jxl.format.Colour.BLACK); // 定义格式 字体 下划线 斜体 粗体 颜色  
	        WritableCellFormat wcf_table = new WritableCellFormat(wf_table);  // 单元格定义 
	        //wcf_table.setBackground(jxl.format.Colour.BLACK);// 设置单元格的背景颜色     
	        wcf_table.setAlignment(jxl.format.Alignment.CENTRE);// 设置对齐方式 
	        return wcf_table;
	  }
 
	  /**
	   * 左边单元格的样式
	   * @return
	   * @throws WriteException
	   */
	  public WritableCellFormat getLeftCell_Font() throws WriteException{
			//单元格样式 
	        WritableFont wf_table = new WritableFont(WritableFont.ARIAL, 10,  
	                WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,  
	                jxl.format.Colour.BLACK); // 定义格式 字体 下划线 斜体 粗体 颜色  
	        WritableCellFormat wcf_table = new WritableCellFormat(wf_table);  // 单元格定义 
	        wcf_table.setAlignment(jxl.format.Alignment.LEFT);// 设置对齐方式 
	        return wcf_table;
	  }



	public String getTitle() {
		return title;
	}


	/**
	 * 添加标题
	 * @param title
	 */
	public void setTitle(String title) {
		this.title = title;
	}


	
	public String[] getHeader() {
		return header;
	}

	/**
	 *  添加表头
	 * @param header
	 */
	public void setHeader(String[] header) {
		this.header = header;
	}

	public String[] getF_name() {
		return f_name;
	}

	/**
	 * 增加查询条件名
	 * @param f_name
	 */
	public void setF_name(String[] f_name) {
		this.f_name = f_name;
	}

	public String[] getF_value() {
		return f_value;
	}

	/**
	 * 增加查询条件值
	 * @param f_value
	 */
	public void setF_value(String[] f_value) {
		this.f_value = f_value;
	}

	
	public boolean getIsVerticalFreeze() {
		return isVerticalFreeze;
	}
	/**
	 * 是否需要从表头开始对行进行窗口冻结(默认false)
	 * @return
	 */
	public void setIsVerticalFreeze(boolean isVerticalFreeze) {
		this.isVerticalFreeze = isVerticalFreeze;
	}


	

}
