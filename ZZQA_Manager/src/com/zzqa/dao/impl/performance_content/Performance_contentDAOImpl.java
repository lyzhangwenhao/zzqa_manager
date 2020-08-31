package com.zzqa.dao.impl.performance_content;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.performance_content.IPerformance_contentDAO;
import com.zzqa.pojo.performance_content.Performance_content;
@Component("performance_contentDAO")
public class Performance_contentDAOImpl implements IPerformance_contentDAO{
	@Resource(name="sqlMapClient") 
	SqlMapClient sqlMapclient = null;

	@Override
	public void insertPerformance_content(
			Performance_content performance_content) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("performance_content.insertPerformance_content",performance_content);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delPerformance_content(int p_id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("performance_content.delPerformance_content", p_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public List<Performance_content> getPerformance_contentListByPID(int p_id) {
		// TODO Auto-generated method stub
		try {
			return sqlMapclient.queryForList("performance_content.getPerformance_contentListByPID", p_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
}
