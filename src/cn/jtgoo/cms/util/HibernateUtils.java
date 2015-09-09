package cn.jtgoo.cms.util;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtils {
	private static SessionFactory sessionFactory;
	// private static Map<Thread, Session> sessionMap = new Hashtable<Thread, Session>();
	private static ThreadLocal<Session> threadLocal = new ThreadLocal<Session>();

	static {
		sessionFactory = new Configuration().configure().buildSessionFactory();
	}

	// /**
	// * 获取当前线程对应的Session，如果没有，就创建一个Session，并与当前线程关联
	// */
	// public static Session getCurrentSession() {
	// Session session = threadLocal.get(); // sessionMap.get(Thread.currentThread());
	// if (session == null) {
	// session = sessionFactory.openSession();
	// threadLocal.set(session); // sessionMap.put(Thread.currentThread(), session);
	// }
	// return session;
	// }

	/**
	 * 创建一个Session，并与当前线程关联
	 */
	public static Session openSession() {
		Session session = sessionFactory.openSession();
		threadLocal.set(session); // sessionMap.put(Thread.currentThread(), session);
		return session;
	}

	/**
	 * 获取当前线程对应的Session，如果没有，就返回null
	 */
	public static Session getCurrentSession() {
		return threadLocal.get(); // sessionMap.get(Thread.currentThread());
	}

	/**
	 * 关闭当前线程对应的Session，并移除与当前线程的关联
	 */
	public static void closeCurrentSession() {
		Session session = threadLocal.get(); // sessionMap.get(Thread.currentThread());
		session.close();
		threadLocal.remove();// sessionMap.remove(Thread.currentThread());
	}
}