package com.b5m.cpsx.utils;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailUtils {
	
		static JavaMailSender javaMailSender = SpringContextUtils.getBean("javaMailSender", JavaMailSenderImpl.class);

		public static void sendMail(String[] to, String[] cc, String title, String content)
				throws MessagingException {
			
			JavaMailSenderImpl senderImpl = new JavaMailSenderImpl();
			MimeMessage mailMessage = senderImpl.createMimeMessage();
			// 设置utf-8或GBK编码，否则邮件会有乱码
			MimeMessageHelper messageHelper = new MimeMessageHelper(mailMessage,
					true, "utf-8");
			try {
				messageHelper.setTo(to);// 接受者
				String from = "bimail@b5m.com";
				messageHelper.setFrom(new InternetAddress(from));
				messageHelper.setCc(cc);// 抄送
				messageHelper.setSubject(title);// 主题
				// 邮件内容，注意加参数true，表示启用html格式
				messageHelper.setText(content, true);// html邮件 第二个参数为true
				javaMailSender.send(mailMessage);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

}
