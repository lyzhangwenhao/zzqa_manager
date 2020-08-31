package com.zzqa.service.impl.aftersales_task;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.xml.crypto.Data;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.zzqa.dao.interfaces.aftersales_task.IAftersales_taskDAO;
import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.position_user.IPosition_userDAO;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.aftersales_task.Aftersales_task;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.aftersales_task.Aftersales_taskManager;
import com.zzqa.util.DataUtil;
@Service("aftersales_taskManager")
public class Aftersales_taskManagerImpl implements Aftersales_taskManager {
	@Resource(name="aftersales_taskDAO")
	private IAftersales_taskDAO aftersales_taskDAO;
	@Resource(name="userDAO")
	private IUserDAO userDAO;
	@Resource(name="permissionsDAO")
	private IPermissionsDAO permissionsDAO;
	@Resource(name="position_userDAO")
	private IPosition_userDAO position_userDAO;
	@Resource(name="flowDAO")
	private IFlowDAO flowDAO;

	@Override
	public int insertAlterSales_Task(Aftersales_task aftersales_task) {
		// TODO Auto-generated method stub
		aftersales_taskDAO.insertAlterSales_Task(aftersales_task);
		return aftersales_taskDAO.getNewAlterSales_TaskIDByCreateID(aftersales_task.getCreate_id());
	}

	@Override
	public void updateAlterSales_Task(Aftersales_task aftersales_task) {
		// TODO Auto-generated method stub
		aftersales_taskDAO.updateAlterSales_Task(aftersales_task);
	}

	@Override
	public Aftersales_task getAlterSales_TaskByID(int id) {
		// TODO Auto-generated method stub
		return aftersales_taskDAO.getAlterSales_TaskByID(id);
	}

	@Override
	public void delAlterSales_TaskByID(int id) {
		// TODO Auto-generated method stub
		aftersales_taskDAO.delAlterSales_TaskByID(id);
	}
	
	@Override
	public Aftersales_task getAlterSales_TaskByID2(int id) {
		// TODO Auto-generated method stub
		Aftersales_task aftersales_task=aftersales_taskDAO.getAlterSales_TaskByID(id);
		SimpleDateFormat format = new SimpleDateFormat( "yyyy.MM.dd" );
		Flow flow=flowDAO.getNewFlowByFID(13, aftersales_task.getId());
		String process=format.format(flow.getCreate_time())+DataUtil.getFlowArray(13)[flow.getOperation()];
		aftersales_task.setName(aftersales_task.getProject_name()+"-"+aftersales_task.getProject_id());
		aftersales_task.setProcess(process);
		aftersales_task.setCreate_name(userDAO.getUserNameByID(aftersales_task.getCreate_id()));
		return aftersales_task;
	}
	@Override
	public List<Aftersales_task> getAftersales_taskByUID(User user) {
		// TODO Auto-generated method stub
		List<Aftersales_task> taskList=aftersales_taskDAO.getRunningAlterSales_Task();
		SimpleDateFormat format = new SimpleDateFormat( "yyyy.MM.dd" );
		String[] flowArray=DataUtil.getFlowArray(13);
		if(taskList!=null){
			Iterator<Aftersales_task> iterator=taskList.iterator();
			while (iterator.hasNext()) {
				Aftersales_task aftersales_task=(Aftersales_task)iterator.next();
				User userByID = userDAO.getUserByID(aftersales_task.getCreate_id());
				if(userByID==null || userByID.getPosition_id()==56){
					iterator.remove();
					continue;
				}
				Flow flow=flowDAO.getNewFlowByFID(13, aftersales_task.getId());//查询最新流程
				if(flow!=null&&checkMyOperation(flow.getOperation(),user,aftersales_task)){
					String process=format.format(flow.getCreate_time())+flowArray[flow.getOperation()];
					aftersales_task.setProcess(process);
					aftersales_task.setName(aftersales_task.getProject_name()+"-"+aftersales_task.getProject_id());
					aftersales_task.setCreate_name(userByID.getTruename());
				}else{
					iterator.remove();
				}
			}
		}
		return taskList;
	}
	private boolean checkMyOperation(int operation,User user,Aftersales_task aftersales_task){
		boolean flag=false;
		int position_id=user.getPosition_id();
		int project_category=aftersales_task.getProject_category();
 		switch (operation) {
		case 1:
			flag=permissionsDAO.checkPermission(position_id, DataUtil.getAfterSaleApproveArray()[project_category]);
			break;
		case 2:
			flag=permissionsDAO.checkPermission(position_id, DataUtil.getAfterSaleAssistantArray()[project_category]);
			break;
		case 3:
			flag=aftersales_task.getCreate_id()==user.getId();
			break;
		case 4:
			flag=aftersales_task.getCreate_id()==user.getId();
			break;
		case 5:
			flag=permissionsDAO.checkPermission(position_id, DataUtil.getAfterSaleAssistantArray()[project_category]);
			break;
		case 6:
			flag=permissionsDAO.checkPermission(position_id, DataUtil.getAfterSaleApproveArray()[project_category]);
			break;
		case 8:
			flag=permissionsDAO.checkPermission(position_id, DataUtil.getAfterSaleAssistantArray()[project_category]);
			break;
		case 10:
			flag=permissionsDAO.checkPermission(position_id, DataUtil.getAfterSaleAssistantArray()[project_category]);
			break;
		default:
			break;
		}
		return flag;
	}
	@Override
	public Map<String, String> getTaskFlowForDraw(Aftersales_task aftersales_task, Flow flow) {
		// TODO Auto-generated method stub
		int operation=flow.getOperation();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd#HH:mm:ss");
		List<Flow> flowList=flowDAO.getFlowListByCondition(13,aftersales_task.getId());
		Map<String, String> map=new HashMap<String, String>();
		String title1_flow="title1_flow1";
		String title2_flow="title2_flow1";
		String title3_flow="title3_flow1";
		String color1=null;
		String color2=null;
		String color3=null;
		String color4=null;
		String color5=null;
		String color6=null;
		String color7=null;
		String img1=null;
		String img2=null;
		String img3=null;
		String img4=null;
		String img5=null;
		String img6=null;
		String img7=null;
		String bg_color1=null;
		String bg_color2=null;
		String bg_color3=null;
		String bg_color4=null;
		String bg_color5=null;
		String bg_color6=null;
		String time1=null;
		String time2=null;
		String time3=null;
		String time4=null;
		String time5=null;
		String time6=null;
		String time7=null;
		if(operation==1){
			color1="color_did";
			color2="color_nodid";
			color3="color_nodid";
			color4="color_nodid";
			color5="color_nodid";
			color6="color_nodid";
			color7="color_nodid";
			img1="pass.png";
			img2="go.png";
			img3="notdid.png";
			img4="notdid.png";
			img5="notdid.png";
			img6="notdid.png";
			img7="notdid.png";
			bg_color1="background_color_did";
			bg_color2="background_color_nodid";
			bg_color3="background_color_nodid";
			bg_color4="background_color_nodid";
			bg_color5="background_color_nodid";
			bg_color6="background_color_nodid";
			time1=sdf.format(aftersales_task.getCreate_time()).replace("#", "<br/>");
		}else if(operation==2){
			color1="color_did";
			color2="color_did";
			color3="color_nodid";
			color4="color_nodid";
			color5="color_nodid";
			color6="color_nodid";
			color7="color_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="go.png";
			img4="notdid.png";
			img5="notdid.png";
			img6="notdid.png";
			img7="notdid.png";
			bg_color1="background_color_did";
			bg_color2="background_color_did";
			bg_color3="background_color_nodid";
			bg_color4="background_color_nodid";
			bg_color5="background_color_nodid";
			bg_color6="background_color_nodid";
			time1=sdf.format(aftersales_task.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==3){
			color1="color_did";
			color2="color_error";
			color3="color_nodid";
			color4="color_nodid";
			color5="color_nodid";
			color6="color_nodid";
			color7="color_nodid";
			img1="pass.png";
			img2="error.png";
			img3="notdid.png";
			img4="notdid.png";
			img5="notdid.png";
			img6="notdid.png";
			img7="notdid.png";
			bg_color1="background_color_error";
			bg_color2="background_color_nodid";
			bg_color3="background_color_nodid";
			bg_color4="background_color_nodid";
			bg_color5="background_color_nodid";
			bg_color6="background_color_nodid";
			time1=sdf.format(aftersales_task.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==4){
			color1="color_did";
			color2="color_did";
			color3="color_did";
			color4="color_nodid";
			color5="color_nodid";
			color6="color_nodid";
			color7="color_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="pass.png";
			img4="go.png";
			img5="notdid.png";
			img6="notdid.png";
			img7="notdid.png";
			bg_color1="background_color_did";
			bg_color2="background_color_did";
			bg_color3="background_color_did";
			bg_color4="background_color_nodid";
			bg_color5="background_color_nodid";
			bg_color6="background_color_nodid";
			time1=sdf.format(aftersales_task.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==5){
			color1="color_did";
			color2="color_did";
			color3="color_did";
			color4="color_did";
			color5="color_nodid";
			color6="color_nodid";
			color7="color_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="pass.png";
			img4="pass.png";
			img5="go.png";
			img6="notdid.png";
			img7="notdid.png";
			bg_color1="background_color_did";
			bg_color2="background_color_did";
			bg_color3="background_color_did";
			bg_color4="background_color_did";
			bg_color5="background_color_nodid";
			bg_color6="background_color_nodid";
			time1=sdf.format(aftersales_task.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
			time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==6){
			color1="color_did";
			color2="color_did";
			color3="color_did";
			color4="color_did";
			color5="color_did";
			color6="color_nodid";
			color7="color_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="pass.png";
			img4="pass.png";
			img5="pass.png";
			img6="go.png";
			img7="notdid.png";
			bg_color1="background_color_did";
			bg_color2="background_color_did";
			bg_color3="background_color_did";
			bg_color4="background_color_did";
			bg_color5="background_color_did";
			bg_color6="background_color_nodid";
			time1=sdf.format(aftersales_task.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
			time4=sdf.format(lastFlowTime(5, flowList)).replace("#", "<br/>");
			time5=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==7){
			color1="color_did";
			color2="color_did";
			color3="color_did";
			color4="color_did";
			color5="color_did";
			color6="color_did";
			color7="color_did";
			img1="pass.png";
			img2="pass.png";
			img3="pass.png";
			img4="pass.png";
			img5="pass.png";
			img6="pass.png";
			img7="pass.png";
			bg_color1="background_color_did";
			bg_color2="background_color_did";
			bg_color3="background_color_did";
			bg_color4="background_color_did";
			bg_color5="background_color_did";
			bg_color6="background_color_did";
			time1=sdf.format(aftersales_task.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
			time4=sdf.format(lastFlowTime(5, flowList)).replace("#", "<br/>");
			time5=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
			time6=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			time7=time6;
		}else if(operation==8){
			color1="color_did";
			color2="color_did";
			color3="color_did";
			color4="color_did";
			color5="color_did";
			color6="color_error";
			color7="color_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="pass.png";
			img4="pass.png";
			img5="pass.png";
			img6="error.png";
			img7="notdid.png";
			bg_color1="background_color_did";
			bg_color2="background_color_did";
			bg_color3="background_color_did";
			bg_color4="background_color_did";
			bg_color5="background_color_error";
			bg_color6="background_color_nodid";
			time1=sdf.format(aftersales_task.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
			time4=sdf.format(lastFlowTime(5, flowList)).replace("#", "<br/>");
			time5=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
			time6=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==9){
			title1_flow="title1_flow0";
			title2_flow="title2_flow0";
			title3_flow="title3_flow0";
			color1="color_did";
			color7="color_error";
			img1="pass.png";
			img7="error.png";
			bg_color6="background_color_error";
			time1=sdf.format(aftersales_task.getCreate_time()).replace("#", "<br/>");
			time7=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==10){
			color1="color_did";
			color2="color_did";
			color3="color_did";
			color4="color_hangupdid";
			color5="color_nodid";
			color6="color_nodid";
			color7="color_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="pass.png";
			img4="hangup.png";
			img5="notdid.png";
			img6="notdid.png";
			img7="notdid.png";
			bg_color1="background_color_did";
			bg_color2="background_color_did";
			bg_color3="background_color_hangupdid";
			bg_color4="background_color_nodid";
			bg_color5="background_color_nodid";
			bg_color6="background_color_nodid";
			time1=sdf.format(aftersales_task.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
			time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}
		map.put("title1_flow", title1_flow);
		map.put("title2_flow", title2_flow);
		map.put("title3_flow", title3_flow);
		map.put("color1", color1);
		map.put("color2", color2);
		map.put("color3", color3);
		map.put("color4", color4);
		map.put("color5", color5);
		map.put("color6", color6);
		map.put("color7", color7);
		map.put("img1", img1);
		map.put("img2", img2);
		map.put("img3", img3);
		map.put("img4", img4);
		map.put("img5", img5);
		map.put("img6", img6);
		map.put("img7", img7);
		map.put("bg_color1", bg_color1);
		map.put("bg_color2", bg_color2);
		map.put("bg_color3", bg_color3);
		map.put("bg_color4", bg_color4);
		map.put("bg_color5", bg_color5);
		map.put("bg_color6", bg_color6);
		map.put("time1", time1);
		map.put("time2", time2);
		map.put("time3", time3);
		map.put("time4", time4);
		map.put("time5", time5);
		map.put("time6", time6);
		map.put("time7", time7);
		return map;
	}
	private long lastFlowTime(int operation,List<Flow> flowList){
		int len=flowList.size();
		for (int i = 0; i < len; i++) {
			if(flowList.get(len-i-1).getOperation()==operation){
				return flowList.get(len-i-1).getCreate_time();
			}
		}
		return 0;//没有就返回0
	}
	@Override
	public boolean checkCanApply(Aftersales_task aftersales_task, User user,
			int operation) {
		// TODO Auto-generated method stub
		int create_id=aftersales_task.getCreate_id();
		int position_id=user.getPosition_id();
		int project_category=aftersales_task.getProject_category();
		int approve_pid=DataUtil.getAfterSaleApproveArray()[project_category];
		switch (operation) {
		case 1:
			return permissionsDAO.checkPermission(position_id, approve_pid);
		case 3:
			return permissionsDAO.checkPermission(position_id, approve_pid);
		case 6:
			return permissionsDAO.checkPermission(position_id, approve_pid);
		case 8:
			return permissionsDAO.checkPermission(position_id, approve_pid);
		default:
			break;
		}
		return false;
	}
}
