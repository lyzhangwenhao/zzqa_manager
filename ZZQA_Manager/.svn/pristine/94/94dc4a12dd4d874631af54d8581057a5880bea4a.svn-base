package com.zzqa.service.impl.communicate;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.zzqa.dao.interfaces.Reply.IReplyDAO;
import com.zzqa.dao.interfaces.advise.IAdviseDAO;
import com.zzqa.dao.interfaces.comments.ICommentsDAO;
import com.zzqa.dao.interfaces.feedback.IFeedbackDAO;
import com.zzqa.dao.interfaces.notify.INotifyDAO;
import com.zzqa.dao.interfaces.read_user.IRead_userDAO;
import com.zzqa.dao.interfaces.related_user.IRelated_userDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.advise.Advise;
import com.zzqa.pojo.comments.Comments;
import com.zzqa.pojo.feedback.Feedback;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.notify.Notify;
import com.zzqa.pojo.read_user.Read_user;
import com.zzqa.pojo.related_user.Related_user;
import com.zzqa.pojo.reply.Reply;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.communicate.CommunicateManager;
@Service("communicateManager")
public class CommunicateManagerImpl implements CommunicateManager {
	@Resource(name="userDAO")
	private IUserDAO userDAO;
	@Resource(name="feedbackDAO")
	private IFeedbackDAO feedbackDAO;
	@Resource(name="adviseDAO")
	private IAdviseDAO adviseDAO;
	@Resource(name="notifyDAO")
	private INotifyDAO notifyDAO;
	@Resource(name="related_userDAO")
	private IRelated_userDAO related_userDAO;
	@Resource(name="replyDAO")
	private IReplyDAO replyDAO;
	@Resource(name="commentsDAO")
	private ICommentsDAO commentsDAO;
	@Resource(name="read_userDAO")
	private IRead_userDAO read_userDAO;
	
	@Override
	public Advise getAdviseByID(int id) {
		// TODO Auto-generated method stub
		Advise advise=adviseDAO.getAdviseByID(id);
		if(advise!=null){
			advise.setUpdate_date(new SimpleDateFormat("yyyy-MM-dd").format(advise.getUpdate_time()));
			advise.setCreate_name(advise.getAnonymous()==0?"匿名":userDAO.getUserNameByID(advise.getCreate_id()));
		}
		return advise;
	}
	@Override
	public void insertAdvise(Advise advise) {
		// TODO Auto-generated method stub
		adviseDAO.insertAdvise(advise);
	}
	@Override
	public void delAdviseByID(int id) {
		// TODO Auto-generated method stub
		adviseDAO.delAdviseByID(id);
		List<Comments> list=commentsDAO.getCommentsListByCondition(1, id);
		for (Comments comments : list) {
			delCommentsByID(comments.getId());	//删除相关的回复何点赞信息
		}
		related_userDAO.delRelated_userByCondition(1, id, 0);
	}
	@Override
	public void updateAdvise(Advise advise) {
		// TODO Auto-generated method stub
		adviseDAO.updateAdvise(advise);
	}
	@Override
	public int getNotReadAdviseCount(int type,int create_id){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		Map map=new HashMap();
		map.put("type", type);
		map.put("create_id", create_id);
		map.put("starttime", 0);
		map.put("endtime", 0);
		int num=0;
		if(type==0){
			//本人
			List<Advise> adviseList=adviseDAO.getAdviseListByCondition(map);
			for (Advise advise : adviseList) {
				long time=read_userDAO.getRead_userTimeByCondition(1, advise.getId(),create_id);
				if(commentsDAO.getCommentsCountByCondition(1, advise.getId(), create_id, time)==0){
					List<Comments> commentList=commentsDAO.getCommentsListByCondition(1, advise.getId());
					for (Comments comments : commentList) {
						if(replyDAO.getReplyCountByCondition(comments.getId(), create_id, time)>0){
							num++;
							break;
						}
					}
					commentList.clear();
					commentList=null;
				}else{
					num++;
				}
			}
			adviseList.clear();
			adviseList=null;
		}else if(type==1){
			//公共
		}else{
			//私信未读
			List<Advise> adviseList=adviseDAO.getAdviseListByCondition(map);
			for (Advise advise : adviseList) {
				if(read_userDAO.getRead_userTimeByCondition(1, advise.getId(),create_id)<advise.getUpdate_time()){
					num++;	
				}
			}
		}
		return num;
	}
	@Override
	public List< Advise> getAdviseListByCondition(int type,int create_id,int year){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		long starttime=0;
		long endtime=0;
		if(year>0){
			try {
				starttime=sdf.parse(year+"-01-01").getTime();
				endtime=sdf.parse(year+"-12-32").getTime();//搜一年
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();//搜2017年
				starttime=1483200000000l;
				endtime=1514736000000l;
			}
		}
		Map map=new HashMap();
		map.put("type", type);
		map.put("create_id", create_id);
		map.put("starttime", starttime);
		map.put("endtime", endtime);
		List<Advise> adviseList=adviseDAO.getAdviseListByCondition(map);
		for (Advise advise : adviseList) {
			advise.setUpdate_date(sdf.format(advise.getUpdate_time()));
			advise.setCreate_name(advise.getAnonymous()==0?"匿名":userDAO.getUserNameByID(advise.getCreate_id()));
			if(type==0){
				//提示新的评论和回复
				advise.setRead(true);
				long time=read_userDAO.getRead_userTimeByCondition(1, advise.getId(),create_id);
				if(commentsDAO.getCommentsCountByCondition(1, advise.getId(), create_id, time)>0){
					//有未读的回复
					advise.setRead(false);
				}else{
					List<Comments> commentList=commentsDAO.getCommentsListByCondition(1, advise.getId());
					for (Comments comments : commentList) {
						if(replyDAO.getReplyCountByCondition(comments.getId(), create_id, time)>0){
							advise.setRead(false);
							break;
						}
					}
				}
			}else{
				//提示未读
				if(advise.getCreate_id()!=create_id){
					advise.setRead(read_userDAO.getRead_userIDByCondition(1, advise.getId(), create_id,advise.getUpdate_time())>0);
				}else{
					advise.setRead(true);
				}
			}
		}
		return adviseList;
	}
	@Override
	public int getNewAdviseIDByCreateID(int create_id){
		return adviseDAO.getNewAdviseIDByCreateID(create_id);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List< Advise> getNotReadAdviseList(int create_id){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.M.dd");
		Map map=new HashMap();
		map.put("type", 2);
		map.put("create_id", create_id);
		map.put("starttime", 0);
		map.put("endtime", 0);
		List<Advise> adviseList=adviseDAO.getAdviseListByCondition(map);
		Iterator iterator=adviseList.iterator();
		while (iterator.hasNext()) {
			Advise advise = (Advise) iterator.next();
			if(read_userDAO.getRead_userTimeByCondition(1, advise.getId(),create_id)<advise.getUpdate_time()){
				advise.setUpdate_date(sdf.format(advise.getUpdate_time()));
				advise.setCreate_name(advise.getAnonymous()==0?"匿名":userDAO.getUserNameByID(advise.getCreate_id()));
			}else{
				iterator.remove();
			}
		}
		return adviseList;
	}
	@Override
	public Feedback getFeedbackByID(int id) {
		// TODO Auto-generated method stub
		Feedback feedback=feedbackDAO.getFeedbackByID(id);
		if(feedback!=null){
			feedback.setUpdate_date(new SimpleDateFormat("yyyy-MM-dd").format(feedback.getUpdate_time()));
			feedback.setCreate_name(userDAO.getUserNameByID(feedback.getCreate_id()));
		}
		return feedback;
	}
	@Override
	public void insertFeedback(Feedback feedback) {
		// TODO Auto-generated method stub
		feedbackDAO.insertFeedback(feedback);
	}
	@Override
	public void delFeedbackByID(int id) {
		// TODO Auto-generated method stub
		feedbackDAO.delFeedbackByID(id);
		List<Comments> list=commentsDAO.getCommentsListByCondition(2, id);
		for (Comments comments : list) {
			delCommentsByID(comments.getId());	//删除相关的回复何点赞信息
		}
		related_userDAO.delRelated_userByCondition(3, id, 0);
	}
	@Override
	public void updateFeedback(Feedback feedback) {
		// TODO Auto-generated method stub
		feedbackDAO.updateFeedback(feedback);
	}
	@Override
	public List getFeedbackListByCondition(int create_id,int nowpage,boolean isOnlyMine){
		// TODO Auto-generated method stub
		Map map=new HashMap();
		if(isOnlyMine){
			map.put("create_id", create_id);//只要自己发布
		}else{
			map.put("create_id", 0);
		}
		map.put("nowpage", nowpage*10-10);
		List<Feedback> list=feedbackDAO.getFeedbackListByCondition(map);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		if(isOnlyMine){
			for (Feedback feedback : list) {
				feedback.setCreate_name(userDAO.getUserNameByID(feedback.getCreate_id()));
				feedback.setUpdate_date(sdf.format(feedback.getUpdate_time()));
			}
		}else{
			for (Feedback feedback : list) {
				feedback.setCreate_name(userDAO.getUserNameByID(feedback.getCreate_id()));
				feedback.setUpdate_date(sdf.format(feedback.getUpdate_time()));
				feedback.setRead(read_userDAO.getRead_userIDByCondition(2, feedback.getId(), create_id,feedback.getUpdate_time())>0);
			}
		}
		return list;
	}
	@Override
	public int getFeedbackCountByCondition(int create_id){
		return feedbackDAO.getFeedbackCountByCondition(create_id);
	}
	@Override
	public int getNewFeedbackIDByCreateID(int create_id){
		return feedbackDAO.getNewFeedbackIDByCreateID(create_id);
	}
	@Override
	public List< Feedback> getNotReadFeedBackList(int create_id){
		Map map=new HashMap();
		map.put("create_id", 0);
		map.put("nowpage", -1);
		List<Feedback> list=feedbackDAO.getFeedbackListByCondition(map);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.M.dd");
		Iterator iterator=list.iterator();
		while (iterator.hasNext()) {
			Feedback feedback = (Feedback) iterator.next();
			if(read_userDAO.getRead_userIDByCondition(2, feedback.getId(), create_id,feedback.getUpdate_time())>0){
				iterator.remove();
			}else{
				feedback.setCreate_name(userDAO.getUserNameByID(feedback.getCreate_id()));
				feedback.setUpdate_date(sdf.format(feedback.getUpdate_time()));
			}
		}
		return list;
	}
	@Override
	public Notify getNotifyByID(int id) {
		// TODO Auto-generated method stub
		Notify notify=notifyDAO.getNotifyByID(id);
		if(notify!=null){
			notify.setUpdate_date(new SimpleDateFormat("yyyy-MM-dd").format(notify.getUpdate_time()));
			String publisher=notify.getPublisher();
			if(publisher==null||publisher.length()==0){
				notify.setPublisher(userDAO.getUserNameByID(notify.getCreate_id()));
			}
		}
		return notify;
	}
	@Override
	public void insertNotify(Notify notify) {
		// TODO Auto-generated method stub
		notifyDAO.insertNotify(notify);
	}
	@Override
	public void delNotifyByID(int id) {
		// TODO Auto-generated method stub
		notifyDAO.delNotifyByID(id);
		List<Comments> list=commentsDAO.getCommentsListByCondition(3, id);
		for (Comments comments : list) {
			delCommentsByID(comments.getId());		
		}
		read_userDAO.delRead_userByCondition(3, id, 0);
	}
	@Override
	public void updateNotify(Notify notify) {
		// TODO Auto-generated method stub
		notifyDAO.updateNotify(notify);
	}
	@Override
	public List getNotifyListByCreateID(int create_id,int year){
		long starttime=0l;
		long endtime=0l;
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		if(year>0){
			try {
				starttime=sdf.parse(year+"-01-01").getTime();
				endtime=sdf.parse(year+"-12-32").getTime();//搜一年
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				starttime=1483200000000l;
				endtime=1514736000000l;
			}
		}
		Map map=new HashMap();
		map.put("create_id", create_id);
		map.put("starttime", starttime);
		map.put("endtime", endtime);
		List<Notify> list=notifyDAO.getNotifyListByCreateID(map);
		for (Notify notify : list) {
			String publisher=notify.getPublisher();
			if(publisher==null||publisher.length()==0){
				notify.setPublisher(userDAO.getUserNameByID(notify.getCreate_id()));
			}
			notify.setUpdate_date(sdf.format(notify.getUpdate_time()));
		}
		return list;
	}
	@Override
	public int getNewNotifyIDByCreateID(int create_id) {
		// TODO Auto-generated method stub
		return notifyDAO.getNewNotifyIDByCreateID(create_id);
	}
	@Override
	public List getNotifyListByYear(int year,int maxRow,int uid){
		long starttime=0l;
		long endtime=0l;
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		if(year>0){
			try {
				starttime=sdf.parse(year+"-01-01").getTime();
				endtime=sdf.parse(year+"-12-32").getTime();//搜一年
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				starttime=1483200000000l;
				endtime=1514736000000l;
			}
		}
		Map map=new HashMap();
		map.put("starttime", starttime);
		map.put("endtime", endtime);
		map.put("maxRow", maxRow);
		List< Notify> list=notifyDAO.getNotifyListByYear(map);
		for (Notify notify : list) {
			String publisher=notify.getPublisher();
			if(publisher==null||publisher.length()==0){
				notify.setPublisher(userDAO.getUserNameByID(notify.getCreate_id()));
			}
			notify.setUpdate_date(sdf.format(notify.getUpdate_time()));
			notify.setRead(read_userDAO.getRead_userIDByCondition(3, notify.getId(), uid,notify.getUpdate_time())>0);
		}
		return list;
	}
	@Override
	public Related_user getRelated_userByID(int id) {
		// TODO Auto-generated method stub
		return related_userDAO.getRelated_userByID(id);
	}
	@Override
	public void insertRelated_user(Related_user related_user) {
		// TODO Auto-generated method stub
		related_userDAO.insertRelated_user(related_user);
	}
	@Override
	public void delRelated_userByID(int id) {
		// TODO Auto-generated method stub
		related_userDAO.delRelated_userByID(id);
	}
	@Override
	public void delRelated_userByCondition(int type, int foreign_id, int uid) {
		// TODO Auto-generated method stub
		related_userDAO.delRelated_userByCondition(type, foreign_id, uid);
	}
	@Override
	public List getRelated_userListByCondition(int type, int foreign_id) {
		// TODO Auto-generated method stub
		return related_userDAO.getRelated_userListByCondition(type, foreign_id);
	}
	@Override
	public int getRelated_userCount(int type,int foreign_id,int uid ){
		return related_userDAO.getRelated_userCount(type, foreign_id, uid);
	}
	@Override
	public Comments getCommentsByID(int id) {
		// TODO Auto-generated method stub
		return commentsDAO.getCommentsByID(id);
	}
	@Override
	public void insertComments(Comments comments) {
		// TODO Auto-generated method stub
		commentsDAO.insertComments(comments);
	}
	@Override
	public void delCommentsByID(int id) {
		// TODO Auto-generated method stub
		commentsDAO.delCommentsByID(id);
		related_userDAO.delRelated_userByCondition(2, id, 0);
		List<Reply> list=replyDAO.getReplyListByCommentID(id);
		for (Reply reply : list) {
			related_userDAO.delRelated_userByCondition(3, reply.getId(), 0);
		}
		list.clear();
		list=null;
		replyDAO.delReplyByCommentsID(id);
	}
	@Override
	public List getCommentsListByCondition(int type,int foreign_id,int uid) {
		// TODO Auto-generated method stub
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		List<Comments> commentsList=commentsDAO.getCommentsListByCondition(type, foreign_id);
		int agree=0;//赞同次数
		if(commentsList!=null){
			for (Comments comments : commentsList) {
				comments.setCreate_name(userDAO.getUserNameByID(comments.getCreate_id()));
				comments.setUpdate_date(sdf.format(comments.getUpdate_time()));
				agree=related_userDAO.getRelated_userCount(2, comments.getId(), 0);
				comments.setAgree(agree);
				if(agree>0){
					//判断自己是否对该评论点赞
					agree=related_userDAO.getRelated_userCount(2, comments.getId(), uid);
					comments.setIsagree(agree>0);//没有点赞时自己默认就是为赞同
				}
				List<Reply> replyList=replyDAO.getReplyListByCommentID(comments.getId());
				if(replyList==null){
					replyList=new ArrayList<Reply>();
				}
				for (Reply reply : replyList) {
					reply.setReply_name(userDAO.getUserNameByID(reply.getReply_uid()));
					reply.setCreate_name(userDAO.getUserNameByID(reply.getCreate_id()));
					reply.setUpdate_date(sdf.format(reply.getUpdate_time()));
					agree=related_userDAO.getRelated_userCount(3, reply.getId(), 0);
					reply.setAgree(agree);
					if(agree>0){
						//判断自己是否对该评论点赞
						agree=related_userDAO.getRelated_userCount(3, reply.getId(), uid);
						reply.setIsagree(agree>0);//没有点赞时自己默认就是为赞同
					}
				}
				comments.setReplyList(replyList);
			}
		}
		return commentsList;
	}
	@Override
	public void updateComments(Comments comments) {
		// TODO Auto-generated method stub
		commentsDAO.updateComments(comments);
	}
	@Override
	public int getNewCommentsIDByCreateID(int create_id){
		return commentsDAO.getNewCommentsIDByCreateID(create_id);
	}
	@Override
	public Reply getReplyByID(int id) {
		// TODO Auto-generated method stub
		return replyDAO.getReplyByID(id);
	}
	@Override
	public void insertReply(Reply reply) {
		// TODO Auto-generated method stub
		replyDAO.insertReply(reply);
	}
	@Override
	public void delReplyByID(int id) {
		// TODO Auto-generated method stub
		related_userDAO.delRelated_userByCondition(3, id, 0);
		replyDAO.delReplyByID(id);
	}
	@Override
	public List getReplyListByCommentID(int comment_id) {
		// TODO Auto-generated method stub
		return replyDAO.getReplyListByCommentID(comment_id);
	}
	@Override
	public void updateReply(Reply reply) {
		// TODO Auto-generated method stub
		replyDAO.updateReply(reply);
	}
	@Override
	public int getNewReplyIDByCreateID(int create_id){
		return replyDAO.getNewReplyIDByCreateID(create_id);
	}
	@Override
	public Read_user getRead_userByID(int id) {
		// TODO Auto-generated method stub
		return read_userDAO.getRead_userByID(id);
	}
	@Override
	public void insertRead_user(Read_user read_user) {
		// TODO Auto-generated method stub
		read_userDAO.insertRead_user(read_user);
	}
	@Override
	public void delRead_userByID(int id) {
		// TODO Auto-generated method stub
		read_userDAO.delRead_userByID(id);
	}
	@Override
	public void updateRead_user(int type,int foreign_id,int uid) {
		// TODO Auto-generated method stub
		int id=read_userDAO.getRead_userIDByCondition(type, foreign_id, uid,0);
		Read_user read_user=new Read_user();
		read_user.setType(type);
		read_user.setForeign_id(foreign_id);
		read_user.setUid(uid);
		read_user.setUpdate_time(System.currentTimeMillis());
		if(id>0){//已存在
			read_user.setId(id);
			read_userDAO.updateRead_user(read_user);
		}else{
			read_userDAO.insertRead_user(read_user);
		}
	}
	@Override
	public List<Flow> getNotReadReplyList(int uid){
		List<Flow> list=new ArrayList<Flow>();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		Map map=new HashMap();
		map.put("create_id", uid);
		List<Advise> adviseList=adviseDAO.getNotReadReplyAdviseList(map);
		for (Advise advise : adviseList) {
			Flow flow=new Flow();
			flow.setId(advise.getId());
			flow.setCreate_date(sdf.format(advise.getUpdate_time()));
			flow.setType(10);//前台跳转的标记
			flow.setReason(advise.getTitle());
			flow.setUsername(userDAO.getUserNameByID(advise.getCreate_id()));
			list.add(flow);
		}
		List<Feedback> feedbackList=feedbackDAO.getNotReadReplyFeedbackList(map);
		for (Feedback feedback : feedbackList) {
			Flow flow=new Flow();
			flow.setId(feedback.getId());
			flow.setCreate_date(sdf.format(feedback.getUpdate_time()));
			flow.setType(9);
			flow.setReason(feedback.getTitle());
			flow.setUsername(userDAO.getUserNameByID(feedback.getCreate_id()));
			list.add(flow);
		}
		List<Notify> notifyList=notifyDAO.getNotReadReplyNotifyList(map);
		for (Notify notify : notifyList) {
			Flow flow=new Flow();
			flow.setId(notify.getId());
			flow.setCreate_date(sdf.format(notify.getUpdate_time()));
			flow.setType(1);
			flow.setReason(notify.getTitle());
			flow.setUsername(userDAO.getUserNameByID(notify.getCreate_id()));
			list.add(flow);
		}
		return list;
	}
}
