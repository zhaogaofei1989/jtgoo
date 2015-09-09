package cn.jtgoo.cms.domain;

import java.util.HashSet;
import java.util.Set;


/**
 * 用户
 * 
 * @author zhaogaofei
 * 资料类别设置
 */
@SuppressWarnings("serial")
public class DataType implements java.io.Serializable {
	private Long id;
	
/**
 * 分类名称
 */
	private String name;
	/**
	 * 分类描述  代表分类所管辖的地方
	 */
	
	private String description;
	
	
	/**
	 * 与datatypedeil 是一对多的
	 * @return
	 */
	private Set<DataTypeDetail> dataTypeDetailSet=new HashSet<DataTypeDetail>();
	/**
	 * 删除状态 0 代表 未删除，1代表删除
	 */
	private String del_status="0";
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Set<DataTypeDetail> getDataTypeDetailSet() {
		return dataTypeDetailSet;
	}
	public void setDataTypeDetailSet(Set<DataTypeDetail> dataTypeDetailSet) {
		this.dataTypeDetailSet = dataTypeDetailSet;
	}
	public String getDel_status() {
		return del_status;
	}
	public void setDel_status(String del_status) {
		this.del_status = del_status;
	}


}
