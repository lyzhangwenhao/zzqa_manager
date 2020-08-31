package com.zzqa.dao.interfaces.performance;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.performance.Performance;
import com.zzqa.pojo.user.User;

public interface IPerformanceDAO {
	public void insertPerformance(Performance performance);
	public void updatePerformance(Performance performance);
	public Performance getPerformanceByID(int id);
	public Performance getPerformanceByMonth(Performance performance);
	public List<Performance> getRunningPerformance();
	public List<Performance> getAllList();
	public boolean checkNumByLeaderId(int uid);
	public List<Performance> getPerformancesByCondition(Map map);
	public List<User> getPerformancesUsers(Map map);
	public Performance getPerformanceByCID(int cid,int startRow);
	public List<Performance> getLastMoncePerformance(int performance_cid);
}
