package com.zzqa.dao.impl.comments;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.comments.ICommentsDAO;
import com.zzqa.pojo.comments.Comments;
import com.zzqa.pojo.read_user.Read_user;
@Component("commentsDAO")
public class CommentsDAOImpl implements ICommentsDAO {
	SqlMapClient sqlMapclient = null;
	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")  
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	@Override
	public Comments getCommentsByID(int id) {
		// TODO Auto-generated method stub
		Comments comments=null;
		try {
			Object object=sqlMapclient.queryForObject("comments.getCommentsByID",id);
			if(object!=null){
				comments=(Comments)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return comments;
	}

	@Override
	public void insertComments(Comments comments) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("comments.insertComments", comments);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delCommentsByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("comments.delCommentsByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public List getCommentsListByCondition(int type, int foreign_id) {
		// TODO Auto-generated method stub
		List list=null;
		Comments comments=new Comments();
		comments.setType(type);
		comments.setForeign_id(foreign_id);
		try {
			list=sqlMapclient.queryForList("comments.getCommentsListByCondition",comments);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateComments(Comments comments) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("comments.updateComments", comments);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public int getNewCommentsIDByCreateID(int create_id) {
		// TODO Auto-generated method stub
		int id=0;
		try {
			Object object=sqlMapclient.queryForObject("comments.getNewCommentsIDByCreateID",create_id);
			if(object!=null){
				id=(Integer)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return id;
	}
	@Override
	public int getCommentsCountByCondition(int type, int foreign_id,int create_id,
			long update_time) {
		// TODO Auto-generated method stub
		int count=0;
		Comments comments=new Comments();
		comments.setType(type);
		comments.setForeign_id(foreign_id);
		comments.setUpdate_time(update_time);
		comments.setCreate_id(create_id);
		try {
			Object object=sqlMapclient.queryForObject("comments.getCommentsCountByCondition",comments);
			if(object!=null){
				count=(Integer)object;
			}
		} catch (SQLException e) {
			// TODO: handle exception
		}
		return count;
	}

}
