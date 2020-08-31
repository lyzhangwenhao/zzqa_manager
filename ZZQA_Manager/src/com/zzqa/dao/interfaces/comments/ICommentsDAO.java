package com.zzqa.dao.interfaces.comments;

import java.util.List;

import com.zzqa.pojo.comments.Comments;

public interface ICommentsDAO {
	public Comments getCommentsByID(int id);
	public void insertComments(Comments comments);
	public void delCommentsByID(int id);
	public List getCommentsListByCondition(int type,int foreign_id);
	public  void updateComments(Comments comments);
	public int getNewCommentsIDByCreateID(int create_id);
	//用户没看过的回复
	public int getCommentsCountByCondition(int type,int foreign_id,int create_id,long update_time);
}
