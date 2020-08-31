package com.zzqa.dao.impl.advise;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.advise.IAdviseDAO;
import com.zzqa.pojo.advise.Advise;
import com.zzqa.pojo.track.Track;
@Component("adviseDAO")
public class AdviseDAOImpl implements IAdviseDAO {
	@Resource(name="sqlMapClient") 
	SqlMapClient sqlMapclient = null;

	@Override
	public Advise getAdviseByID(int id) {
		// TODO Auto-generated method stub
		Advise advise=null;
		try {
			Object object=sqlMapclient.queryForObject("advise.getAdviseByID",id);
			if(object!=null){
				advise=(Advise)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return advise;
	}

	@Override
	public void insertAdvise(Advise advise) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("advise.insertAdvise", advise);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delAdviseByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("advise.delAdviseByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void updateAdvise(Advise advise) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("advise.updateAdvise", advise);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public int getAdviseCountByCondition(int type, int create_id) {
		// TODO Auto-generated method stub
		int count=0;
		Advise advise=new Advise();
		advise.setType(type);
		advise.setCreate_id(create_id);
		try {
			Object object=sqlMapclient.queryForObject("advise.getAdviseCountByCondition", advise);
			if(object!=null){
				count=(Integer)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count;
	}
	@Override
	public List getAdviseListByCondition(Map map) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("advise.getAdviseListByCondition", map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public int getNewAdviseIDByCreateID(int create_id) {
		// TODO Auto-generated method stub
		int id=0;
		try {
			Object object=sqlMapclient.queryForObject("advise.getNewAdviseIDByCreateID",create_id);
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
	public List getNotReadReplyAdviseList(Map map) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("advise.getNotReadReplyAdviseList", map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

}
