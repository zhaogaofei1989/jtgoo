package cn.jtgoo.cms.util;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 用于辅助生成HQL与参数列表的
 * 
 * @author tyg
 * 
 */
public class HqlHelper {
	private String selectClause; // Select子句
	private String fromClause; // From子句
	private String whereClause; // Where子句
	private String orderClause; // Order子句
	private String betweenClause; // betweenClause子句
	private String inClause; // inClause子句

	private List<Object> paramList = new ArrayList<Object>();
	private Map<String,Object> paramMap = new LinkedHashMap<String, Object>();

	/**
	 * 生成From子句
	 * 
	 * @param clazz
	 */
	public HqlHelper(Class clazz) {
		fromClause = "FROM " + clazz.getName();
	}

	/**
	 * 生成From子句，使用指定的别名
	 * 
	 * @param clazz
	 * @param alias
	 */
	public HqlHelper(Class clazz, String alias) {
		fromClause = " FROM " + clazz.getName() + " " + alias;
	}

	public HqlHelper(String sql) {
		fromClause = sql ;
	}

	/**
	 * 拼接Select子句
	 * 
	 * @param propertyName
	 */
	public HqlHelper addSelectProperty(String propertyName) {
		if (selectClause == null) {
			selectClause = "SELECT DISTINCT " + propertyName;
		} else {
			selectClause += ", " + propertyName;
		}
		
		return this;
	}

	/**
	 * 特殊处理,适用于parent is null类型
	 * @param condition
	 * @return
	 */
	public HqlHelper addWhereParent(String condition) {
		whereClause = " WHERE " + condition;
		return this;
		
	}
	
	/**
	 * 多对象联合查询
	 * @param condition
	 * @return
	 */
	public HqlHelper appedObj(String hql) {
		fromClause =fromClause + hql;
		return this;
		
	}
	/**
	 * 拼接Where子句
	 * 
	 * @param condition
	 * @param paramValues
	 * @return
	 */
	public HqlHelper addWhereCondition(String condition, Object  paramValues) {
		
		if(paramValues!=null&&paramValues.toString().length()>0)
		{
//			System.out.println(String.valueOf(paramValues[0]).length());
		if (whereClause == null) {
			whereClause = " WHERE " + condition;
			
		} else {
			whereClause += " AND " + condition;
		}
		//如果包涵in 字段，拼接语句,IN_PARAM
		if(condition.indexOf("in(")>-1)
		{
			whereClause=whereClause+" "+paramValues;
			return this;
		}
		if (paramValues != null ) {

			paramList.add(paramValues);
			paramMap.put(condition, paramValues);
			
		}
		}
		return this;
	}

	/**
	 * 拼接Order子句
	 * 
	 * @param propertyName
	 * @param isAsc
	 */
	public HqlHelper addOrderProperty(String propertyName, boolean isAsc) {
		if (orderClause == null) {
			orderClause = " ORDER BY " + propertyName + (isAsc ? " ASC" : " DESC");
		} else {
			orderClause += ", " + propertyName + (isAsc ? " ASC" : " DESC");
		}
		return this;
	}

	public HqlHelper addBetween (String sqlpre,String start,String end) {
		if (whereClause == null) {
			if(start!=null&&start.trim().length()>0)
			{
				betweenClause=" WHERE "+sqlpre+" BETWEEN '"+start+"' AND '"+end+"'";
			}
		}
		
		return this;
	}

	/**
	 * 获取查询数据列表的HQL语句
	 * 
	 * @return
	 */
	public String getQueryListHql() {
		StringBuffer hql = new StringBuffer();

		// 1，Select子句
		if (selectClause != null) {
			hql.append(selectClause);
		}

		// 2，Form子句
		hql.append(fromClause);

		// 3，Where子句
		if (whereClause != null) {
			hql.append(whereClause);
		}
		
		// 4，Order子句
		if (betweenClause != null) {
			hql.append(betweenClause);
		}

		// 4，Order子句
		if (orderClause != null) {
			hql.append(orderClause);
		}
		return hql.toString();
	}

	/**
	 * 获取查询总记录数的HQL语句（没有Order子句）
	 * 
	 * @return
	 */
	public String getQueryCountHql() {
		StringBuffer hql = new StringBuffer();

		// 1，Select子句
		if (selectClause == null) {
			hql.append("SELECT COUNT(*) ");
		} else {
			// SELECT DISTINCT id,name --> SELECT COUNT(DISTINCT id,name)
			hql.append("SELECT COUNT(" + selectClause.substring("SELECT ".length()) + ") ");
		}

		// 2，Form子句
		hql.append(fromClause);

		// 3，Where子句
		if (whereClause != null) {
			hql.append(whereClause);
		}
		// 4，Order子句
		if (betweenClause != null) {
			hql.append(betweenClause);
		}

		// 不需要Order子句

		return hql.toString();
	}

	/**
	 * 获取参数列表
	 * 
	 * @return
	 */
	public List<Object> getParamList() {
		return paramList;
	}
	
	public Map<String, Object> getParamMap() {
		return paramMap;
	}

	public void setWhereClause(String whereClause) {
		this.whereClause = whereClause;
	}

	public String getWhereClause() {
		return whereClause;
	}

}
