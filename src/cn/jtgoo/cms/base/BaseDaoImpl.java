package cn.jtgoo.cms.base;

import java.lang.reflect.ParameterizedType;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.Session;

import cn.jtgoo.cms.util.HibernateUtils;
import cn.jtgoo.cms.util.HqlHelper;
import cn.jtgoo.cms.util.PageBean;

@SuppressWarnings("unchecked")
public class BaseDaoImpl<T> {

	protected Class<T> clazz;

	public BaseDaoImpl() {
		ParameterizedType pt = (ParameterizedType) this.getClass()
				.getGenericSuperclass();
		this.clazz = (Class) pt.getActualTypeArguments()[0];
		System.out.println("clazz = " + clazz);
	}

	public void save(T entity) {
		getSession().save(entity);
		getSession().flush();
	}

	public void delete(Long id) {
		Object obj = getSession().get(clazz, id);
		getSession().delete(obj);
		getSession().flush();
	}

	public void update(T entity) {
		getSession().update(entity);
		getSession().flush();
	}

	public void saveorupdate(T entity) {
		getSession().saveOrUpdate(entity);
	}

	public T getById(Long id) {
		return (T) getSession().get(clazz, id);
	}

	public List<T> getByIds(Long[] ids) {
		if (ids == null || ids.length == 0) {
			return Collections.EMPTY_LIST;
		}
		return getSession().createQuery("FROM " + clazz.getName() + " WHERE id in (:ids)").setParameterList("ids", ids).list();
	}

	public void delete(Long[] ids) {
		for(int i=0;i<ids.length;i++)
		{
			Object obj = getSession().get(clazz, ids[i]);
			getSession().delete(obj);
		}
		getSession().flush();
	}

	public List<T> findAll() {
		return getSession().createQuery("FROM " + clazz.getName()).list();
	}
	public List<T> findAllByStatus() {
		return getSession().createQuery("FROM " + clazz.getName()+" as c where c.del_status=0").list();
	}

	/**
	 * 获取当前可用的Session
	 * 
	 * @return
	 */
	protected Session getSession() {
		// return HibernateUtils.getCurrentSession();
		Session session = HibernateUtils.getCurrentSession();
		if (session == null) {
			// 第一次调用，就打开一个新的Session并关联当前线程
			session = HibernateUtils.openSession();
			session.beginTransaction(); // 开始事务
		}
		return session;
	}

	public PageBean getPageBean(HqlHelper hqlHelper, int pageNum, int pageSize) {
		// int pageSize = Configuration.getPageSize(); // 每页显示多少条记录
		List<Object> params = hqlHelper.getParamList();
		Map<String, Object> paramsMap=hqlHelper.getParamMap();
		System.out.println(paramsMap);
		// 查询指定页的数据列表
		Query listQuery = getSession().createQuery(hqlHelper.getQueryListHql());
		for (int i = 0; i < params.size(); i++) { // 设置参数
			int len = params.size() - 1;
			Object obj = (Object) params.get(i);
			if (i == len && obj instanceof ArrayList) {
				listQuery.setParameterList("alist", (ArrayList) obj);
			} else if (i == len && params.get(i) instanceof Object[]) {
				listQuery.setParameterList("alist", (Object[]) params.get(i));
			} else {
				listQuery.setParameter(i, params.get(i));
			}
		}
		listQuery.setFirstResult((pageNum - 1) * pageSize);
		listQuery.setMaxResults(pageSize);
		List recordList = listQuery.list();
		System.out.println(listQuery.getQueryString());
		// 查询总记录数
		Query countQuery = getSession().createQuery(
				hqlHelper.getQueryCountHql());
		for (int i = 0; i < params.size(); i++) { // 设置参数
			int len = params.size() - 1;
			Object obj = (Object) params.get(i);
			if (i == len && obj instanceof ArrayList) {
				countQuery.setParameterList("alist", (ArrayList) obj);
			} else {
				countQuery.setParameter(i, params.get(i));
			}
		}
		int recordCount = ((Number) countQuery.uniqueResult()).intValue();

		return new PageBean(pageNum, pageSize, recordCount, recordList);
	}

}
