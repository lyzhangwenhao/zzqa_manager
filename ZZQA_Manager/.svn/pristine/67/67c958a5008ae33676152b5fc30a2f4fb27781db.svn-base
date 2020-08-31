package com.zzqa.servlet;

import java.io.File;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

import javax.mail.Session;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.zzqa.pojo.email.Email;
import com.zzqa.util.FileUploadUtil;
import com.zzqa.util.MessageSender;

public class TimerServlet implements ServletContextListener {
	public static int mailIndex=0;
	public static BlockingQueue<Email> queue = new ArrayBlockingQueue<Email>(64);
	public void contextInitialized(ServletContextEvent arg0) { 
		Thread thread=new Thread(new mailtime(),"sendmaildelay");
		thread.start();
		Thread thread_delfile=new Thread(new DeleteFile(),"deletefile");
		thread_delfile.start();
	}


	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		queue.clear();
	}
}

class mailtime implements Runnable{

	@Override
	public void run() {
		while (true) {
			Email email=TimerServlet.queue.poll();
			if(email!=null){
				sendMessage(email);
			}
			try {
				Thread.sleep(60000);//1分钟查询一次
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("Thread=>mailtime异常InterruptedException");
			}
		}
	}
	
	private void sendMessage(Email email) {
		MessageSender sender = new MessageSender();
		Session session = sender.createSession("smtp");
		try {
			MimeMessage mail = sender.createMessage(session,email.getTitle(),email.getMsg(),email.getTomail());
			sender.sendMail(session, mail);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("Thread=>mailtime的createMessage时异常");
		}
	}
}
class DeleteFile implements Runnable{
	@Override
	public void run() {
		while (true) {
			deleteFile();//删除过期的文件
			try {
				Thread.sleep(43200000);//半天查询一次
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("Thread=>deletefile异常InterruptedException");
			}
		}
	}
	private void deleteFile(){
		File delExcel = new File(FileUploadUtil.getExcelFilePath());
		File oldFile[] = delExcel.listFiles();
		try {
			if (oldFile != null) {
				long nowtime=System.currentTimeMillis();
				for (int i = 0; i < oldFile.length; i++) {
					if(nowtime-oldFile[i].lastModified()>30*60000){
						oldFile[i].delete();
					}
				}
			}
		} catch (Exception e) {
			System.out.println("FileDownServlet清空文件夹操作出错!");
			e.printStackTrace();
		}
	}
}
