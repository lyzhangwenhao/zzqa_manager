package com.zzqa.dao.impl.performance;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.performance.IPerformanceDAO;
import com.zzqa.pojo.performance.Performance;
import com.zzqa.pojo.shipping.Shipping;
import com.zzqa.pojo.user.User;
@Component("performanceDAO")
public class PerformanceDAOImpl implements IPerformanceDAO {
	@Resource(name="sqlMapClient") 
	SqlMapClient sqlMapclient = null;

	@Override
	public void insertPerformance(Performance performance) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("performance.insertPerformance",performance);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void updatePerformance(Performance performance) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("performance.updatePerformance",performance);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Performance getPerformanceByID(int id) {
		// TODO Auto-generated method stub
		Performance performance=null;
		try {
			Object object=sqlMapclient.queryForObject("performance.getPerformanceByID", id);
			if(object!=null){
				performance=(Performance)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return performance;
	}

	@Override
	public Performance getPerformanceByMonth(Performance performance) {
		// TODO Auto-generated method stub
		Performance performance2=null;
		try {
			Object object=sqlMapclient.queryForObject("performance.getPerformanceByMonth", performance);
			if(object!=null){
				performance2=(Performance)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return performance2;
	}

	@Override
	public List<Performance> getRunningPerformance() {
		// TODO Auto-generated method stub
		List<Performance> performances=null;
		try {
			performances=sqlMapclient.queryForList("performance.getRunningPerformance");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return performances;
	}

	@Override
	public List<Performance> getAllList() {
		// TODO Auto-generated method stub
		List<Performance> list=null;
		try {
			list=sqlMapclient.queryForList("performance.getAllList");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public boolean checkNumByLeaderId(int uid) {
		// TODO Auto-generated method stub
		int num=0;
		try {
			Object object=sqlMapclient.queryForObject("performance.checkNumByLeaderId",uid);
			if(object!=null){
				num=(Integer)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num>0;
	}

	@Override
	public List<Performance> getPerformancesByCondition(Map map) {
		// TODO Auto-generated method stub1533052800000
		List<Performance> list=null;
		try {
			list=sqlMapclient.queryForList("performance.getPerformancesByCondition",map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public List<User> getPerformancesUsers(Map map) {
		// TODO Auto-generated method stub
		List<User> list=null;
		try {
			list=sqlMapclient.queryForList("performance.getPerformancesUsers",map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Performance getPerformanceByCID(int cid,int startRow) {
		Map map = new HashMap();
		Performance performance=null;
		try {
			map.put("startRow", startRow);
			map.put("cid", cid);
			Object object=sqlMapclient.queryForObject("performance.getPerformanceByCID", map);
			if(object!=null){
				performance=(Performance)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return performance;
	}

	@Override
	public List<Performance> getLastMoncePerformance(int performance_cid) {
		// TODO Auto-generated method stub
		List<Performance> list=null;
		try {
			list=sqlMapclient.queryForList("performance.getLastMoncePerformance", performance_cid);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
