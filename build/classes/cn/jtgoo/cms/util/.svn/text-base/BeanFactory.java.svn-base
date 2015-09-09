package cn.jtgoo.cms.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.struts.chain.commands.util.ClassUtils;

public class BeanFactory {

	private static Properties props = new Properties();

	static {
		// 1，读取配置文件，只需要一次
		InputStream in = BeanFactory.class.getClassLoader().getResourceAsStream("BeanFactory.properties");
		try {
			props.load(in);
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
					throw new RuntimeException(e);
				}
			}
		}

	}

	// /**
	// * 获取指定接口对应的实现类实例
	// *
	// * @param key
	// * 接口的简单名称
	// * @return
	// */
	// public static Object getImpl(String key) {
	// try {
	// // 2，获取key对应的value，就是实现类的全限定名
	// String className = props.getProperty(key);
	//
	// // 3，生成实例并返回
	// return Class.forName(className).newInstance();
	//
	// } catch (Exception e) {
	// throw new RuntimeException(e);
	// }
	// }

	/**
	 * 获取指定接口对应的实现类实例
	 * 
	 * @param key
	 * @return
	 */
	public static <T> T getImpl(Class<T> clazz) {
		try {
			// 2，获取key对应的value，就是实现类的全限定名
			String key = clazz.getSimpleName(); // key是接口的简单名称
			String className = props.getProperty(key);

			// 3，生成实例并返回
			return (T) Class.forName(className).newInstance();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}
