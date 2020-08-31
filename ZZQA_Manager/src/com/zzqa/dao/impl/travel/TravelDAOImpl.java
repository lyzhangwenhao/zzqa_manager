package com.zzqa.dao.impl.travel;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.travel.ITravelDAO;
import com.zzqa.pojo.travel.Travel;
@Component("travelDAO")
public class TravelDAOImpl implements ITravelDAO {
	SqlMapClient sqlMapclient = null;
	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	@Override
	public void updateTravel(Travel travel) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("travel.updateTravel", travel);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void insertTravel(Travel travel) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("travel.insertTravel", travel);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Travel getTravelByID(int id) {
		// TODO Auto-generated method stub
		Travel travel=null;
		try {
			Object obj=sqlMapclient.queryForObject("travel.getTravelByID", id);
			travel=(Travel) obj;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return travel;
	}
	
	@Override
	public void delTravelByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("travel.delTravelByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Travel getNewTravelByCreateID(int create_id) {
		// TODO Auto-generated method stub
		Travel travel=null;
		try {
			Object obj=sqlMapclient.queryForObject("travel.getNewTravelByCreateID", create_id);
			travel=(Travel) obj;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return travel;
	}

	@Override
	public List getAllTravelList() {
		// TODO Auto-generated method stub
		List<Travel> list=null;
		try {
			list=sqlMapclient.queryForList("travel.getAllTravelList");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List getRunningTravel() {
		// TODO Auto-generated method stub
		List<Travel> list=null;
		try {
			list=sqlMapclient.queryForList("travel.getRunningTravel");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List getTravelListAfterApproval(int create_id) {
		// TODO Auto-generated method stub
		List<Travel> list=null;
		try {
			list=sqlMapclient.queryForList("travel.getTravelListAfterApproval",create_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public List getTravelListReport(Map map) {
		// TODO Auto-generated method stub
		List<Travel> list=null;
		try {
			list=sqlMapclient.queryForList("travel.getTravelListReport",map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public boolean checkTravelInScope(Map map) {
		// TODO Auto-generated method stub
		try {
			Object object=sqlMapclient.queryForObject("travel.checkTravelInScope",map);
			if(object!=null&&(Integer)object>0){
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	public List getAllList(){
		List list = null;
		try {
            list = sqlMapclient.queryForList("travel.getAllList");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
}
