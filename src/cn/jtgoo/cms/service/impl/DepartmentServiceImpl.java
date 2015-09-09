package cn.jtgoo.cms.service.impl;

import java.util.List;

import cn.jtgoo.cms.base.BaseDaoImpl;
import cn.jtgoo.cms.domain.Department;
import cn.jtgoo.cms.param.Delstatus;
import cn.jtgoo.cms.service.DepartmentService;

public class DepartmentServiceImpl extends BaseDaoImpl<Department> implements DepartmentService {

	@SuppressWarnings("unchecked")
	public List<Department> findTopLevel() {
		return getSession().createQuery(//
				"FROM Department d WHERE d.parent IS NULL AND d.del_status="+Delstatus.ACTIVE.ordinal())//
				.list();
	}
	public void delete(Long id) {
		Department department = (Department) getSession().get(Department.class, id);
		department.setDel_status(String.valueOf(Delstatus.DELETE.ordinal()));
		getSession().flush();
	}

	
}
