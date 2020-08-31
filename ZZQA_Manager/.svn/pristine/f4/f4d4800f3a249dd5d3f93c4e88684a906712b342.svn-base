package com.zzqa.servlet;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URI;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.mail.Session;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.support.WebApplicationContextUtils;

import com.zzqa.pojo.linkman.Linkman;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.linkman.LinkmanManager;
import com.zzqa.service.interfaces.user.UserManager;
import com.zzqa.util.MessageSender;

public class ImageServlet extends HttpServlet{
	private UserManager userManager;
	private LinkmanManager linkmanManager;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		resp.setCharacterEncoding("utf-8");
		String type = req.getParameter("type");//获得ajax传的值
		if("check".equals(type)){
			int flag=2;//0：正确；1：验证错误；2：找不到验证信息，需要刷新
			if(req.getSession()!=null&&req.getSession().getAttribute("verificationCode")!=null){
				String verificationCode=(String)req.getSession().getAttribute("verificationCode");
				if(verificationCode.equals(req.getParameter("code"))){
					flag=0;
				}else{
					flag=1;
				}
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.print(flag);
			out.flush();
		}else if("sendmail".equals(type)){
			String username=req.getParameter("username");
			String mail=req.getParameter("mail");
			User user=userManager.getUserByEmail(mail);
			int flag=1;
			if(user!=null){
				MessageSender sender = new MessageSender();
				Session session = sender.createSession("smtp");
				try {
					String msg="";
					long time=System.currentTimeMillis();
					String url=URLEncoder.encode(""+time,"UTF-8");
					linkmanManager.deleteLinkmanLimit(101, user.getId(), 0, 0);//防止重复
					Linkman linkman=new Linkman();
					linkman.setCreate_time(time);
					linkman.setForeign_id(user.getId());
					linkman.setType(101);
					linkman.setLinkman_case(0);
					linkman.setState(0);
					linkman.setLinkman("");
					linkman.setPhone("");
					linkmanManager.insertLinkman(linkman);
					int id=linkman.getId();
					String address="<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;内网链接：http://10.100.0.2/ZZQA_Manager/UserManagerServlet?type=checkpw&t="+time+"&i="+id
							+"<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;外网链接：http://oa.windit.com.cn/UserManagerServlet?type=checkpw&t="+time+"&i="+id;
					msg=new StringBuilder().append(user.getTruename()).append(" 您好！")
							.append("<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;你的重置密码请求已收到，点击下面链接重置你的密码。").append(address)
							.append("<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;此邮件30分钟内有效，如果你忽略这条消息，密码将不进行更改。")
							.append(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(time)).toString();
					MimeMessage mm = sender.createMessage(session,"OA办公系统邮件提醒",msg,mail);
					sender.sendMail(session, mm);
					flag=0;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.print(flag);
			out.flush();
		}else{
			BufferedImage bfi = new BufferedImage(80,25,BufferedImage.TYPE_INT_RGB);
	        Graphics g = bfi.getGraphics();  
	        g.fillRect(0, 0, 80, 25);  
	        char[] chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".toCharArray();
	        char[] char_arr=new char[4];
	        StringBuffer sb = new StringBuffer(); //保存字符串  
	        int index;
	        Random r = new Random();
	        char[] chars1= "abcdefghijklmnopqrstuvwxyz".toCharArray();
        	char[] chars2= "ABCDEFGHIJKLMNOPQRSTUVWXYZ".toCharArray();
        	char[] chars3 = "0123456789".toCharArray();
        	index = (int)Math.floor(r.nextDouble() * chars1.length);
        	char_arr[0]= chars1[index];
        	index= (int)Math.floor(r.nextDouble() * chars2.length);
        	char_arr[1]= chars2[index];
            index =(int)Math.floor(r.nextDouble() * chars3.length);
            char_arr[2]= chars3[index];
            index =(int)Math.floor(r.nextDouble() * chars.length);
            char_arr[3]= chars[index];
            for(int i = 0; i < 4; i++){
        		index = (int)Math.floor(r.nextDouble() * 4);
        		char temp = char_arr[index];
        		char_arr[index] = char_arr[i];
        		char_arr[i]= temp;
        	}
            for(int i=0; i<4; i++){
	            g.setColor(new Color(r.nextInt(255),r.nextInt(255),r.nextInt(255)));  
	            Font font = new Font("宋体", 30, 20);  
	            g.setFont(font);  
	            g.drawString(char_arr[i]+"", (i*20)+2, 23);
	        }
	        // 添加噪点  
	        int area = (int) (0.02 * 80 * 25);  
	        for(int i=0; i<area; ++i){  
	            int x = (int)(r.nextDouble() * 80);  
	            int y = (int)(r.nextDouble() * 25);  
	            bfi.setRGB(x, y, (int)(r.nextDouble() * 255));  
	        }
	        /*//设置验证码中的干扰线
	        for (int i = 0; i < 6; i++) {    
	              //随机获取干扰线的起点和终点  
	              int xstart = (int)(r.nextDouble() * 80);  
	              int ystart = (int)(r.nextDouble() * 25);  
	              int xend = (int)(r.nextDouble() * 80);  
	              int yend = (int)(r.nextDouble() * 25);  
	              g.setColor(interLine(1, 255));  
	              g.drawLine(xstart, ystart, xend, yend);  
	        }*/
	        sb.append(char_arr);
	        HttpSession session = req.getSession();  //保存到session  
	        session.setAttribute("verificationCode", sb.toString());  
	        ImageIO.write(bfi, "JPG", resp.getOutputStream());  //写到输出流
		}
	}
	private static Color interLine(int Low, int High){  
        if(Low > 255)  
            Low = 255;  
        if(High > 255)  
            High = 255;  
        if(Low < 0)  
            Low = 0;  
        if(High < 0)  
            High = 0;  
        int interval = High - Low;  
        int r = Low + (int)(Math.random() * interval);  
        int g = Low + (int)(Math.random() * interval);  
        int b = Low + (int)(Math.random() * interval);  
        return new Color(r, g, b);  
      } 
	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		super.init();
		userManager=(UserManager)WebApplicationContextUtils.getWebApplicationContext(getServletContext()).getBean("userManager");
		linkmanManager=(LinkmanManager)WebApplicationContextUtils.getWebApplicationContext(getServletContext()).getBean("linkmanManager");
	}
}
