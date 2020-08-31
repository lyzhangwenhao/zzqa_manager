package com.zzqa.dao.interfaces.Reply;

import java.util.List;

import com.zzqa.pojo.reply.Reply;

public interface IReplyDAO {
	public Reply getReplyByID(int id);
	public void insertReply(Reply reply);
	public void delReplyByID(int id);
	public List getReplyListByCommentID(int comments);
	public  void updateReply(Reply reply);
	public void delReplyByCommentsID(int comment_id);
	public int getNewReplyIDByCreateID(int create_id);
	//用户未查看的回复
	public int getReplyCountByCondition(int foreign_id,int create_id,long update_time);
}
