package com.zzqa.dao.impl.feedback;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.feedback.IFeedbackDAO;
import com.zzqa.pojo.feedback.Feedback;
@Component("feedbackDAO")
public class FeedbackDAOImpl implements IFeedbackDAO {
	SqlMapClient sqlMapclient = null;
	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")  
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	@Override
	public Feedback getFeedbackByID(int id) {
		// TODO Auto-generated method stub
		Feedback feedback=null;
		try {
			Object object=sqlMapclient.queryForObject("feedback.getFeedbackByID", id);
			if(object!=null){
				feedback=(Feedback)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return feedback;
	}

	@Override
	public void insertFeedback(Feedback feedback) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("feedback.insertFeedback", feedback);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delFeedbackByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("feedback.delFeedbackByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void updateFeedback(Feedback feedback) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("feedback.updateFeedback", feedback);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public List getFeedbackListByCondition(Map map) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("feedback.getFeedbackListByCondition",map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public int getFeedbackCountByCondition(int create_id) {
		// TODO Auto-generated method stub
		int count=0;
		Map map=new HashMap();
		map.put("create_id", create_id);
		try {
			Object object=sqlMapclient.queryForObject("feedback.getFeedbackCountByCondition",map);
			count=(Integer)object;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count;
	}
	@Override
	public int getNewFeedbackIDByCreateID(int create_id) {
		// TODO Auto-generated method stub
		int id=0;
		try {
			Object object=sqlMapclient.queryForObject("feedback.getNewFeedbackIDByCreateID", create_id);
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
	public List getNotReadReplyFeedbackList(Map map) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("feedback.getNotReadReplyFeedbackList", map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
