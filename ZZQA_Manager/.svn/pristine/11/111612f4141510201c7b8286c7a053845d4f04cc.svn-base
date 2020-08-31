package com.zzqa.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.integration.context.IntegrationContextUtils;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.zzqa.pojo.advise.Advise;
import com.zzqa.pojo.comments.Comments;
import com.zzqa.pojo.feedback.Feedback;
import com.zzqa.pojo.file_path.File_path;
import com.zzqa.pojo.notify.Notify;
import com.zzqa.pojo.operation.Operation;
import com.zzqa.pojo.related_user.Related_user;
import com.zzqa.pojo.reply.Reply;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.communicate.CommunicateManager;
import com.zzqa.service.interfaces.file_path.File_pathManager;
import com.zzqa.service.interfaces.operation.OperationManager;
import com.zzqa.service.interfaces.user.UserManager;
import com.zzqa.util.FileUploadUtil;

public class CommunicateServlet extends HttpServlet{
	private UserManager userManager;
	private CommunicateManager communicateManager;
	private OperationManager operationManager;
	private File_pathManager file_pathManager;
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String type = req.getParameter("type");
		HttpSession session=req.getSession();
		Object uidObject=session.getAttribute("uid");
		if(uidObject==null){
			resp.sendRedirect("login.jsp");
			return;
		}
		String sessionID=session.getId();
		int uid=((Integer)uidObject);
		String time_str=req.getParameter("file_time");
		long save_time=0l;
		if(time_str!=null){
			try {
				save_time=Long.parseLong(time_str);
			} catch (Exception e) {
				// TODO: handle exception
				save_time=0l;
			}
		}
		if("jumpUrl".equals(type)){
			int jumpType =Integer.parseInt(req.getParameter("jumpType"));
			int jumpID =0;
			String ID=req.getParameter("jumpID");
			if(ID!=null&&ID.length()>0){
				jumpID=Integer.parseInt(req.getParameter("jumpID"));
			}
			String url=null;
			switch (jumpType) {
			case 1:
				session.setAttribute("notify_id", jumpID);
				url="communicate/notify_detail.jsp";
				break;
			case 2:
				session.setAttribute("notify_id", jumpID);
				url="communicate/update_notify.jsp";
				break;
			case 3:
				url="communicate/mynotify.jsp";
				break;
			case 4:
				url="communicate/notify.jsp";
				break;
			case 5:
				url="communicate/more_notify.jsp";
				break;
			case 6:
				url="communicate/approve_feedback.jsp";
				break;
			case 7:
				session.setAttribute("feedback_id", jumpID);
				url="communicate/update_feedback.jsp";
				break;
			case 8:
				url="communicate/feedback.jsp";
				break;
			case 9:
				session.setAttribute("feedback_id", jumpID);
				url="communicate/feedback_detail.jsp";
				break;
			case 10:
				session.setAttribute("advise_id", jumpID);
				url="communicate/advise_detail.jsp";
				break;
			case 11:
				url="communicate/advise.jsp";
				break;
			case 12:
				session.setAttribute("advise_id", jumpID);
				url="communicate/update_advise.jsp";
				break;
			case 13:
				url="home.jsp";
				break;
			default:
				url="./login.jsp";
				break;
			}
			resp.sendRedirect(url);
			return;
		}else if("delNotify".equals(type)){
			int id=Integer.parseInt(req.getParameter("ID"));
			communicateManager.delNotifyByID(id);
			Operation operation=new Operation();
			operation.setContent("删除通知id:"+id);
			operation.setCreate_time(System.currentTimeMillis());
			operation.setUid(uid);
			operationManager.insertOperation(operation);
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println();
			out.flush();
		}else if("getNotify".equals(type)){
			int year=Integer.parseInt(req.getParameter("year"));
			session.setAttribute("notifyyear", year);//返回时需要刷新
			List<Notify> list=communicateManager.getNotifyListByCreateID(uid, year);
			JSONArray jsonArray=JSONArray.fromObject(list);
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println(jsonArray);
			out.flush();
		}else if("addnotify".equals(type)){
			String title=req.getParameter("notify_title");
			String content=req.getParameter("notify_content");
			String publisher=req.getParameter("notify_publisher");
			Notify notify=new Notify();
			notify.setTitle(title);
			notify.setContent(content);
			notify.setCreate_id(uid);
			if(publisher!=null&&publisher.replace(" ", "").length()>0){
				notify.setPublisher(publisher);
			}
			long time=System.currentTimeMillis();
			notify.setCreate_time(time);
			notify.setUpdate_time(time);
			communicateManager.insertNotify(notify);
			int notify_id=communicateManager.getNewNotifyIDByCreateID(uid);
			file_pathManager.saveFile(uid,sessionID,23,notify_id,1,0,save_time);
			Operation operation=new Operation();
			operation.setContent("创建一条通知id:"+notify_id);
			operation.setCreate_time(time);
			operation.setUid(uid);
			operationManager.insertOperation(operation);
			session.setAttribute("notify_id", notify_id);
			resp.sendRedirect("communicate/notify_detail.jsp");
		}else if("updatenotify".equals(type)){
			String title=req.getParameter("notify_title");
			String content=req.getParameter("notify_content");
			String publisher=req.getParameter("notify_publisher");
			int notify_id=Integer.parseInt(req.getParameter("notify_id"));
			Notify notify=communicateManager.getNotifyByID(notify_id);
			notify.setContent(content);
			notify.setTitle(title);
			long time=System.currentTimeMillis();
			notify.setUpdate_time(time);
			User user=userManager.getUserByID(uid);
			if(user==null){
				resp.sendRedirect("login.jsp");
				return;
			}else{
				if (!user.getTruename().equals(publisher)) {
					notify.setPublisher(publisher);
				}
			}
			communicateManager.updateNotify(notify);
			file_pathManager.saveFile(uid, sessionID, 23, notify_id, 1, 0, save_time);
			Operation operation=new Operation();
			operation.setContent("修改通知id："+notify_id);
			operation.setCreate_time(time);
			operation.setUid(uid);
			operationManager.insertOperation(operation);
			session.setAttribute("notify_id", notify_id);
			resp.sendRedirect("communicate/notify_detail.jsp");
		}else if("addComment".equals(type)){
			int c_type=Integer.parseInt(req.getParameter("c_type"));
			int notify_id=Integer.parseInt(req.getParameter("foreign_id"));
			String content=req.getParameter("content");
			Comments comments=new Comments();
			long time=System.currentTimeMillis();
			comments.setContent(content);
			comments.setCreate_id(uid);
			comments.setForeign_id(notify_id);
			comments.setCreate_time(time);
			comments.setUpdate_time(time);
			comments.setType(c_type);
			communicateManager.insertComments(comments);
			int comments_id=communicateManager.getNewCommentsIDByCreateID(uid);
			Operation operation=new Operation();
			operation.setContent("创建一条评论id:"+comments_id);
			operation.setUid(uid);
			operation.setCreate_time(time);
			operationManager.insertOperation(operation);
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.print(comments_id);
			out.flush();
		}else if("delComments".equals(type)){
			int comments_id =Integer.parseInt(req.getParameter("comments_id"));
			communicateManager.delCommentsByID(comments_id);
			Operation operation=new Operation();
			operation.setContent("删除评论id:"+comments_id+"及其相关回复");
			operation.setUid(uid);
			operation.setCreate_time(System.currentTimeMillis());
			operationManager.insertOperation(operation);
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println();
			out.flush();
		}else if("updateComments".equals(type)){
			int comments_id =Integer.parseInt(req.getParameter("comments_id"));
			Comments comments=communicateManager.getCommentsByID(comments_id);
			String content=req.getParameter("content");
			if(comments!=null){
				long time=System.currentTimeMillis();
				comments.setUpdate_time(time);
				comments.setContent(content);
				communicateManager.updateComments(comments);
				Operation operation=new Operation();
				operation.setContent("修改评论id:"+comments_id);
				operation.setUid(uid);
				operation.setCreate_time(time);
				operationManager.insertOperation(operation);
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println();
			out.flush();
		}else if("delReply".equals(type)){
			int reply_id =Integer.parseInt(req.getParameter("reply_id"));
			communicateManager.delReplyByID(reply_id);
			Operation operation=new Operation();
			operation.setContent("删除回复id:"+reply_id);
			operation.setUid(uid);
			operation.setCreate_time(System.currentTimeMillis());
			operationManager.insertOperation(operation);
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println();
			out.flush();
		}else if("updateReply".equals(type)){
			int reply_id =Integer.parseInt(req.getParameter("reply_id"));
			Reply reply=communicateManager.getReplyByID(reply_id);
			if(reply!=null){
				String content=req.getParameter("content");
				long time=System.currentTimeMillis();
				reply.setUpdate_time(time);
				reply.setContent(content);
				communicateManager.updateReply(reply);
				Operation operation=new Operation();
				operation.setContent("修改回复id:"+reply_id);
				operation.setUid(uid);
				operation.setCreate_time(time);
				operationManager.insertOperation(operation);
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println();
			out.flush();
		}else if("addReply".equals(type)){
			int comments_id =Integer.parseInt(req.getParameter("comments_id"));
			int reply_id=Integer.parseInt(req.getParameter("reply_id"));
			int reply_uid=0;
			if(reply_id==0){
				Comments comments=communicateManager.getCommentsByID(comments_id);
				if(comments!=null){
					reply_uid=comments.getCreate_id();
				}
			}else{
				Reply reply2=communicateManager.getReplyByID(reply_id);
				if(reply2!=null){
					reply_uid=reply2.getCreate_id(); 
				}
			}
			if(reply_uid!=0){
				String content=req.getParameter("content");
				Reply reply=new Reply();
				reply.setComment_id(comments_id);
				reply.setCreate_id(uid);
				reply.setContent(content);
				reply.setReply_id(reply_id);
				reply.setReply_uid(reply_uid);
				long time=System.currentTimeMillis();
				reply.setCreate_time(time);
				reply.setUpdate_time(time);
				communicateManager.insertReply(reply);
				reply_id=communicateManager.getNewReplyIDByCreateID(uid);
				Operation operation=new Operation();
				operation.setContent("添加回复id:"+reply_id);
				operation.setCreate_time(time);
				operation.setUid(uid);
				operationManager.insertOperation(operation);
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.print(reply_id);
			out.flush();
		}else if("handelagree".equals(type)){
			boolean isagree=Boolean.parseBoolean(req.getParameter("isagree"));
			int foreign_id=Integer.parseInt(req.getParameter("foreign_id"));
			int relate_type=Integer.parseInt(req.getParameter("relate_type"));
			if(isagree){
					//取消点赞
					communicateManager.delRelated_userByCondition(relate_type, foreign_id, uid);
			}else{
				//点赞
				if(communicateManager.getRelated_userCount(relate_type, foreign_id, uid)>0){
					//防止多个客户端同时保存
				}else{
					Related_user related_user=new Related_user();
					related_user.setUid(uid);
					related_user.setType(relate_type);
					related_user.setForeign_id(foreign_id);
					communicateManager.insertRelated_user(related_user);
				}
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println();
			out.flush();
		}else if("getNotifyListByYear".equals(type)){
			int year=Integer.parseInt(req.getParameter("year"));
			session.setAttribute("notifyyear", year);
			List<Notify> notifies=communicateManager.getNotifyListByYear(year, 0, uid);
			JSONArray jsonArray=JSONArray.fromObject(notifies);
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println(jsonArray);
			out.flush();
		}else if("delFeedback".equals(type)){
			int id=Integer.parseInt(req.getParameter("ID"));
			communicateManager.delFeedbackByID(id);
			Operation operation=new Operation();
			operation.setContent("删除反馈id:"+id);
			operation.setCreate_time(System.currentTimeMillis());
			operation.setUid(uid);
			operationManager.insertOperation(operation);
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println();
			out.flush();
		}else if("getFeedback".equals(type)){
			List<Feedback> feedList;
			int nowpage=Integer.parseInt(req.getParameter("nowpage"));
			if("0".equals(req.getParameter("create_id"))){
				feedList=communicateManager.getFeedbackListByCondition(uid, nowpage,false);//所有
				session.setAttribute("appfeedback_nowpage", nowpage);
			}else{
				feedList=communicateManager.getFeedbackListByCondition(uid, nowpage,true);//用户自己发布的
				session.setAttribute("feedback_nowpage", nowpage);
			}
			JSONArray jsonArray=JSONArray.fromObject(feedList);
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println(jsonArray);
			out.flush();
		}else if("addFeedback".equals(type)){
			String title=req.getParameter("feedback_title");
			String content=req.getParameter("feedback_content");
			Feedback feedback=new Feedback();
			feedback.setTitle(title);
			feedback.setContent(content);
			feedback.setCreate_id(uid);
			long time=System.currentTimeMillis();
			feedback.setCreate_time(time);
			feedback.setUpdate_time(time);
			communicateManager.insertFeedback(feedback);
			int feedback_id=communicateManager.getNewFeedbackIDByCreateID(uid);
			file_pathManager.saveFile(uid,sessionID,22,feedback_id,1,0,save_time);
			Operation operation=new Operation();
			operation.setContent("创建一条反馈id:"+feedback_id);
			operation.setCreate_time(time);
			operation.setUid(uid);
			operationManager.insertOperation(operation);
			session.setAttribute("feedback_id", feedback_id);
			resp.sendRedirect("communicate/feedback_detail.jsp");
		}else if("updateFeedback".equals(type)){
			String title=req.getParameter("feedback_title");
			String content=req.getParameter("feedback_content");
			int feedback_id=Integer.parseInt(req.getParameter("feedback_id"));
			Feedback feedback=communicateManager.getFeedbackByID(feedback_id);
			feedback.setContent(content);
			feedback.setTitle(title);
			long time=System.currentTimeMillis();
			feedback.setUpdate_time(time);
			communicateManager.updateFeedback(feedback);
			file_pathManager.saveFile(uid, sessionID, 22, feedback_id, 1, 0, save_time);
			Operation operation=new Operation();
			operation.setContent("修改反馈id："+feedback_id);
			operation.setCreate_time(time);
			operation.setUid(uid);
			operationManager.insertOperation(operation);
			session.setAttribute("feedback_id", feedback_id);
			resp.sendRedirect("communicate/feedback_detail.jsp");
		}else if("getAdvise".equals(type)){
			int year=Integer.parseInt(req.getParameter("year"));
			int advise_tab=Integer.parseInt(req.getParameter("advise_tab"));
			List<Advise> list=null;
			session.setAttribute("advise_tab", advise_tab);
			session.setAttribute("adviseyear", year);
			if(advise_tab==1){
				//公开
				list=communicateManager.getAdviseListByCondition(1,uid,year);
			}else if(advise_tab==2){
				//私人
				list=communicateManager.getAdviseListByCondition(2,uid,year);
			}else if(advise_tab==3){
				//自己
				list=communicateManager.getAdviseListByCondition(0,uid,year);
			}
			JSONArray jsonArray=JSONArray.fromObject(list);
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println(jsonArray);
			out.flush();
		}else if("delAdvise".equals(type)){
			int id=Integer.parseInt(req.getParameter("ID"));
			communicateManager.delAdviseByID(id);
			Operation operation=new Operation();
			operation.setContent("删除建议id:"+id);
			operation.setCreate_time(System.currentTimeMillis());
			operation.setUid(uid);
			operationManager.insertOperation(operation);
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println();
			out.flush();
		}else if("addadvise".equals(type)){
			String title=req.getParameter("advise_title");
			String content=req.getParameter("advise_content");
			int advise_type=Integer.parseInt(req.getParameter("advise_type"));
			Advise advise=new Advise();
			advise.setTitle(title);
			advise.setContent(content);
			advise.setCreate_id(uid);
			long time=System.currentTimeMillis();
			advise.setAnonymous("on".equals(req.getParameter("anonymous"))?0:1);
			advise.setUpdate_time(time);
			advise.setCreate_time(time);
			advise.setType(advise_type);
			communicateManager.insertAdvise(advise);
			int advise_id=communicateManager.getNewAdviseIDByCreateID(uid);
			if(advise_type==2){
				String UIDs=req.getParameter("UIDs");
				String[] UIDsArray=UIDs.split("-");
				for (String string : UIDsArray) {
					Related_user related_user=new Related_user();
					related_user.setUid(Integer.parseInt(string));
					related_user.setType(1);
					related_user.setForeign_id(advise_id);
					communicateManager.insertRelated_user(related_user);
				}
			}
			file_pathManager.saveFile(uid,sessionID,21,advise_id,1,0,save_time);
			Operation operation=new Operation();
			operation.setContent("创建一条建议id:"+advise_id);
			operation.setCreate_time(time);
			operation.setUid(uid);
			operationManager.insertOperation(operation);
			session.setAttribute("advise_id", advise_id);
			resp.sendRedirect("communicate/advise_detail.jsp");
		}else if("updateAdvise".equals(type)){
			String title=req.getParameter("advise_title");
			String content=req.getParameter("advise_content");
			int advise_type=Integer.parseInt(req.getParameter("advise_type"));
			int advise_id=Integer.parseInt(req.getParameter("advise_id"));
			Advise advise=communicateManager.getAdviseByID(advise_id);
			advise.setTitle(title);
			advise.setContent(content);
			advise.setCreate_id(uid);
			long time=System.currentTimeMillis();
			advise.setAnonymous("on".equals(req.getParameter("anonymous"))?0:1);
			advise.setUpdate_time(time);
			advise.setCreate_time(time);
			advise.setType(advise_type);
			communicateManager.updateAdvise(advise);
			if(advise_type==2){
				communicateManager.delRelated_userByCondition(1, advise_id,0);
				String UIDs=req.getParameter("UIDs");
				String[] UIDsArray=UIDs.split("-");
				for (String string : UIDsArray) {
					Related_user related_user=new Related_user();
					related_user.setUid(Integer.parseInt(string));
					related_user.setType(1);
					related_user.setForeign_id(advise_id);
					communicateManager.insertRelated_user(related_user);
				}
			}
			file_pathManager.saveFile(uid,sessionID,21,advise_id,1,0,save_time);
			Operation operation=new Operation();
			operation.setContent("修改建议id:"+advise_id);
			operation.setCreate_time(time);
			operation.setUid(uid);
			operationManager.insertOperation(operation);
			session.setAttribute("advise_id", advise_id);
			resp.sendRedirect("communicate/advise_detail.jsp");
			
		}
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String type=req.getParameter("type");
		HttpSession session=req.getSession();
		if(session==null){
			req.getRequestDispatcher("/login.jsp").forward(req,resp);
			return;
		}
		if("jumpToAdvise".equals(type)){
			session.setAttribute("advise_tab",2);
			resp.sendRedirect("communicate/advise.jsp");
		}else{
			req.getRequestDispatcher("/login.jsp").forward(req,resp);
			return;
		}
	}
	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		userManager=(UserManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext())
				.getBean("userManager");
		communicateManager=(CommunicateManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext())
				.getBean("communicateManager");
		operationManager=(OperationManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext())
				.getBean("operationManager");
		file_pathManager=(File_pathManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext())
				.getBean("file_pathManager");
	}
}
