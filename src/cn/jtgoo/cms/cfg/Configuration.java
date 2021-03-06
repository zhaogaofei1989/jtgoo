package cn.jtgoo.cms.cfg;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLDecoder;
import java.util.Properties;

public class Configuration {
public static void main(String[] args) {
	
	
}
	private static Properties props = new Properties();

	public static boolean installed;
	private static int pageSize;

	// 加载 default.properties 配置文件，并初始化配置
	static {
		InputStream in = null;
		try {
			// 1，加载 default.properties 配置文件
			in = Configuration.class.getClassLoader().getResourceAsStream("default.properties");
			props.load(in);

			// 2，初始化配置
			installed = "true".equals(props.getProperty("installed"));
			pageSize = Integer.parseInt(props.getProperty("pageSize"));
			
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

	/**
	 * 保存配置到 default.properties 配置文件
	 */
	public static void store() {
		OutputStream out = null;
		try {
			// 1，设置最新状态的配置
			props.setProperty("installed", String.valueOf(installed));
			props.setProperty("pageSize", String.valueOf(pageSize));

			// 2，保存到文件
			URL url = Configuration.class.getClassLoader().getResource("default.properties");
			String path = URLDecoder.decode(url.getPath(), "utf-8");

			out = new FileOutputStream(path);
			props.store(out, "Itcast.Configuration");
		
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
					throw new RuntimeException(e);
				}
			}
		}
	}

	public static boolean isInstalled() {
		return installed;
	}

	public static void setInstalled(boolean installed) {
		Configuration.installed = installed;
	}

	public static int getPageSize() {
		return pageSize;
	}

	public static void setPageSize(int pageSize) {
		Configuration.pageSize = pageSize;
	}

}
