package com.zzqa.dao.impl.deliver;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.deliver.IDeliverDAO;
import com.zzqa.pojo.deliver.Deliver;
import com.zzqa.pojo.deliver_content.Deliver_content;
@Component("deliverDAO")
public class DeliverDAOImpl implements IDeliverDAO {
	@Resource(name="sqlMapClient")
	SqlMapClient sqlMapclient = null;

	@Override
	public Deliver getDeliverByID(int deliver_id) {
		// TODO Auto-generated method stub
		Deliver deliver=null;
		try {
			Object object=sqlMapclient.queryForObject("deliver.getDeliverByID",deliver_id);
			if(object!=null){
				deliver=(Deliver)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return deliver;
	}

	@Override
	public void insertDeliver(Deliver deliver) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("deliver.insertDeliver",deliver);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public void updateDeliver(Deliver deliver) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("deliver.updateDeliver",deliver);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public List<Deliver> getRunningDeliver() {
		// TODO Auto-generated method stub
		List<Deliver> list=null;
		try {
			list=sqlMapclient.queryForList("deliver.getRunningDeliver");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			list=new ArrayList<Deliver>();
		}
		return list;
	}

	@Override
	public List<Deliver> getAllList() {
		// TODO Auto-generated method stub
		List<Deliver> list=null;
		try {
			list=sqlMapclient.queryForList("deliver.getAllList");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			list=new ArrayList<Deliver>();
		}
		return list;
	}
	
}
