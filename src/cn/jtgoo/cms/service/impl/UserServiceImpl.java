package cn.jtgoo.cms.service.impl;

import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;

import cn.jtgoo.cms.base.BaseDaoImpl;
import cn.jtgoo.cms.domain.User;
import cn.jtgoo.cms.param.Delstatus;
import cn.jtgoo.cms.service.UserService;

public class UserServiceImpl extends BaseDaoImpl<User> implements UserService {

	@Override
	public void save(User user) {
		// 设置密码为"1234"的MD5摘要
		String digest = DigestUtils.md5Hex("1234");
		user.setPassword(digest);

		getSession().save(user);
	}

	public void initPassword(Long id) {
		User user = (User) getSession().get(User.class, id);

		// 设置密码为"1234"的MD5摘要
		String digest = DigestUtils.md5Hex("1234");
		user.setPassword(digest);
		

		
		// 不需要update()，因为是持久状态
	}

	public User getByLoginName(String loginName) {
		return (User) getSession().createQuery(
				"FROM User u WHERE u.loginName=? and u.del_status=?")
				.setParameter(0, loginName)
				.setParameter(1, String.valueOf(Delstatus.ACTIVE.ordinal()))
				.uniqueResult();
	}

	public User getByLoginNameAndPassword(String loginName, String password) {
		// 要先进行摘要，再进行匹配
		String digest = DigestUtils.md5Hex(password);
		return (User) getSession().createQuery(//
				"FROM User u WHERE u.loginName=? AND u.password=?")//
				.setParameter(0, loginName)//
				.setParameter(1, digest)//
				.uniqueResult();
	}

	public User findByName(String userName) {
		return (User) getSession().createQuery(//
		"FROM User u WHERE u.userName=?")//
		.setParameter(0, userName)//
		.uniqueResult();
	}

	public void delete(Long id) {
		User user = (User) getSession().get(User.class, id);
		user.setDel_status(String.valueOf(Delstatus.DELETE.ordinal()));
		getSession().flush();
	}

	@Override
	public List<User> findAll() {
		return getSession().createQuery("FROM User as c where c.del_status=0").list();
	}


}