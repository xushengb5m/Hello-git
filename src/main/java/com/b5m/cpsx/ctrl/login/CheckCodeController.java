/**   
 * @Title: CheckCodeController.java 
 * @Package com.b5m.cpsx.ctrl.login 
 * @Description: TODO
 * @author feitian  
 * @date 2016年6月1日 下午5:42:26 
 * @version V1.0   
 */
package com.b5m.cpsx.ctrl.login;

/** 
 * @ClassName: CheckCodeController 
 * @Description: TODO
 * @author feitian
 * @date 2016年6月1日 下午5:42:26 
 *  
 */

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.b5m.cpsx.commons.constant.CookieKeyConstant;
import com.b5m.cpsx.utils.WebCookieComponent;

@Controller
@RequestMapping("/checkCode")
public class CheckCodeController {

	private Log logger = LogFactory.getLog(this.getClass());

	public CheckCodeController() {
		super();
	}

	public Color getRandColor(int s, int e) {
		Random random = new Random();
		if (s > 255)
			s = 255;
		if (e > 255)
			e = 255;
		int r = s + random.nextInt(e - s);
		int g = s + random.nextInt(e - s);
		int b = s + random.nextInt(e - s);
		return new Color(r, g, b);
	}

	private int x = 0;

	private int codeY;

	char[] codeSequence = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
			'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
			'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

	@RequestMapping("/service.do")
	public void checkCode(HttpServletRequest request, HttpServletResponse resp) {

		int width = 100;
		int height = 25;
		int fontHeight = 32, codeCount = 4;

		x = width / (codeCount + 1);
		fontHeight = height - 2;
		codeY = height - 4;
		// 定义图像buffer
		BufferedImage buffImg = new BufferedImage(width, height,
				BufferedImage.TYPE_INT_RGB);
		Graphics2D gd = buffImg.createGraphics();

		// 创建一个随机数生成器类
		Random random = new Random();

		// 将图像填充为白色
		gd.setColor(Color.decode("#f6f6f6"));
		gd.fillRect(0, 0, width, height);

		// 创建字体，字体的大小应该根据图片的高度来定。
		Font font = new Font("Consolas", Font.PLAIN, fontHeight);
		// 设置字体。
		gd.setFont(font);
		// 画边框。
		gd.setColor(Color.WHITE);
		gd.drawRect(0, 0, width - 1, height - 1);

		// 随机产生160条干扰线，使图象中的认证码不易被其它程序探测到。
		gd.setColor(Color.ORANGE);
		for (int i = 0; i < 0; i++) {
			int x = random.nextInt(width);
			int y = random.nextInt(height);
			int xl = random.nextInt(12);
			int yl = random.nextInt(12);
			gd.drawLine(x, y, x + xl, y + yl);
		}

		// randomCode用于保存随机产生的验证码，以便用户登录后进行验证。
		StringBuffer randomCode = new StringBuffer();
		int red = 0, green = 0, blue = 0;

		// 随机产生codeCount数字的验证码。
		for (int i = 0; i < codeCount; i++) {
			// 得到随机产生的验证码数字。
			String strRand = String.valueOf(codeSequence[random.nextInt(36)]);
			// 产生随机的颜色分量来构造颜色值，这样输出的每位数字的颜色值都将不同。
			red = random.nextInt(255);
			green = random.nextInt(255);
			blue = random.nextInt(255);

			// 用随机产生的颜色将验证码绘制到图像中。
			if (red > 250 && green > 250 && blue > 250) {
				i--;
				continue;
			}
			gd.setColor(new Color(red, green, blue));
			gd.drawString(strRand, ((i + 1) * x) - 10, codeY);

			// 将产生的四个随机数组合在一起。
			randomCode.append(strRand);
		}

		String checkCode = randomCode.toString();

		// 禁止图像缓存。
		resp.setHeader("Pragma", "no-cache");
		resp.setHeader("Cache-Control", "no-cache");
		resp.setDateHeader("Expires", 0);

		resp.setContentType("image/jpeg");

		String safd = request.getParameter("type");
		if (safd != null) {
			// 用户类型判断
			if (safd.equals("cpsx")) {
				// 存入cookie
				Cookie cookie = WebCookieComponent.createCookie(
						CookieKeyConstant.CPSX_CHECK_CODE, checkCode, 30 * 60);
				resp.addCookie(cookie);
			} else {

			}

			// 将图像输出到Servlet输出流中。
			ServletOutputStream sos;
			try {
				sos = resp.getOutputStream();
				ImageIO.write(buffImg, "jpeg", sos);
				sos.close();
			} catch (IOException e) {
				logger.error("/checkCode/service.do", e);
			}

		}

	}
}