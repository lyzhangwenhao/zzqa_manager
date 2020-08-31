package com.zzqa.service.impl.performance;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zzqa.dao.interfaces.performance.IPerformanceDAO;
import com.zzqa.dao.interfaces.performance_content.IPerformance_contentDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.customer_data.Customer_data;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.performance.Performance;
import com.zzqa.pojo.performance_content.Performance_content;
import com.zzqa.pojo.sales_contract.Sales_contract;
import com.zzqa.pojo.shipping.Shipping;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.performance.PerformanceManager;
import com.zzqa.util.DataUtil;
@Service("performanceManager")
public class PerformanceManagerImpl implements PerformanceManager {
	@Autowired
	private IUserDAO userDAO;
	@Autowired
	private IPerformanceDAO performanceDAO;
	@Autowired
	private IPerformance_contentDAO performance_contentDAO;
	@Override
	public void insertPerformance(Performance performance) {
		// TODO Auto-generated method stub
		performanceDAO.insertPerformance(performance);
	}
	@Override
	public void updatePerformance(Performance performance) {
		// TODO Auto-generated method stub
		performanceDAO.updatePerformance(performance);
	}

	@Override
	public Performance getPerformanceByID(int id) {
		// TODO Auto-generated method stub
		return performanceDAO.getPerformanceByID(id);
	}

	@Override
	public Performance getPerformanceByMonth(int create_id,long performance_month) {
		// TODO Auto-generated method stub
		Performance performance=new Performance();
		performance.setCreate_id(create_id);
		performance.setPerformance_month(performance_month);
		return performanceDAO.getPerformanceByMonth(performance);
	}
	@Override
	public void insertPerformanceContent(Performance_content performance_content) {
		// TODO Auto-generated method stub
		performance_contentDAO.insertPerformance_content(performance_content);
	}

	@Override
	public void delPerformance_content(int p_id) {
		// TODO Auto-generated method stub
		performance_contentDAO.delPerformance_content(p_id);
	}
	@Override
	public List<Performance_content> getPerformance_contentListByPID(int p_id){
		return performance_contentDAO.getPerformance_contentListByPID(p_id);
	}

	@Override
	public List<Performance> getPerformanceListByUID(User mUser) {
		// TODO Auto-generated method stub
		//只显示operation==3的流程
		List<Performance> list=new ArrayList<Performance>();
		List<Performance> performances=performanceDAO.getRunningPerformance();//查询所有未完成的考核
		if(performances == null){
			return list;
		}
		SimpleDateFormat sdf=DataUtil.getSdf("yyyy.MM.dd");
		String[] flowArray19=DataUtil.getFlowArray(19);
		long nowTime=System.currentTimeMillis();
		Calendar cal = Calendar.getInstance();
		for(Performance performance:performances){
			User userByID = userDAO.getUserByID(performance.getCreate_id());
			if(userByID==null || userByID.getPosition_id()==56){
				continue;
			}
			int opera=performance.getOperation();
			cal.setTime(new Date(performance.getPerformance_month()));
			int year=cal.get(Calendar.YEAR);
			int month=cal.get(Calendar.MONTH);
			if(checkMyOperation(opera,mUser,performance,cal,nowTime)){
				StringBuilder sbBuilder=new StringBuilder().append(year).append("年").append(month+1);
				if(opera<4||opera==7){
					sbBuilder.append("月计划");
				}else{
					sbBuilder.append("月考核");
				}
				/*StringBuilder sbBuilder=new StringBuilder().append(year).append("年").append(month+1).append("月、");
				if(month<11){
					if(opera<4){
						sbBuilder.append(month+2).append("月计划");
					}else{
						sbBuilder.append(month+2).append("月考核");
					}
				}else{
					if(opera<4){
						sbBuilder.append(year+1).append("年").append("1月计划");
					}else{
						sbBuilder.append(year+1).append("年").append("1月考核");
					}
				}*/
				performance.setName(sbBuilder.toString());
				performance.setProcess(sdf.format(performance.getUpdate_time())+flowArray19[opera]);
				list.add(performance);
			}
		}
		return list;
	}
	private boolean checkMyOperation(int opera, User mUser,
			Performance performance,Calendar cal,long nowTime) {
		// TODO Auto-generated method stub
		switch (opera) {
		case 3:
			if(performance.getLeader()==7){
				cal.add(Calendar.MONTH, 3);
			}else{
				cal.add(Calendar.MONTH, 1);
			}
			long time_diff=nowTime-cal.getTime().getTime();
			if(performance.getLeader()==7){
				Calendar cals = Calendar.getInstance();
				int month = cals.get(Calendar.MONTH) + 1;
				
				//获取当前天数
//				int day = cals.get(Calendar.DAY_OF_MONTH);
				if(month==1 || month==4 || month==7 || month==10){
					return (time_diff<691200000&&time_diff>-259200000)&&performance.getCreate_id()==mUser.getId();
				}
				if(month==3 || month==6 || month==9 || month==12){
					return (time_diff<691200000&&time_diff>-259200000)&&performance.getCreate_id()==mUser.getId();
				}
				return false;
				
			}
			//月底前三天至下月8日前
			return (time_diff<691200000&&time_diff>-259200000)&&performance.getCreate_id()==mUser.getId();
		case 5:
			return performance.getLeader()==mUser.getId();
		case 7:
			if(performance.getId()==932){//特殊处理 这个数据除了问题  只能特殊处理
				return false;
			}
			return performance.getCreate_id()==mUser.getId();
		default:
			break;
		}
		return false;
	}
	@Override
	public boolean checkNumByLeaderId(int uid) {
		// TODO Auto-generated method stub
		return performanceDAO.checkNumByLeaderId(uid);
	}
	@Override
	public List<Performance> getPerformancesByCondition(Map map) {
		// TODO Auto-generated method stub
		return performanceDAO.getPerformancesByCondition(map);
	}
	@Override
	public Performance getPerformanceByCID(int cid,int startRow) {
		// TODO Auto-generated method stub
		return performanceDAO.getPerformanceByCID(cid,startRow);
	}
	@Override
	public List<Performance> getLastMoncePerformance(int performance_cid) {
		// TODO Auto-generated method stub
		return performanceDAO.getLastMoncePerformance(performance_cid);
	}
	
}
