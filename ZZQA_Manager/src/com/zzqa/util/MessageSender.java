package com.zzqa.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import com.zzqa.servlet.TimerServlet;

public class MessageSender {
	String[] userArray=new String[]{"info@windit.com.cn","info2@windit.com.cn"};
	/**
	 * 创建Session对象，此时需要配置传输的协议，是否身份认证
	 */
	public Session createSession(String protocol) {
		Properties property = new Properties();
		property.setProperty("mail.transport.protocol", protocol);
		property.setProperty("mail.smtp.auth", "true");
		Session session = Session.getInstance(property);
		return session;
	}

	/**
	 * 传入Session、MimeMessage对象，创建 Transport 对象发送邮件
	 * mailIndex 邮箱次序
	 */
	public void sendMail(Session session, MimeMessage msg) throws Exception {
		// 设置发件人使用的SMTP服务器、用户名、密码
		String smtpServer = "smtp.exmail.qq.com";
		String user =userArray[TimerServlet.mailIndex%2] ;
		String pwd = "Windit2010";
		TimerServlet.mailIndex++;
		// 由 Session 对象获得 Transport 对象
		Transport transport = session.getTransport();
		// 发送用户名、密码连接到指定的 smtp 服务器
		transport.connect(smtpServer, user, pwd);

		transport.sendMessage(msg, msg.getRecipients(Message.RecipientType.TO));
		transport.close();
	}

	/**
	 * 根据传入的 Seesion 对象创建混合型的 MIME消息
	 */
	public MimeMessage createMessage(Session session,String subject,String body,String tomail) throws Exception {
		
		String from = userArray[TimerServlet.mailIndex%2];

		MimeMessage msg = new MimeMessage(session);
		msg.setFrom(new InternetAddress(from));
		msg.setRecipient(Message.RecipientType.TO, new InternetAddress(tomail));
		msg.setSubject(subject);

		// 创建邮件的各个 MimeBodyPart 部分
		MimeBodyPart content = createContent(body);

		// 将邮件中各个部分组合到一个"mixed"型的 MimeMultipart 对象
		MimeMultipart allPart = new MimeMultipart("mixed");
		allPart.addBodyPart(content);

		// 将上面混合型的 MimeMultipart 对象作为邮件内容并保存
		msg.setContent(allPart);
		msg.saveChanges();
		return msg;
	}

	/**
	 * 根据传入的邮件正文body和文件路径创建图文并茂的正文部分
	 */
	public MimeBodyPart createContent(String body) throws Exception {
		// 用于保存最终正文部分
		MimeBodyPart contentBody = new MimeBodyPart();
		// 用于组合文本和图片，"related"型的MimeMultipart对象
		MimeMultipart contentMulti = new MimeMultipart("related");

		// 正文的文本部分
		MimeBodyPart textBody = new MimeBodyPart();
		textBody.setContent(body, "text/html;charset=UTF-8");
		contentMulti.addBodyPart(textBody);

		// 将上面"related"型的 MimeMultipart 对象作为邮件的正文
		contentBody.setContent(contentMulti);
		return contentBody;
	}
}
