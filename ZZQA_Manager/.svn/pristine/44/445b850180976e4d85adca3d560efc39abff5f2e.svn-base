package com.zzqa.service.interfaces.performance;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.performance.Performance;
import com.zzqa.pojo.performance_content.Performance_content;
import com.zzqa.pojo.user.User;

public interface PerformanceManager {

	public void insertPerformance(Performance performance);
	public void updatePerformance(Performance performance);
	public Performance getPerformanceByID(int id);
	public Performance getPerformanceByCID(int cid,int startRow);
	public Performance getPerformanceByMonth(int create_id,long performance_month);

	void insertPerformanceContent(Performance_content performance_content);

	void delPerformance_content(int p_id);
	public List<Performance_content> getPerformance_contentListByPID(int id);
	public List<Performance> getPerformanceListByUID(User mUser);
	public boolean checkNumByLeaderId(int uid);
	public List<Performance> getPerformancesByCondition(Map map);
	//获取该条记录的最后记录
	public List<Performance> getLastMoncePerformance(int performance_cid);

}
