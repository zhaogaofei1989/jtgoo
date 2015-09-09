package cn.jtgoo.cms.base;

import java.util.List;

import cn.jtgoo.cms.util.HqlHelper;
import cn.jtgoo.cms.util.PageBean;

public interface BaseDao<T> {

	/**
	 * 保存
	 * 
	 * @param entity
	 */
	void save(T entity);

	/**
	 * 删除
	 * 
	 * @param id
	 */
	void delete(Long id);
	
	/**
	 * 删除
	 * 
	 * @param id
	 */
	void delete(Long[] ids);
	

	/**
	 * 更新
	 * 
	 * @param entity
	 */
	void update(T entity);

	/**
	 * 获取实体
	 * 
	 * @param id
	 * @return
	 */
	T getById(Long id);

	/**
	 * 获取实体
	 * 
	 * @param ids
	 * @return
	 */
	List<T> getByIds(Long[] ids);

	/**
	 * 查询所有
	 * 
	 * @return
	 */
	List<T> findAll();
	
	public void saveorupdate(T entity);
	
	/**
	 * 获取分页信息
	 * 
	 * @param hqlHelper HQL + 参数列表
	 * @param pageNum
	 * @return
	 */
	PageBean getPageBean(HqlHelper hqlHelper, int pageNum,int pageSize);
	
	/**按 状态查询，数据删除后，只是修改状态，并不是真正意义的物理删除
	 * @return
	 */
	public List<T> findAllByStatus() ;


}
