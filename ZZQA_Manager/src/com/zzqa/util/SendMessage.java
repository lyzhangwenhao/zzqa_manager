package com.zzqa.util;

import com.zzqa.pojo.email.Email;
import com.zzqa.servlet.TimerServlet;

public class SendMessage implements Runnable{
	private String title;
	private String msg;
	private String tomail;
	public SendMessage(String title,String msg,String tomail){
		this.title=title;
		this.msg=msg;
		this.tomail=tomail;
	}
	public void run() {
		// TODO Auto-generated method stub
		if(title==null||title.isEmpty()||msg==null||msg.isEmpty()||tomail==null||tomail.isEmpty()){
			return;
		}
		Email email=new Email();
		email.setMsg(msg);
		email.setTitle(title+DataUtil.getTadayBySecond());
		email.setTomail(tomail);
		try {
			TimerServlet.queue.put(email);//阻塞
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("邮件入队中断------->"+msg);
		}
	}
}
