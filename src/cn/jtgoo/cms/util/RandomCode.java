package cn.jtgoo.cms.util;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class RandomCode extends HttpServlet {

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int number = 0;
		int max = 0;
		response.setContentType("image/jpeg");
		ImageCode image = new ImageCode();
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		try {
			// 输出图象到页面
			BufferedImage img = null;
			if (number != 0) {
				if (max != 0) {
					img = image.creatImage3D(number, max);
				} else {
					img = image.creatImage(number);
				}
			} else {
				img = image.creatImage();
				request.getSession().setAttribute("rand", image.getSRand());

			}
			ImageIO.write(img, "JPEG", response.getOutputStream());
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (Exception e) {
			System.out.println( e);
		}
	}

	class ImageCode {

		public String sRand = "";

		public Color getRandColor(int fc, int bc) {// 给定范围获得随机颜色
			Random random = new Random();
			if (fc > 255)
				fc = 255;
			if (bc > 255)
				bc = 255;
			int r = fc + random.nextInt(bc - fc);
			int g = fc + random.nextInt(bc - fc);
			int b = fc + random.nextInt(bc - fc);
			return new Color(r, g, b);
		}

		public BufferedImage creatImage() {
			// 在内存中创建图象
			int width = 60, height = 20;
			BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			// 获取图形上下文
			Graphics g = image.getGraphics();
			// 生成随机类
			Random random = new Random();
			// 设定背景色
			g.setColor(getRandColor(200, 250));
			g.fillRect(0, 0, width, height);
			// 设定字体
			g.setFont(new Font("Times New Roman", Font.PLAIN, 18));
			// 画边框
			// g.setColor(new Color());
			// g.drawRect(0,0,width-1,height-1);
			// 随机产生155条干扰线，使图象中的认证码不易被其它程序探测到
			g.setColor(getRandColor(160, 200));
			for (int i = 0; i < 155; i++) {
				int x = random.nextInt(width);
				int y = random.nextInt(height);
				int xl = random.nextInt(12);
				int yl = random.nextInt(12);
				g.drawLine(x, y, x + xl, y + yl);
			}
			// 取随机产生的认证码(4位数字)
			// String rand = request.getParameter("rand");
			// rand = rand.substring(0,rand.indexOf("."));
			for (int i = 0; i < 4; i++) {
				String rand = String.valueOf(random.nextInt(10));
				sRand += rand;
				// 将认证码显示到图象中
				g.setColor(new Color(20 + random.nextInt(110), 20 + random.nextInt(110), 20 + random.nextInt(110)));// 调用函数出来的颜色相同，可能是因为种子太接近，所以只能直接生成
				g.drawString(rand, 13 * i + 6, 16);
			}
			// 图象生效
			g.dispose();
			return image;
		}

		/**
		 * @return Returns the sRand.
		 */
		public String getSRand() {
			return sRand;
		}

		public BufferedImage creatImage(int number) {
			// 在内存中创建图象
			String num = String.valueOf(number);
			char[] vs = num.toCharArray();

			int width = vs.length * 60 / 4, height = 18;
			BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			// 获取图形上下文
			Graphics g = image.getGraphics();
			// 生成随机类
			Random random = new Random();
			// 设定背景色
			g.setColor(Color.WHITE);
			g.fillRect(0, 0, width, height);
			// 设定字体
			g.setFont(new Font("Impact", Font.PLAIN, 14));
			// 画边框
			// g.setColor(new Color());
			// g.drawRect(0,0,width-1,height-1);
			// 随机产生155条干扰线，使图象中的认证码不易被其它程序探测到
			/*
			 * g.setColor(getRandColor(160, 200)); for (int i = 0; i < 155; i++) { int x = random.nextInt(width); int y =
			 * random.nextInt(height); int xl = random.nextInt(12); int yl = random.nextInt(12); g.drawLine(x, y, x + xl, y + yl); }
			 */
			// 取随机产生的认证码(4位数字)
			// String rand = request.getParameter("rand");
			// rand = rand.substring(0,rand.indexOf("."));
			for (int i = 0; i < vs.length; i++) {
				String rand = String.valueOf(vs[i]);
				sRand += rand;
				// 将认证码显示到图象中
				g.setColor(new Color(20 + random.nextInt(110), 20 + random.nextInt(110), 20 + random.nextInt(110)));// 调用函数出来的颜色相同，可能是因为种子太接近，所以只能直接生成
				g.drawString(rand, 13 * i + 6, 16);

			}
			// 图象生效
			g.dispose();
			return image;
		}

		public BufferedImage creatImage3D(int number, int max) {
			// 在内存中创建图象
			int width = 60, height = 10;
			int x = number * width / max;
			System.out.println(x);
			BufferedImage image = new BufferedImage(x, height, BufferedImage.TYPE_INT_RGB);
			// 获取图形上下文

			Graphics g = image.getGraphics();
			// g.fillRect(0, 0, width, height);

			g.setColor(this.getRandColor(100, 200));
			g.draw3DRect(0, 0, x, height, true);
			g.fill3DRect(0, 0, x, height, true);
			// 图象生效
			g.dispose();
			return image;
		}
	}

}
