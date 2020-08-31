package com.zzqa.dao.impl.deliver_content;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.deliver_content.IDeliver_contentDAO;
import com.zzqa.pojo.deliver_content.Deliver_content;
@Repository("deliver_contentDAO")
public class Deliver_contentDAOImpl implements IDeliver_contentDAO {
	@Resource(name="sqlMapClient")
	SqlMapClient sqlMapclient = null;
	@Override
	public List<Deliver_content> getItemsByDid(int deliver_id) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("deliver_content.getItemsByDid",deliver_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public void insertDeliverContent(Deliver_content deliver_content) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("deliver_content.insertDeliverContent",deliver_content);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public void updateDeliverContent(Deliver_content deliver_content) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("deliver_content.updateDeliverContent",deliver_content);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public void delDeliverContent(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("deliver_content.delDeliverContent", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
