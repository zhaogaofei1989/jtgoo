package cn.jtgoo.cms.service;

import cn.jtgoo.cms.base.BaseDao;
import cn.jtgoo.cms.domain.User;

public interface UserService extends BaseDao<User> {
  
	/**
	 * 把指定用户的密码初始化为1234
	 * 
	 * @param id
	 */
	void initPassword(Long id);

	/**
	 * 获取用户
	 * @param loginName
	 * @return
	 */
	User getByLoginName(String loginName);

	/**
	 * 获取用户
	 * @param loginName
	 * @param password
	 * @return
	 */
	User getByLoginNameAndPassword(String loginName, String password);
	
	/**
	 * 通过user name 查询
	 * @param userName
	 * @return
	 */
	User findByName(String userName);
	

}
