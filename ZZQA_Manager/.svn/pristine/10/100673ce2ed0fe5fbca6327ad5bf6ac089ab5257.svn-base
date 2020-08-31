package com.zzqa.dao.impl.reply;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.Reply.IReplyDAO;
import com.zzqa.pojo.comments.Comments;
import com.zzqa.pojo.read_user.Read_user;
import com.zzqa.pojo.reply.Reply;
@Component("replyDAO")
public class ReplyDAOImpl implements IReplyDAO{
	SqlMapClient sqlMapclient = null;
	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")  
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	@Override
	public Reply getReplyByID(int id) {
		// TODO Auto-generated method stub
		Reply reply=null;
		try {
			Object object=sqlMapclient.queryForObject("reply.getReplyByID",id);
			if(object!=null){
				reply=(Reply)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return reply;
	}

	@Override
	public void insertReply(Reply reply) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("reply.insertReply", reply);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delReplyByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("reply.delReplyByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public List getReplyListByCommentID(int comments_id) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("reply.getReplyListByCommentID", comments_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateReply(Reply reply) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("reply.updateReply", reply);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public void delReplyByCommentsID(int comment_id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("reply.delReplyByCommentsID", comment_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public int getNewReplyIDByCreateID(int create_id) {
		// TODO Auto-generated method stub
		int id=0;
		try {
			Object object=sqlMapclient.queryForObject("reply.getNewReplyIDByCreateID", create_id);
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
	public int getReplyCountByCondition(int foreign_id,int create_id,
			long update_time) {
		// TODO Auto-generated method stub
		int count=0;
		Reply reply=new Reply();
		reply.setComment_id(foreign_id);
		reply.setUpdate_time(update_time);
		reply.setCreate_id(create_id);
		try {
			Object object=sqlMapclient.queryForObject("reply.getReplyCountByCondition",reply);
			if(object!=null){
				count=(Integer)object;
			}
		} catch (SQLException e) {
			// TODO: handle exception
		}
		return count;
	}
}
