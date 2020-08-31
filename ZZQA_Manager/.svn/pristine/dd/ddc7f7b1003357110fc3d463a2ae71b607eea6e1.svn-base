package com.zzqa.service.interfaces.communicate;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.advise.Advise;
import com.zzqa.pojo.comments.Comments;
import com.zzqa.pojo.feedback.Feedback;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.notify.Notify;
import com.zzqa.pojo.read_user.Read_user;
import com.zzqa.pojo.related_user.Related_user;
import com.zzqa.pojo.reply.Reply;

/*****
 * 回复
 * @author louph
 *
 */
public interface CommunicateManager {
	public Advise getAdviseByID(int id);
	public void insertAdvise(Advise advise);
	public void delAdviseByID(int id);
	public  void updateAdvise(Advise advise);
	//type 0：本人 1：公开；2：私人
	public int getNotReadAdviseCount(int type,int create_id);
	public List< Advise> getAdviseListByCondition(int type,int create_id,int year);
	public int getNewAdviseIDByCreateID(int create_id);
	//未读建议
	public List< Advise> getNotReadAdviseList(int create_id);
	
	public Feedback getFeedbackByID(int id);
	public void insertFeedback(Feedback feedback);
	public void delFeedbackByID(int id);
	public  void updateFeedback(Feedback feedback);
	public List getFeedbackListByCondition(int create_id,int nowpage,boolean isOnlyMine);
	public int getFeedbackCountByCondition(int create_id);
	public int getNewFeedbackIDByCreateID(int create_id);
	//未读反馈
	public List< Feedback> getNotReadFeedBackList(int create_id);
	
	public Notify getNotifyByID(int id);
	public void insertNotify(Notify notify);
	public void delNotifyByID(int id);
	public  void updateNotify(Notify notify);
	public List getNotifyListByCreateID(int create_id,int year);
	public int getNewNotifyIDByCreateID(int create_id);
	public List getNotifyListByYear(int year,int maxRow,int uid);
	
	public Related_user getRelated_userByID(int id);
	public void insertRelated_user(Related_user related_user);
	public void delRelated_userByID(int id);
	public void delRelated_userByCondition(int type,int foreign_id,int uid);
	public List<Related_user> getRelated_userListByCondition(int type,int foreign_id);
	public int getRelated_userCount(int type,int foreign_id,int uid );
	
	public Comments getCommentsByID(int id);
	public void insertComments(Comments comments);
	public void delCommentsByID(int id);
	//uid表示查询者，用户判断本人是否点赞
	public List<Comments> getCommentsListByCondition(int type,int foreign_id,int uid);
	public  void updateComments(Comments comments);
	public int getNewCommentsIDByCreateID(int create_id);
	
	public Reply getReplyByID(int id);
	public void insertReply(Reply reply);
	public void delReplyByID(int id);
	public List getReplyListByCommentID(int comment_id);
	public  void updateReply(Reply reply);
	public int getNewReplyIDByCreateID(int create_id);
	
	public Read_user getRead_userByID(int id);
	public void insertRead_user(Read_user read_user);
	public void delRead_userByID(int id);
	public  void updateRead_user(int type,int foreign_id,int uid);
	
	public List<Flow> getNotReadReplyList(int uid);
}
