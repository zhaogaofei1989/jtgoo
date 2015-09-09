package cn.jtgoo.cms.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import cn.jtgoo.cms.domain.Country;
import cn.jtgoo.cms.domain.Department;

public class DepartmentUtils {

	/**
	 * 遍历出所有的部门，按顺序放到同一个集合中，并修改名称以表示层次
	 * 
	 * @param topList
	 * @return
	 */
	public static List<Department> getAllDepartmentList(List<Department> topList) {
		List<Department> list = new ArrayList<Department>();
		walkDepartmentTrees(topList, "", list);
		return list;
	}
	
	private static void walkDepartmentTrees(Collection<Department> topList, String prefix, List<Department> list) {
		for (Department top : topList) {
			// 顶点
			Department copy = new Department(); // 使用副本，因为原对象是持久状态
			copy.setId(top.getId());
			copy.setName(prefix + "┣" + top.getName());
			list.add(copy);
			
			// 子树
			walkDepartmentTrees(top.getChildren(), prefix + "　", list);
		}
	}
	/**
	 * 遍历出所有的部门，按顺序放到同一个集合中，并修改名称以表示层次
	 * 
	 * @param topList
	 * @return
	 */
	public static List<Country> getAllCountryList(List<Country> topList) {
		List<Country> list = new ArrayList<Country>();
		walkCountryTrees(topList, "", list);
		return list;
	}

	private static void walkCountryTrees(Collection<Country> topList, String prefix, List<Country> list) {
		for (Country top : topList) {
			// 顶点
			Country copy = new Country(); // 使用副本，因为原对象是持久状态
			copy.setId(top.getId());
			copy.setName(prefix + "┣" + top.getName());
			if(top.getParent()!=null)
			{
				copy.setIsparent(false);
			}
			list.add(copy);
			// 子树
			walkCountryTrees(top.getCoutryChild(), prefix + "　", list);
		}
	}

	/**
	 * 从集合中移除指定的部门及其子孙部门
	 * 
	 * @param departmentList
	 * @param department
	 */
	public static void removeDeparmentAndChildren(List<Department> departmentList, Department department) {
		departmentList.remove(department);
		System.out.println("--------> 已移除元素：" + department.getName());
		for (Department child : department.getChildren()) {
			removeDeparmentAndChildren(departmentList, child);
		}
	}
	/**
	 * 从集合中移除指定的部门及其子孙部门
	 * 
	 * @param departmentList
	 * @param department
	 */
	public static void removeCountryAndChildren(List<Country> countrytList, Country country) {
		countrytList.remove(country);
		for (Country child : country.getCoutryChild()) {
			removeCountryAndChildren(countrytList, child);
		}
	}
	
	
	

	public static List<Country> orderList(List<Country> countrytList) {
		/**
		 * 查找当前页面有几个根部
		 * 如果有一个，然后通过根部进行排序
		 */
		List<Country> top=new ArrayList<Country>();
		for (Country country : countrytList) {
			if(country.getParent()==null)
			{
				top.add(country);
			}
			
		}
		return top;
	}
}
