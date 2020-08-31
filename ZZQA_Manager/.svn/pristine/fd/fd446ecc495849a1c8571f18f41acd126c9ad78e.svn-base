package com.zzqa.service.interfaces.resumption;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.leave.Leave;
import com.zzqa.pojo.resumption.Resumption;
import com.zzqa.pojo.user.User;
/****
 * 销假单
 * @author louph
 *
 */
public interface ResumptionManager {
	public void updateResumption(Resumption resumption);
	public void insertResumption(Resumption resumption);
	public void delResumptionByID(int id);
	public Resumption getResumptionByID(int id);
	public Resumption getNewResumptionByCreateID(int create_id);
	public List getAllResumptionlList();
	/*****
	 * 计算绘制流程的class
	 * @param id
	 * @return
	 */
	public Map<String,String> getResumptionFlowForDraw(Resumption resumption,Flow flow);
	//等待用户操作的生产流程
	public List<Resumption> getResumptionListByUID(User user);
	public Resumption getResumptionByID2(int id);
	//检查是否可以审批
	public boolean checkResumptionCan(int operation,Resumption resumption,User user);
	//检查是否可以备案
	public boolean checkResumptionBackUp(int operation,Resumption resumption,User user);
	/****
	 * 查询是否有销假，并返回
	 * @param type
	 * @param foreign_id
	 * @return
	 */
	public Resumption getFinishedResumption(int type,int foreign_id);
}
