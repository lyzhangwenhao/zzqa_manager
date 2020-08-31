package com.zzqa.service.impl.task;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.jsp.tagext.FunctionInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.position_user.IPosition_userDAO;
import com.zzqa.dao.interfaces.task.ITaskDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.task.TaskManager;
import com.zzqa.servlet.DelayEmailServlet;
import com.zzqa.util.DataUtil;
@Component("taskManager")
public class TaskManagerImpl implements TaskManager {
	@Autowired
	private ITaskDAO taskDAO;
	@Autowired
	private IPosition_userDAO position_userDAO;
	@Autowired
	private IFlowDAO flowDAO;
	@Autowired
	private IUserDAO userDAO;
	@Autowired
	private IPermissionsDAO permissionsDAO;
	
	public void delTaskByCreateID(int create_id) {
		// TODO Auto-generated method stub
		taskDAO.delTaskByCreateID(create_id);
	}

	public void delTaskByID(int id) {
		// TODO Auto-generated method stub
		taskDAO.delTaskByID(id);
	}

	private List<Task> addTime(List<Task> list){
		List<Task> taskList=list;
		SimpleDateFormat format = new SimpleDateFormat( "yyyy.MM.dd" );
		String[] flowArray=DataUtil.getFlowArray(1);
		for(Task task:taskList){
			if(task==null){
				continue;
			}
			Flow flow=flowDAO.getNewFlowByFID(1, task.getId());//查询某任务单的最新流程
			if(flow==null){
				continue;
			}
			String process=format.format(flow.getCreate_time())+flowArray[flow.getOperation()];
			task.setProcess(process);
		}
		return taskList;
	}

	public Task getTaskByID(int id) {
		// TODO Auto-generated method stub
		Task task=taskDAO.getTaskByID(id);
		if(task!=null){
			SimpleDateFormat format = new SimpleDateFormat( "yyyy-MM-dd" );
			task.setDelivery_timestr(format.format(task.getDelivery_time()));
			if(task.getType()==1){
				task.setContract_timestr(format.format(task.getContract_time()));
			}
		}
		return task;
	}
	public Task getTaskByID2(int id) {
		// TODO Auto-generated method stub
		Task task=taskDAO.getTaskByID(id);
		SimpleDateFormat format = new SimpleDateFormat( "yyyy.MM.dd" );
		Flow flow=flowDAO.getNewFlowByFID(1, task.getId());//查询某任务单的最新流程
		String process=format.format(flow.getCreate_time())+DataUtil.getFlowArray(1)[flow.getOperation()];
		task.setProcess(process);
		task.setCreate_name(userDAO.getUserNameByID(task.getCreate_id()));
		return task;
	}
	private boolean checkMyOperation(int operation,User user,Task task){
		boolean flag=false;
		int position_id=user.getPosition_id();
		int project_category=task.getProject_category();
		int project_case=task.getProject_case();
		int project_type=task.getProject_type();
 		switch (operation) {
		case 1:
			if(task.getProduct_type()==10){//CPU类型项目 经理审批
				flag=permissionsDAO.checkPermission(position_id, DataUtil.getPCategoryPIDArray(project_category));
			}else{
				//助理审批权限
				flag=permissionsDAO.checkPermission(position_id, DataUtil.getBussinessPIDArray(project_category));
			}
			break;
		case 2:
			if(task.getProduct_type()==10){//CPU类型项目 经理审批
				flag=permissionsDAO.checkPermission(position_id, DataUtil.getPCategoryPIDArray(project_category));
			}else{
				//普项  需要商务助理能看到
				if(project_case==0){
					flag=permissionsDAO.checkPermission(position_id, DataUtil.getBussinessPIDArray(project_category));
				}else {
					//急项需要销售经理看到
					flag=permissionsDAO.checkPermission(position_id, DataUtil.getPCategoryPIDArray(project_category));
				}
				
			}
			break;
		case 13:
			if(task.getProject_category()==5){
				flag=task.getCreate_id()==user.getId();
			}else if((project_category==6 || project_category==7 || project_category==8) && project_type != 2){
				flag=permissionsDAO.checkPermission(position_id, 171);
			}else{
				if(project_case==0){
					//普项
					if(project_type == 2){
						flag=permissionsDAO.checkPermission(position_id, 158);
					}else {
						flag=permissionsDAO.checkPermission(position_id, 50);
					}
				}else{
					//急项 已结束
				}
			}
			break;
		case 14:
			flag=task.getCreate_id()==user.getId();
			break;
		case 17:
			if(task.getProject_category()==5){
				flag=permissionsDAO.checkPermission(position_id, DataUtil.getPCategoryPIDArray(project_category))||permissionsDAO.checkPermission(position_id, DataUtil.getBussinessPIDArray(project_category));
			}else if(project_case==0){
				//普项
				flag=permissionsDAO.checkPermission(position_id, DataUtil.getPCategoryPIDArray(project_category));
			}else{
				//急项
				if(project_type == 2){
					flag=permissionsDAO.checkPermission(position_id, 158);
				}else {
					flag=permissionsDAO.checkPermission(position_id, DataUtil.getBussinessPIDArray(project_category));
				}
			}
			break;
		case 18:
			flag=task.getCreate_id()==user.getId();
			break;
		case 19:
			flag=permissionsDAO.checkPermission(position_id, 9);
			break;
		case 20:
			flag=task.getCreate_id()==user.getId();
			break;
		case 24:
			if(project_case==0){
				//普项
				flag=permissionsDAO.checkPermission(position_id, 157);
			}else{
				//急项
				flag=permissionsDAO.checkPermission(position_id, DataUtil.getBussinessPIDArray(project_category));
			}
			break;
		case 25:
			flag=task.getCreate_id()==user.getId();
			break;
		case 21:
			if(project_case==0){
				//普项 已结束
			}else{
				//急项
				if(project_type == 2){
					flag=permissionsDAO.checkPermission(position_id, 157);
				}else {
					if(project_category==6 || project_category==7 || project_category==8){
						flag=permissionsDAO.checkPermission(position_id, 171);
					}else
					flag=permissionsDAO.checkPermission(position_id, 50);
				}
			}
			break;
		case 22:
			flag=task.getCreate_id()==user.getId();
			break;
		case 26:
			flag=permissionsDAO.checkPermission(position_id,173);
			break;
		case 27:
			flag=task.getCreate_id()==user.getId();
			break;
		default:
			break;
		}
		return flag;
	}
	private boolean checkMyOperation2(int operation,User user,Task task){
		boolean flag=false;
		int position_id=user.getPosition_id();
 		switch (operation) {
		case 1:
			flag=permissionsDAO.checkPermission(position_id, 113);
			break;
		case 2:
			flag=permissionsDAO.checkPermission(position_id, 114);
			break;
		case 3:
			flag=task.getCreate_id()==user.getId();
			break;
		case 4:
			flag=permissionsDAO.checkPermission(position_id, 9);
			break;
		case 5:
			flag=task.getCreate_id()==user.getId();
			break;
		case 6:
			flag=task.getCreate_id()==user.getId();
			break;
		case 10:
		case 12:
			flag=task.getCreate_id()==user.getId();
			break;
		case 11:
			flag=permissionsDAO.checkPermission(position_id, 155);
			break;
		default:
			break;
		}
		return flag;
	}

	public List<Task> getTaskListByUID(User user) {
		// TODO Auto-generated method stub
		List<Task> taskList=taskDAO.getRunningTask();
		SimpleDateFormat format = new SimpleDateFormat( "yyyy.MM.dd" );
		Iterator<Task> iterator=taskList.iterator();
		while (iterator.hasNext()) {
			Task task=(Task)iterator.next();
			User userByID = userDAO.getUserByID(task.getCreate_id());
			if(userByID==null || userByID.getPosition_id()==56){
				iterator.remove();
				continue;
			}
			Flow flow=flowDAO.getNewFlowByFID(1, task.getId());//查询最新流程
			if(flow!=null&&checkMyOperation(flow.getOperation(),user,task)){
				int operation = flow.getOperation();
				int project_type = task.getProject_type();
				String process=null;
				if(task.getProduct_type()==10){
					String[] flowArray23=DataUtil.getFlowArray(23);
					process=format.format(flow.getCreate_time())+flowArray23[flow.getOperation()];
				}else if(task.getProject_category()==5){
					String[] flowArray1=DataUtil.getFlowArray(151);
					process=format.format(flow.getCreate_time())+flowArray1[flow.getOperation()];
				}else if(project_type == 2 && operation == 26){
					process=format.format(flow.getCreate_time())+"售后审核通过";
				}else if(project_type == 2 && operation==18){
					process=format.format(flow.getCreate_time())+"售后审核未通过";
				}else {
					String[] flowArray=DataUtil.getFlowArray(1);
					process=format.format(flow.getCreate_time())+flowArray[flow.getOperation()];
				}
				task.setProcess(process);
				task.setCreate_name(userByID.getTruename());
			}else{
				iterator.remove();
			}
		}
		return taskList;
	}
	public List<Task> getStartupTaskListByUID(User user) {
		// TODO Auto-generated method stub
		List<Task> taskList=taskDAO.getRunningStartupTask();
		SimpleDateFormat format = new SimpleDateFormat( "yyyy.MM.dd" );
		String[] flowArray=DataUtil.getFlowArray(17);
		String[] stageArray2=DataUtil.getStageArray2();
		Iterator<Task> iterator=taskList.iterator();
		while (iterator.hasNext()) {
			Task task=(Task)iterator.next();
			User userByID = userDAO.getUserByID(task.getCreate_id());
			if(userByID==null || userByID.getPosition_id()==56){
				iterator.remove();
				continue;
			}
			Flow flow=flowDAO.getNewFlowByFID(17, task.getId());//查询最新流程
			if(flow!=null&&checkMyOperation2(flow.getOperation(),user,task)){
				String process=format.format(flow.getCreate_time())+flowArray[flow.getOperation()];
				task.setProcess(process);
				task.setProject_name(task.getProject_name()+'-'+stageArray2[task.getStage()]);
				task.setCreate_name(userByID.getTruename());
			}else{
				iterator.remove();
			}
		}
		return taskList;
	}
	

	public int insertTask(Task task) {
		// TODO Auto-generated method stub
		return taskDAO.insertTask(task);
	}

	public void updateEdited(Task task) {
		// TODO Auto-generated method stub
		taskDAO.updateEdited(task);
	}

	public void updateTask(Task task) {
		// TODO Auto-generated method stub
		taskDAO.updateTask(task);
		
	}
	public long lastFlowTime(int operation,List<Flow> flowList){
		int len=flowList.size();
		for (int i = 0; i < len; i++) {
			if(flowList.get(len-i-1).getOperation()==operation){
				return flowList.get(len-i-1).getCreate_time();
			}
		}
		return 0;//没有就返回0
	}
	public Map<String, String> getStartUpTaskFlowForDraw(Task task,Flow flow){
		int operation=flow.getOperation();
		Map<String, String> map=new HashMap<String, String>();
		List<Flow> flowList=flowDAO.getFlowListByCondition(17,task.getId());
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd#HH:mm:ss");
		String title1_flow=null;
		String title2_flow=null;
		String title3_flow=null;
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
		String time1=null;
		String time2=null;
		String time3=null;
		String time4=null;
		String time5=null;
		String time6=null;
		String time7=null;
		String bg_color1=null;
		String bg_color2=null;
		String bg_color3=null;
		String bg_color4=null;
		String bg_color5=null;
		String bg_color6=null;
		if(task.getStage()==4){
			title1_flow="title1_flow2";
			title2_flow="title2_flow2";
			title3_flow="title3_flow2";
			img7="notdid.png";
			img6="notdid.png";
			bg_color5="bgcolor_nodid";
			bg_color6="bgcolor_nodid";
		}else{
			title1_flow="title1_flow1";
			title2_flow="title2_flow1";
			title3_flow="title3_flow1";
		}
		if(operation==1){
			color1="color_did";
			color2="color_nodid";
			color3="color_nodid";
			color4="color_nodid";
			color5="color_nodid";
			img1="pass.png";
			img2="go.png";
			img3="notdid.png";
			img4="notdid.png";
			img5="notdid.png";
			bg_color1="bgcolor_did";
			bg_color2="bgcolor_nodid";
			bg_color3="bgcolor_nodid";
			bg_color4="bgcolor_nodid";
			time1=sdf.format(task.getCreate_time()).replace("#", "<br/>");
		}else if(operation==2){
			color1="color_did";
			color2="color_did";
			color3="color_nodid";
			color4="color_nodid";
			color5="color_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="go.png";
			img4="notdid.png";
			img5="notdid.png";
			bg_color1="bgcolor_did";
			bg_color2="bgcolor_did";
			bg_color3="bgcolor_nodid";
			bg_color4="bgcolor_nodid";
			time1=sdf.format(task.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==3){
			color1="color_did";
			color2="color_error";
			color3="color_nodid";
			color4="color_nodid";
			color5="color_nodid";
			img1="pass.png";
			img2="error.png";
			img3="notdid.png";
			img4="notdid.png";
			img5="notdid.png";
			bg_color1="bgcolor_error";
			bg_color2="bgcolor_nodid";
			bg_color3="bgcolor_nodid";
			bg_color4="bgcolor_nodid";
			time1=sdf.format(task.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==4){
			color1="color_did";
			color2="color_did";
			color3="color_did";
			color4="color_nodid";
			color5="color_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="pass.png";
			img4="go.png";
			img5="notdid.png";
			bg_color1="bgcolor_did";
			bg_color2="bgcolor_did";
			bg_color3="bgcolor_did";
			bg_color4="bgcolor_nodid";
			time1=sdf.format(task.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==5){
			color1="color_did";
			color2="color_did";
			color3="color_error";
			color4="color_nodid";
			color5="color_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="error.png";
			img4="notdid.png";
			img5="notdid.png";
			bg_color1="bgcolor_did";
			bg_color2="bgcolor_error";
			bg_color3="bgcolor_nodid";
			bg_color4="bgcolor_nodid";
			time1=sdf.format(task.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==6){
			color1="color_did";
			color2="color_did";
			color3="color_did";
			color4="color_error";
			color5="color_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="pass.png";
			img4="error.png";
			img5="notdid.png";
			bg_color1="bgcolor_did";
			bg_color2="bgcolor_did";
			bg_color3="bgcolor_error";
			bg_color4="bgcolor_nodid";
			time1=sdf.format(task.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
			time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==7){
			color1="color_did";
			color2="color_did";
			color3="color_did";
			color4="color_did";
			color5="color_did";
			img1="pass.png";
			img2="pass.png";
			img3="pass.png";
			img4="pass.png";
			img5="pass.png";
			bg_color1="bgcolor_did";
			bg_color2="bgcolor_did";
			bg_color3="bgcolor_did";
			bg_color4="bgcolor_did";
			time1=sdf.format(task.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
			time4=sdf.format(lastFlowTime(7, flowList)).replace("#", "<br/>");
			time5=time4;
		}else if(operation==8){
			title1_flow="title1_flow0";
			title2_flow="title2_flow0";
			title3_flow="title3_flow0";
			color1="color_did";
			color5="color_error";
			img1="pass.png";
			img5="error.png";
			bg_color4="bgcolor_error";
			time1=sdf.format(task.getCreate_time()).replace("#", "<br/>");
			time5=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==9){
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
			bg_color1="bgcolor_did";
			bg_color2="bgcolor_did";
			bg_color3="bgcolor_did";
			bg_color4="bgcolor_did";
			bg_color5="bgcolor_did";
			bg_color6="bgcolor_did";
			time1=sdf.format(task.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
			time4=sdf.format(lastFlowTime(10, flowList)).replace("#", "<br/>");
			time5=sdf.format(lastFlowTime(11, flowList)).replace("#", "<br/>");
			time6=sdf.format(lastFlowTime(9, flowList)).replace("#", "<br/>");
			time7=time6;
		}else if(operation==10){
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
			bg_color1="bgcolor_did";
			bg_color2="bgcolor_did";
			bg_color3="bgcolor_did";
			bg_color4="bgcolor_did";
			bg_color5="bgcolor_nodid";
			bg_color6="bgcolor_nodid";
			time1=sdf.format(task.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
			time4=sdf.format(lastFlowTime(10, flowList)).replace("#", "<br/>");
		}else if(operation==11){
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
			bg_color1="bgcolor_did";
			bg_color2="bgcolor_did";
			bg_color3="bgcolor_did";
			bg_color4="bgcolor_did";
			bg_color5="bgcolor_did";
			bg_color6="bgcolor_nodid";
			time1=sdf.format(task.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
			time4=sdf.format(lastFlowTime(10, flowList)).replace("#", "<br/>");
			time5=sdf.format(lastFlowTime(11, flowList)).replace("#", "<br/>");
		}else if(operation==12){
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
			bg_color1="bgcolor_did";
			bg_color2="bgcolor_did";
			bg_color3="bgcolor_did";
			bg_color4="bgcolor_did";
			bg_color5="bgcolor_error";
			bg_color6="bgcolor_nodid";
			time1=sdf.format(task.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
			time4=sdf.format(lastFlowTime(10, flowList)).replace("#", "<br/>");
			time5=sdf.format(lastFlowTime(11, flowList)).replace("#", "<br/>");
			time6=sdf.format(lastFlowTime(12, flowList)).replace("#", "<br/>");
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
		map.put("time1", time1);
		map.put("time2", time2);
		map.put("time3", time3);
		map.put("time4", time4);
		map.put("time5", time5);
		map.put("time6", time6);
		map.put("time7", time7);
		map.put("bg_color1", bg_color1);
		map.put("bg_color2", bg_color2);
		map.put("bg_color3", bg_color3);
		map.put("bg_color4", bg_color4);
		map.put("bg_color5", bg_color5);
		map.put("bg_color6", bg_color6);
		return map;
	}
	public Map<String, String> getTaskFlowForDraw(Task task,Flow flow) {
		// TODO Auto-generated method stub
		int operation=flow.getOperation();
		Map<String, String> map=new HashMap<String, String>();
		List<Flow> flowList=flowDAO.getFlowListByCondition(1,task.getId());
		if(operation==5||operation==8||operation==12){
			SimpleDateFormat dft=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String name1="提交任务单";
			String name2="商务助理审核";
			String name3="项目主管审核";
			String name4="销售经理审核";
			String name5="完成";
			if(task.getProject_case()==1){
				name2="销售经理审核";
				name4="商务助理审核";
			}
			String class11="";
			String class12="";
			String class13="";
			String class14="";
			String class15="";
			String img1="pass.png";
			String img2="pass.png";
			String img3="pass.png";
			String img4="pass.png";
			String img5="pass.png";
			String time1="";
			String time2="";
			String time3="";
			String time4="";
			String time5="";
			String class22="";
			String class24="";
			String class26="";
			String class28="";
			if(operation==1||operation==2){//第一步
				 class11="td2_div11_pass";
				 class12="td2_div12_nodid";
				 class13="td2_div13_nodid";
				 class14="td2_div14_nodid";
				 class15="td2_div15_nodid";
				 img1="pass.png";
				 img2="go.png";
				 img3="notdid.png";
				 img4="notdid.png";
				 img5="notdid.png";
				 time1=dft.format(task.getCreate_time());
				 time2="";
				 time3="";
				 time4="";
				 time5="";
				 class22="td2_div2_agree";
				 class24="td2_div2_nodid";
				 class26="td2_div2_nodid";
				 class28="td2_div2_nodid";
			}else if(operation==3||operation==6){//第二部
				 class11="td2_div11_pass";
				 class12="td2_div12_pass";
				 class13="td2_div13_nodid";
				 class14="td2_div14_nodid";
				 class15="td2_div15_nodid";
				 img1="pass.png";
				 img2="pass.png";
				 img3="go.png";
				 img4="notdid.png";
				 img5="notdid.png";
				 time1=dft.format(task.getCreate_time());
				 time2=dft.format(lastFlowTime(operation,flowList));
				 time3="";
				 time4="";
				 time5="";
				 class22="td2_div2_agree";
				 class24="td2_div2_agree";
				 class26="td2_div2_nodid";
				 class28="td2_div2_nodid";
			}else if(operation==4||operation==7){//第三部
				 class11="td2_div11_pass";
				 class12="td2_div12_pass";
				 class13="td2_div13_pass";
				 class14="td2_div14_nodid";
				 class15="td2_div15_nodid";
				 img1="pass.png";
				 img2="pass.png";
				 img3="pass.png";
				 img4="go.png";
				 img5="notdid.png";
				 time1=dft.format(task.getCreate_time());
				 if(operation==4){
					 time2=dft.format(lastFlowTime(3,flowList));//普项 项目审批的前一步为商务助理审批
				 }else{
					 time2=dft.format(lastFlowTime(6,flowList));
				 }
				 time3=dft.format(lastFlowTime(operation,flowList));
				 time4="";
				 time5="";
				 class22="td2_div2_agree";
				 class24="td2_div2_agree";
				 class26="td2_div2_agree";
				 class28="td2_div2_nodid";
			}else if(operation==5||operation==8){//第四部
				 class11="td2_div11_pass";
				 class12="td2_div12_pass";
				 class13="td2_div13_pass";
				 class14="td2_div14_pass";
				 class15="td2_div15_pass";
				 img1="pass.png";
				 img2="pass.png";
				 img3="pass.png";
				 img4="pass.png";
				 img5="pass.png";
				 time1=dft.format(task.getCreate_time());
				 if(operation==5){
					 time2=dft.format(lastFlowTime(3,flowList));//普项 项目审批的前一步为商务助理审批
					 time3=dft.format(lastFlowTime(4,flowList));
				 }else{
					 time2=dft.format(lastFlowTime(6,flowList));
					 time3=dft.format(lastFlowTime(7,flowList));
				 }
				 time5=time4=dft.format(lastFlowTime(operation,flowList));
				 class22="td2_div2_agree";
				 class24="td2_div2_agree";
				 class26="td2_div2_agree";
				 class28="td2_div2_agree";
			}else if(operation==9&&task.getProject_case()==0){
				 class11="td2_div11_pass";
				 class12="td2_div12_nopass";
				 class13="td2_div13_nodid";
				 class14="td2_div14_nodid";
				 class15="td2_div15_nodid";
				 img1="pass.png";
				 img2="error.png";
				 img3="notdid.png";
				 img4="notdid.png";
				 img5="notdid.png";
				 time1=dft.format(task.getCreate_time());
				 time2=dft.format(lastFlowTime(operation,flowList));
				 time3="";
				 time4="";
				 time5="";
				 class22="td2_div2_disagree";
				 class24="td2_div2_nodid";
				 class26="td2_div2_nodid";
				 class28="td2_div2_nodid";
			}else if(operation==9&&task.getProject_case()==1){
				 class11="td2_div11_pass";
				 class12="td2_div12_pass";
				 class13="td2_div13_pass";
				 class14="td2_div14_nopass";
				 class15="td2_div15_nodid";
				 img1="pass.png";
				 img2="pass.png";
				 img3="pass.png";
				 img4="error.png";
				 img5="notdid.png";
				 time1=dft.format(task.getCreate_time());
				 time2=dft.format(lastFlowTime(6,flowList));
				 time3=dft.format(lastFlowTime(7,flowList));
				 time4=dft.format(lastFlowTime(operation,flowList));
				 time5="";
				 class22="td2_div2_agree";
				 class24="td2_div2_agree";
				 class26="td2_div2_disagree";
				 class28="td2_div2_nodid";
			}else if(operation==10&&task.getProject_case()==0){
				class11="td2_div11_pass";
				 class12="td2_div12_pass";
				 class13="td2_div13_nopass";
				 class14="td2_div14_nodid";
				 class15="td2_div15_nodid";
				 img1="pass.png";
				 img2="pass.png";
				 img3="error.png";
				 img4="notdid.png";
				 img5="notdid.png";
				 time1=dft.format(task.getCreate_time());
				 time2=dft.format(lastFlowTime(3,flowList));
				 time3=dft.format(lastFlowTime(operation,flowList));
				 time4="";
				 time5="";
				 class22="td2_div2_agree";
				 class24="td2_div2_disagree";
				 class26="td2_div2_nodid";
				 class28="td2_div2_nodid";
			}else if(operation==10&&task.getProject_case()==1){
				class11="td2_div11_pass";
				 class12="td2_div12_pass";
				 class13="td2_div13_nopass";
				 class14="td2_div14_nodid";
				 class15="td2_div15_nodid";
				 img1="pass.png";
				 img2="pass.png";
				 img3="error.png";
				 img4="notdid.png";
				 img5="notdid.png";
				 time1=dft.format(task.getCreate_time());
				 time2=dft.format(lastFlowTime(6,flowList));
				 time3=dft.format(lastFlowTime(operation,flowList));
				 time4="";
				 time5="";
				 class22="td2_div2_agree";
				 class24="td2_div2_disagree";
				 class26="td2_div2_nodid";
				 class28="td2_div2_nodid";
			}else if(operation==11&&task.getProject_case()==0){
				class11="td2_div11_pass";
				 class12="td2_div12_pass";
				 class13="td2_div13_pass";
				 class14="td2_div14_nopass";
				 class15="td2_div15_nodid";
				 img1="pass.png";
				 img2="pass.png";
				 img3="pass.png";
				 img4="error.png";
				 img5="notdid.png";
				 time1=dft.format(task.getCreate_time());
				 time2=dft.format(lastFlowTime(3,flowList));
				 time3=dft.format(lastFlowTime(4,flowList));
				 time4=dft.format(lastFlowTime(operation,flowList));
				 time5="";
				 class22="td2_div2_agree";
				 class24="td2_div2_agree";
				 class26="td2_div2_disagree";
				 class28="td2_div2_nodid";
			}else if(operation==11&&task.getProject_case()==1){
				 class11="td2_div11_pass";
				 class12="td2_div12_nopass";
				 class13="td2_div13_nodid";
				 class14="td2_div14_nodid";
				 class15="td2_div15_nodid";
				 img1="pass.png";
				 img2="error.png";
				 img3="notdid.png";
				 img4="notdid.png";
				 img5="notdid.png";
				 time1=dft.format(task.getCreate_time());
				 time2=dft.format(lastFlowTime(operation,flowList));
				 time3="";
				 time4="";
				 time5="";
				 class22="td2_div2_disagree";
				 class24="td2_div2_nodid";
				 class26="td2_div2_nodid";
				 class28="td2_div2_nodid";
			}else if(operation==12){
				 time1=dft.format(task.getCreate_time());
				 time2=dft.format(lastFlowTime(12,flowList));
			}
			map.put("name1",name1);
			map.put("name2",name2);
			map.put("name3",name3);
			map.put("name4",name4);
			map.put("name5",name5);
			map.put("class11",class11);
			map.put("class12",class12);
			map.put("class13",class13);
			map.put("class14",class14);
			map.put("class15",class15);
			map.put("img1",img1);
			map.put("img2",img2);
			map.put("img3",img3);
			map.put("img4",img4);
			map.put("img5",img5);
			map.put("time1",time1);
			map.put("time2",time2);
			map.put("time3",time3);
			map.put("time4",time4);
			map.put("time5",time5);
			map.put("class22",class22);
			map.put("class24",class24);
			map.put("class26",class26);
			map.put("time4",time4);
			map.put("class28",class28);
		}else{
			SimpleDateFormat dft=new SimpleDateFormat("yyyy-MM-dd#HH:mm:ss");
			String name1=null;
			String name2=null;
			String name3=null;
			String name4=null;
			String name5=null;
			String name6=null;
			String name7=null;
			String name8=null;
			String class11=null;
			String class12=null;
			String class13=null;
			String class14=null;
			String class15=null;
			String class16=null;
			String class17=null;
			String class22=null;
			String class24=null;
			String class26=null;
			String class28=null;
			String class210=null;
			String class30=null;
			String class38=null;
			String class39=null;
			String img1=null;
			String img2=null;
			String img3=null;
			String img4=null;
			String img5=null;
			String img6=null;
			String img7=null;
			String img8=null;
			String time1=null;
			String time2=null;
			String time3=null;
			String time4=null;
			String time5=null;
			String time6=null;
			String time7=null;
			String time8=null;
			if(task.getProduct_type()==10){
				name1="提交任务单";
				name2="销售经理审核";
				name3="总经理审核";
				name4="完成";
			}else if(task.getProject_category()==5){
				name1="提交任务单";
				name2="产品经理审核";
				name3="创建人上传文件";
				name4="产品部审核";
				name5="总经理审核";
				name6="完成";
			}else{
				if(task.getProject_case()==0){
					//普项
					name1="提交任务单";
					name2="商务助理确认";
					name5="总经理审批";
					name6="完成";
					name8="工程经理审核";
					if(task.getProject_type()==2){
						name4="售后审核";
						name3="诊断审核";
						name7="销售经理审核";
					}else{
						name3="工程设计审核";
						name4="销售经理审核";
					}
				}else{
					name1="提交任务单";
					name2="销售经理审核";
					name3="总经理审核";
					name8="工程经理审核";
					name5="商务助理审核";
					name6="完成";
					if(task.getProject_type()==2){
						name4="售后审核";
						name7="诊断审核";
					}else{
						name4="工程审核";
					}
				}
			}
			if(task.getProduct_type()==10){
				if(operation==1 || operation==2){
					class11="td4_div41_pass_new";
					class12="td4_div42_pass_new";
					class13="td4_div43_nodid_new";
					class14="td4_div44_nodid_new";
					img1="pass.png";
					img2="go.png";
					img3="notdid.png";
					img4="notdid.png";
					time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					time2="";
					time3="";
					time4="";
					class22="td4_div2_agree_new";
					class24="td4_div2_nodid_new";
					class26="td4_div2_nodid_new";
				}else if (operation==19) {
					class11="td4_div41_pass_new";
					class12="td4_div42_pass_new";
					class13="td4_div43_pass_new";
					class14="td4_div44_nodid_new";
					img1="pass.png";
					img2="pass.png";
					img3="go.png";
					img4="notdid.png";
					time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
					time3="";
					time4="";
					class22="td4_div2_agree_new";
					class24="td4_div2_agree_new";
					class26="td4_div2_nodid_new";
				}else if (operation==20) {
					class11="td4_div41_pass_new";
					class12="td4_div42_nopass_new";
					class13="td4_div43_nodid_new";
					class14="td4_div44_nodid_new";
					img1="pass.png";
					img2="error.png";
					img3="notdid.png";
					img4="notdid.png";
					time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					time2=dft.format(lastFlowTime(20,flowList)).replace("#", "<br/>");
					time3="";
					time4="";
					class22="td4_div2_disagree_new";
					class24="td4_div2_nodid_new";
					class26="td4_div2_nodid_new";
				}else if (operation==21 || operation==23) {
					class11="td4_div41_pass_new";
					class12="td4_div42_pass_new";
					class13="td4_div43_pass_new";
					class14="td4_div44_pass_new";
					img1="pass.png";
					img2="pass.png";
					img3="pass.png";
					img4="pass.png";
					time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
					time3=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
					time4=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
					class22="td4_div2_agree_new";
					class24="td4_div2_agree_new";
					class26="td4_div2_agree_new";
				}else if (operation==22) {
					class11="td4_div41_pass_new";
					class12="td4_div42_pass_new";
					class13="td4_div43_nopass_new";
					class14="td4_div44_nodid_new";
					img1="pass.png";
					img2="pass.png";
					img3="error.png";
					img4="notdid.png";
					time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
					time3=dft.format(lastFlowTime(22,flowList)).replace("#", "<br/>");
					time4="";
					class22="td4_div2_agree_new";
					class24="td4_div2_disagree_new";
					class26="td4_div2_nodid_new";
				}
			}else if(task.getProject_category()==5){
				if(operation==1 || operation==2){//1 || 2
					class11="td2_div111_pass_new";
					class12="td2_div121_pass_new";
					class13="td2_div131_nodid_new";
					class14="td2_div141_nodid_new";
					class15="td2_div151_nodid_new";
					class16="td2_div161_nodid_new";
					img1="pass.png";
					img2="go.png";
					img3="notdid.png";
					img4="notdid.png";
					img5="notdid.png";
					img6="notdid.png";
					time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					time2="";
					time3="";
					time4="";
					time5="";
					time6="";
					class22="td2_div3_agree_new";
					class24="td2_div3_nodid_new";
					class26="td2_div3_nodid_new";
					class30="td2_div3_nodid_new";
					class28="td2_div3_nodid_new";
					class210="td2_div3_nodid_new";
				}else if (operation==13) {//13
					class11="td2_div111_pass_new";
					class12="td2_div121_pass_new";
					class13="td2_div131_pass_new";
					class14="td2_div141_nodid_new";
					class15="td2_div151_nodid_new";
					class16="td2_div161_nodid_new";
					 img1="pass.png";
					 img2="pass.png";
					 img3="go.png";
					 img4="notdid.png";
					 img5="notdid.png";
					 img6="notdid.png";
					 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					 time2=dft.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
					 time3="";
					 time4="";
					 time5="";
					 time6="";
					 class22="td2_div3_agree_new";
					 class24="td2_div3_agree_new";
					 class26="td2_div3_nodid_new";
					 class30="td2_div3_nodid_new";
					 class28="td2_div3_nodid_new";
					 class210="td2_div3_nodid_new";
				}else if (operation==14) {//14
					class11="td2_div111_pass_new";
					class12="td2_div121_nopass_new";
					class13="td2_div131_nodid_new";
					class14="td2_div141_nodid_new";
					class15="td2_div151_nodid_new";
					class16="td2_div161_nodid_new";
					 img1="pass.png";
					 img2="error.png";
					 img3="notdid.png";
					 img4="notdid.png";
					 img5="notdid.png";
					 img6="notdid.png";
					 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					 time2="";
					 time3="";
					 time4="";
					 time5="";
					 time6="";
					 class22="td2_div3_disagree_new";
					 class24="td2_div3_nodid_new";
					 class26="td2_div3_nodid_new";
					 class30="td2_div3_nodid_new";
					 class28="td2_div3_nodid_new";
					 class210="td2_div3_nodid_new";
				}else if (operation==17) {//17
					class11="td2_div111_pass_new";
					class12="td2_div121_pass_new";
					class13="td2_div131_pass_new";
					class14="td2_div141_pass_new";
					class15="td2_div151_nodid_new";
					class16="td2_div161_nodid_new";
					img1="pass.png";
					img2="pass.png";
					img3="pass.png";
					img4="go.png";
					img5="notdid.png";
					img6="notdid.png";
					time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
					time3=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
					time4="";
					time5="";
					time6="";
					class22="td2_div3_agree_new";
					class24="td2_div3_agree_new";
					class26="td2_div3_agree_new";
					class30="td2_div3_agree_new";
					class28="td2_div3_nodid_new";
					class210="td2_div3_nodid_new";
				}else if (operation==18) {//18
					class11="td2_div111_pass_new";
					class12="td2_div121_pass_new";
					class13="td2_div131_nopass_new";
					class14="td2_div141_nodid_new";
					class15="td2_div151_nodid_new";
					class16="td2_div161_nodid_new";
					img1="pass.png";
					img2="pass.png";
					img3="error.png";
					img4="notdid.png";
					img5="notdid.png";
					img6="notdid.png";
					time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
					time3="";
					time4="";
					time5="";
					time6="";
					class22="td2_div3_agree_new";
					class24="td2_div3_disagree_new";
					class26="td2_div3_nodid_new";
					class28="td2_div3_nodid_new";
					class210="td2_div3_nodid_new";
				}else if (operation==19) {//19
					class11="td2_div111_pass_new";
					class12="td2_div121_pass_new";
					class13="td2_div131_pass_new";
					class14="td2_div141_pass_new";
					class15="td2_div151_pass_new";
					class16="td2_div161_nodid_new";
					img1="pass.png";
					 img2="pass.png";
					 img3="pass.png";
					 img4="pass.png";
					 img5="go.png";
					 img6="notdid.png";
					 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					 time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
					 time3=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
					 time4=dft.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
					 time5="";
					 time6="";
					 class22="td2_div3_agree_new";
					 class24="td2_div3_agree_new";
					 class26="td2_div3_agree_new";
					 class30="td2_div3_agree_new";
					 class28="td2_div3_agree_new";
					 class210="td2_div3_nodid_new"; 
				}else if (operation==20) {//20
					class11="td2_div111_pass_new";
					class12="td2_div121_pass_new";
					class13="td2_div131_pass_new";
					class14="td2_div141_nopass_new";
					class15="td2_div151_nodid_new";
					class16="td2_div161_nodid_new";
					 img1="pass.png";
					 img2="pass.png";
					 img3="pass.png";
					 img4="error.png";
					 img5="notdid.png";
					 img6="notdid.png";
					 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					 time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
					 time3=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
					 time4="";
					 time5="";
					 time6="";
					 class22="td2_div3_agree_new";
					 class24="td2_div3_agree_new";
					 class26="td2_div3_disagree_new";
					 class28="td2_div3_nodid_new";
					 class210="td2_div3_nodid_new";
				}else if (operation==21) {
					class11="td2_div111_pass_new";
					class12="td2_div121_pass_new";
					class13="td2_div131_pass_new";
					class14="td2_div141_pass_new";
					class15="td2_div151_pass_new";
					class16="td2_div161_pass_new";
					 img1="pass.png";
					 img2="pass.png";
					 img3="pass.png";
					 img4="pass.png";
					 img5="pass.png";
					 img6="pass.png";
					 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					 time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
					 time3=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
					 time4=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
					 time5=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
					 time6=time5;
					 class22="td2_div3_agree_new";
					 class24="td2_div3_agree_new";
					 class26="td2_div3_agree_new";
					 class30="td2_div3_agree_new";
					 class28="td2_div3_agree_new";
					 class210="td2_div3_agree_new";
				}else if (operation==22) {//22
					class11="td2_div111_pass_new";
					class12="td2_div121_pass_new";
					class13="td2_div131_pass_new";
					class14="td2_div141_pass_new";
					class15="td2_div151_nopass_new";
					class16="td2_div161_nodid_new";
					 img1="pass.png";
					 img2="pass.png";
					 img3="pass.png";
					 img4="pass.png";
					 img5="error.png";
					 img6="notdid.png";
					 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					 time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
					 time3=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
					 time4=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
					 time5="";
					 time6="";
					 class22="td2_div3_agree_new";
					 class24="td2_div3_agree_new";
					 class26="td2_div3_agree_new";
					 class30="td2_div3_agree_new";
					 class28="td2_div3_disagree_new";
					 class210="td2_div3_nodid_new";
				}else if (operation==23) {//23
					class11="td2_div111_pass_new";
					class12="td2_div121_pass_new";
					class13="td2_div131_pass_new";
					class14="td2_div141_pass_new";
					class15="td2_div151_pass_new";
					class16="td2_div161_pass_new";
					 img1="pass.png";
					 img2="pass.png";
					 img3="pass.png";
					 img4="pass.png";
					 img5="pass.png";
					 img6="pass.png";
					 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					 time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
					 time3=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
					 time4=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
					 time5=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
					 time6=time5;
					 class22="td2_div3_agree_new";
					 class24="td2_div3_agree_new";
					 class26="td2_div3_agree_new";
					 class30="td2_div3_agree_new";
					 class28="td2_div3_agree_new";
					 class210="td2_div3_agree_new";
				}
			}else if(operation==1){
				if(task.getProject_type()==2){
					class11="td2_div11_pass_new";
					class12="td2_div12_pass_new";
					class13="td2_div13_nodid_new";
					class14="td2_div14_nodid_new";
					class38="td2_div18_nodid_new";
					class17="td2_div17_nodid_new";
					class15="td2_div15_nodid_new";
					class16="td2_div16_nodid_new";
					img1="pass.png";
					img2="go.png";
					img7="notdid.png";
					img3="notdid.png";
					img8="notdid.png";
					img4="notdid.png";
					img5="notdid.png";
					img6="notdid.png";
					time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					time2="";
					time3="";
					time8="";
					time7="";
					time4="";
					time5="";
					time6="";
					class22="td2_div2_agree_new_2";
					class24="td2_div2_nodid_new";
					class26="td2_div2_nodid_new";
					class39="td2_div2_nodid_new";
					class30="td2_div2_nodid_new";
					class28="td2_div2_nodid_new";
					class210="td2_div2_nodid_new";
				}else{
					class11="td2_div111_pass_new";
					class12="td2_div121_pass_new";
					class13="td2_div131_nodid_new";
					class38="td2_div181_nodid_new";
					class14="td2_div141_nodid_new";
					class15="td2_div151_nodid_new";
					class16="td2_div161_nodid_new";
					img1="pass.png";
					img2="go.png";
					img3="notdid.png";
					img8="notdid.png";
					img4="notdid.png";
					img5="notdid.png";
					img6="notdid.png";
					time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					time2="";
					time3="";
					time8="";
					time4="";
					time5="";
					time6="";
					class22="td2_div3_agree_new";
					class24="td2_div3_nodid_new";
					class39="td2_div3_nodid_new";
					class26="td2_div3_nodid_new";
					class30="td2_div3_nodid_new";
					class28="td2_div3_nodid_new";
					class210="td2_div3_nodid_new";
				}
			}else if(operation==2){
				if(task.getProject_type()==2){
					class11="td2_div11_pass_new";
					class12="td2_div12_pass_new";
					class13="td2_div13_nodid_new";
					class14="td2_div14_nodid_new";
					class38="td2_div18_nodid_new";
					class17="td2_div17_nodid_new";
					class15="td2_div15_nodid_new";
					class16="td2_div16_nodid_new";
					 img1="pass.png";
					 img2="go.png";
					 img3="notdid.png";
					 img4="notdid.png";
					 img8="notdid.png";
					 img7="notdid.png";
					 img5="notdid.png";
					 img6="notdid.png";
					 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					 time2="";
					 time3="";
					 time4="";
					 time8="";
					 time7="";
					 time5="";
					 time6="";
					 class22="td2_div2_agree_new_2";
					 class24="td2_div2_nodid_new";
					 class26="td2_div2_nodid_new";
					 class30="td2_div2_nodid_new";
					 class39="td2_div2_nodid_new";
					 class28="td2_div2_nodid_new";
					 class210="td2_div2_nodid_new";

				}else{
					class11="td2_div111_pass_new";
					class12="td2_div121_pass_new";
					class13="td2_div131_nodid_new";
					class38="td2_div181_nodid_new";
					class14="td2_div141_nodid_new";
					class15="td2_div151_nodid_new";
					class16="td2_div161_nodid_new";
					img1="pass.png";
					img2="go.png";
					img3="notdid.png";
					img8="notdid.png";
					img4="notdid.png";
					img5="notdid.png";
					img6="notdid.png";
					time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					time2="";
					time3="";
					time8="";
					time4="";
					time5="";
					time6="";
					class22="td2_div3_agree_new";
					class24="td2_div3_nodid_new";
					class39="td2_div3_nodid_new";
					class26="td2_div3_nodid_new";
					class30="td2_div3_nodid_new";
					class28="td2_div3_nodid_new";
					class210="td2_div3_nodid_new";
				}
 			}else if(operation==13){
				if(task.getProject_case()==0){//普项 
					if(task.getProject_type()==2){//售后
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class14="td2_div14_nodid_new";
						class38="td2_div18_nodid_new";
						class17="td2_div17_nodid_new";
						class15="td2_div15_nodid_new";
						class16="td2_div16_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="go.png";
						 img7="notdid.png";
						 img8="notdid.png";
						 img4="notdid.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
						 time3="";
						 time4="";
						 time8="";
						 time7="";
						 time5="";
						 time6="";
						 class22="td2_div2_agree_new_2";
						 class24="td2_div2_agree_new";
						 class26="td2_div2_nodid_new";
						 class30="td2_div2_nodid_new";
						 class39="td2_div2_nodid_new";
						 class28="td2_div2_nodid_new";
						 class210="td2_div2_nodid_new";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class38="td2_div181_nodid_new";
						class14="td2_div141_nodid_new";
						class15="td2_div151_nodid_new";
						class16="td2_div161_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="go.png";
						 img4="notdid.png";
						 img8="notdid.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
						 time3="";
						 time8="";
						 time4="";
						 time5="";
						 time6="";
						 class22="td2_div3_agree_new";
						 class24="td2_div3_agree_new";
						 class26="td2_div3_nodid_new";
						 class39="td2_div3_nodid_new";
						 class30="td2_div3_nodid_new";
						 class28="td2_div3_nodid_new";
						 class210="td2_div3_nodid_new";
					}
				}else{
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class17="td2_div17_pass_new";
						class14="td2_div14_pass_new";
						class15="td2_div15_pass_new";
						class16="td2_div16_pass_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img7="pass.png";
						 img4="pass.png";
						 img5="pass.png";
						 img6="pass.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(15,flowList)).replace("#", "<br/>");
						 time7=dft.format(lastFlowTime(24,flowList)).replace("#", "<br/>");
						 time4=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
						 time5=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time6=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class14="td2_div141_pass_new";
						class15="td2_div151_pass_new";
						class16="td2_div161_pass_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img4="pass.png";
						 img5="pass.png";
						 img6="pass.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(15,flowList)).replace("#", "<br/>");
						 time4=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
						 time5=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time6=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
					}
					 if(task.getProject_type()==2){
						 class22="td2_div2_agree_new";
						 class24="td2_div2_agree_new";
						 class26="td2_div2_agree_new";
						 class30="td2_div2_agree_new";
						 class28="td2_div2_agree_new";
						 class210="td2_div2_agree_new";
					 }else{
						 class22="td2_div3_agree_new";
						 class24="td2_div3_agree_new";
						 class26="td2_div3_agree_new";
						 class30="td2_div3_agree_new";
						 class28="td2_div3_agree_new";
						 class210="td2_div3_agree_new";
					 }
				}
			}else if(operation==14){
				if(task.getProject_case()==0){
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_nopass_new";
						class13="td2_div13_nodid_new";
						class14="td2_div14_nodid_new";
						class38="td2_div18_nodid_new";
						class17="td2_div17_nodid_new";
						class15="td2_div15_nodid_new";
						class16="td2_div16_nodid_new";
						 img1="pass.png";
						 img2="error.png";
						 img3="notdid.png";
						 img4="notdid.png";
						 img8="notdid.png";
						 img7="notdid.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2="";
						 time3="";
						 time4="";
						 time8="";
						 time7="";
						 time5="";
						 time6="";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_nopass_new";
						class13="td2_div131_nodid_new";
						class38="td2_div181_nodid_new";
						class14="td2_div141_nodid_new";
						class15="td2_div151_nodid_new";
						class16="td2_div161_nodid_new";
						 img1="pass.png";
						 img2="error.png";
						 img3="notdid.png";
						 img8="notdid.png";
						 img4="notdid.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2="";
						 time3="";
						 time8="";
						 time4="";
						 time5="";
						 time6="";
					}
					
					 if(task.getProject_type()==2){
						 class22="td2_div2_disagree_new_2";
						 class24="td2_div2_nodid_new";
						 class26="td2_div2_nodid_new";
						 class30="td2_div2_nodid_new";
						 class39="td2_div2_nodid_new";
						 class28="td2_div2_nodid_new";
						 class210="td2_div2_nodid_new";
					 }else{
						 class22="td2_div3_disagree_new";
						 class24="td2_div3_nodid_new";
						 class39="td2_div3_nodid_new";
						 class26="td2_div3_nodid_new";
						 class30="td2_div3_nodid_new";
						 class28="td2_div3_nodid_new";
						 class210="td2_div3_nodid_new";
					 }
				}else{
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class17="td2_div17_pass_new";
						class38="td2_div18_pass_new";
						class14="td2_div14_pass_new";
						class15="td2_div15_nopass_new";
						class16="td2_div16_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img7="pass.png";
						 img4="pass.png";
						 img8="pass.png";
						 img5="error.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
						 time7=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						 time4=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
						 time8=dft.format(lastFlowTime(24,flowList)).replace("#", "<br/>");
						 time5="";
						 time6="";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class14="td2_div141_pass_new";
						class38="td2_div181_pass_new";
						class15="td2_div151_nopass_new";
						class16="td2_div161_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img4="pass.png";
						 img8="pass.png";
						 img5="error.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
						 time4=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						 time8=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
						 time5="";
						 time6="";
					}
					 if(task.getProject_type()==2){
						 class22="td2_div2_agree_new_2";
						 class24="td2_div2_agree_new";
						 class26="td2_div2_agree_new";
						 class30="td2_div2_agree_new";
						 class39="td2_div2_agree_new";
						 class28="td2_div2_disagree_new";
						 class210="td2_div2_nodid_new";
					 }else{
						 class22="td2_div3_agree_new";
						 class24="td2_div3_agree_new";
						 class26="td2_div3_agree_new";
						 class30="td2_div3_agree_new";
						 class39="td2_div3_agree_new";
						 class28="td2_div3_disagree_new";
						 class210="td2_div3_nodid_new"; 
					 }
				}
			}else if(operation==17){
				if(task.getProject_case()==0){
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class14="td2_div14_pass_new";
						class38="td2_div18_pass_new";
						class17="td2_div17_pass_new";
						class15="td2_div15_nodid_new";
						class16="td2_div16_nodid_new";
						img1="pass.png";
						img2="pass.png";
						img3="pass.png";
						img4="pass.png";
						img8="pass.png";
						img7="go.png";
						img5="notdid.png";
						img6="notdid.png";
						time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						time3=dft.format(lastFlowTime(24,flowList)).replace("#", "<br/>");
						time4=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						time8=dft.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
						time7="";
						time5="";
						time6="";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class38="td2_div181_pass_new";
						class14="td2_div141_pass_new";
						class15="td2_div151_nodid_new";
						class16="td2_div161_nodid_new";
						img1="pass.png";
						img2="pass.png";
						img3="pass.png";
						img8="pass.png";
						img4="go.png";
						img5="notdid.png";
						img6="notdid.png";
						time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						time3=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						time8=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
						time4="";
						time5="";
						time6="";
					}
					 if(task.getProject_type()==2){
							class22="td2_div2_agree_new_2";
							class24="td2_div2_agree_new";
							class26="td2_div2_agree_new";
							class30="td2_div2_agree_new";
							class39="td2_div2_agree_new";
							class28="td2_div2_nodid_new";
							class210="td2_div2_nodid_new";
					 }else{
							class22="td2_div3_agree_new";
							class24="td2_div3_agree_new";
							class39="td2_div3_agree_new";
							class26="td2_div3_agree_new";
							class30="td2_div3_nodid_new";
							class28="td2_div3_nodid_new";
							class210="td2_div3_nodid_new";
					 }
				}else{
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class14="td2_div14_pass_new";
						class38="td2_div18_pass_new";
						class17="td2_div17_pass_new";
						class15="td2_div15_nodid_new";
						class16="td2_div16_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img4="pass.png";
						 img8="pass.png";
						 img7="go.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
						 time4=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						 time8=dft.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
						 time7="";
						 time5="";
						 time6="";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class14="td2_div141_pass_new";
						class38="td2_div181_pass_new";
						class15="td2_div151_pass_new";
						class16="td2_div161_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img4="pass.png";
						 img8="pass.png";
						 img5="go.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
						 time4=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						 time8=dft.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
						 time5="";
						 time6="";
					}
					 if(task.getProject_type()==2){
						 class22="td2_div2_agree_new_2";
						 class24="td2_div2_agree_new";
						 class26="td2_div2_agree_new";
						 class30="td2_div2_agree_new";
						 class39="td2_div2_agree_new";
						 class28="td2_div2_nodid_new";
						 class210="td2_div2_nodid_new";
					 }else{
						 class22="td2_div3_agree_new";
						 class24="td2_div3_agree_new";
						 class26="td2_div3_agree_new";
						 class30="td2_div3_agree_new";
						 class39="td2_div3_agree_new";
						 class28="td2_div3_agree_new";
						 class210="td2_div3_nodid_new";
					 }
				}
			}else if(operation==26){
				if(task.getProject_case()==0){
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class14="td2_div14_pass_new";
						class38="td2_div18_pass_new";
						class17="td2_div17_nodid_new";
						class15="td2_div15_nodid_new";
						class16="td2_div16_nodid_new";
						img1="pass.png";
						img2="pass.png";
						img3="pass.png";
						img4="pass.png";
						img8="go.png";
						img7="notdid.png";
						img5="notdid.png";
						img6="notdid.png";
						time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						time3=dft.format(lastFlowTime(24,flowList)).replace("#", "<br/>");
						time4=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						time8="";
						time7="";
						time5="";
						time6="";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class38="td2_div181_pass_new";
						class14="td2_div141_nodid_new";
						class15="td2_div151_nodid_new";
						class16="td2_div161_nodid_new";
						img1="pass.png";
						img2="pass.png";
						img3="pass.png";
						img8="go.png";
						img4="notdid.png";
						img5="notdid.png";
						img6="notdid.png";
						time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						time3=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						time8="";
						time4="";
						time5="";
						time6="";
					}
					if(task.getProject_type()==2){
						class22="td2_div2_agree_new_2";
						class24="td2_div2_agree_new";
						class26="td2_div2_agree_new";
						class30="td2_div2_agree_new";
						class39="td2_div2_nodid_new";
						class28="td2_div2_nodid_new";
						class210="td2_div2_nodid_new";
					}else{
						class22="td2_div3_agree_new";
						class24="td2_div3_agree_new";
						class39="td2_div3_agree_new";
						class26="td2_div3_nodid_new";
						class28="td2_div3_nodid_new";
						class210="td2_div3_nodid_new";
					}
				}else{
					if(task.getProject_type()==2){
						 class11="td2_div11_pass_new";
						 class12="td2_div12_pass_new";
						 class13="td2_div13_pass_new";
						 class14="td2_div14_pass_new";
						 class38="td2_div18_pass_new";
						 class17="td2_div17_nodid_new";
						 class15="td2_div15_nodid_new";
						 class16="td2_div16_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img4="pass.png";
						 img8="go.png";
						 img7="notdid.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
						 time4=dft.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
						 time8="";
						 time7="";
						 time5="";
						 time6="";
						 class22="td2_div2_agree_new_2";
						 class24="td2_div2_agree_new";
						 class26="td2_div2_agree_new";
						 class30="td2_div2_agree_new";
						 class39="td2_div2_nodid_new";
						 class28="td2_div2_nodid_new";
						 class210="td2_div2_nodid_new";
					}else {
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class14="td2_div141_pass_new";
						class38="td2_div181_pass_new";
						class15="td2_div151_nodid_new";
						class16="td2_div161_nodid_new";
						img1="pass.png";
						img2="pass.png";
						img3="pass.png";
						img4="pass.png";
						img8="go.png";
						img5="notdid.png";
						img6="notdid.png";
						time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						time3=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
						time4=dft.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
						time8="";
						time5="";
						time6="";
						if(task.getProject_type()==2){
							class22="td2_div2_agree_new";
							class24="td2_div2_agree_new";
							class26="td2_div2_agree_new";
							class30="td2_div2_agree_new";
							class28="td2_div2_nodid_new";
							class210="td2_div2_nodid_new";
						}else{
							class22="td2_div3_agree_new";
							class24="td2_div3_agree_new";
							class26="td2_div3_agree_new";
							class39="td2_div3_agree_new";
							class28="td2_div3_nodid_new";
							class210="td2_div3_nodid_new";
						}
					}
				}
			}else if (operation==27) {
				if(task.getProject_case()==0){
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class14="td2_div14_pass_new";
						class38="td2_div18_nopass_new";
						class17="td2_div17_nodid_new";
						class15="td2_div15_nodid_new";
						class16="td2_div16_nodid_new";
						img1="pass.png";
						img2="pass.png";
						img3="pass.png";
						img4="pass.png";
						img8="error.png";
						img7="notdid.png";
						img5="notdid.png";
						img6="notdid.png";
						time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						time3=dft.format(lastFlowTime(24,flowList)).replace("#", "<br/>");
						time4=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						time8="";
						time7="";
						time5="";
						time6="";
						class22="td2_div2_agree_new_2";
						class24="td2_div2_agree_new";
						class26="td2_div2_agree_new";
						class30="td2_div2_disagree_new";
						class39="td2_div2_nodid_new";
						class28="td2_div2_nodid_new";
						class210="td2_div2_nodid_new";
					}else {
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class38="td2_div181_nopass_new";
						class14="td2_div141_nodid_new";
						class15="td2_div151_nodid_new";
						class16="td2_div161_nodid_new";
						img1="pass.png";
						img2="pass.png";
						img3="pass.png";
						img8="error.png";
						img4="notdid.png";
						img5="notdid.png";
						img6="notdid.png";
						time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						time3=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						time8="";
						time4="";
						time5="";
						time6="";
						class22="td2_div3_agree_new";
						class24="td2_div3_agree_new";
						class39="td2_div3_disagree_new";
						class26="td2_div3_nodid_new";
						class28="td2_div3_nodid_new";
						class210="td2_div3_nodid_new";
					}
				}else {
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class14="td2_div14_pass_new";
						class38="td2_div18_nopass_new";
						class17="td2_div17_nodid_new";
						class15="td2_div15_nodid_new";
						class16="td2_div16_nodid_new";
						img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img4="pass.png";
						 img8="error.png";
						 img7="notdid.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
						 time4=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						 time8="";
						 time7="";
						 time5="";
						 time6="";
						 class22="td2_div2_agree_new_2";
						 class24="td2_div2_agree_new";
						 class26="td2_div2_agree_new";
						 class30="td2_div2_disagree_new";
						 class39="td2_div2_nodid_new";
						 class28="td2_div2_nodid_new";
						 class210="td2_div2_nodid_new";
					}else {
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class14="td2_div141_pass_new";
						class38="td2_div181_nopass_new";
						class15="td2_div151_nodid_new";
						class16="td2_div161_nodid_new";
						img1="pass.png";
						img2="pass.png";
						img3="pass.png";
						img4="pass.png";
						img8="error.png";
						img5="notdid.png";
						img6="notdid.png";
						time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						time3=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
						time4=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						time8="";
						time5="";
						time6="";
						class22="td2_div3_agree_new";
						class24="td2_div3_agree_new";
						class26="td2_div3_agree_new";
						class39="td2_div3_disagree_new";
						class28="td2_div3_nodid_new";
						class210="td2_div3_nodid_new";
					}
				}
			}else if(operation==18){
				if(task.getProject_case()==0){
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class14="td2_div14_nopass_new";
						class38="td2_div18_nodid_new";
						class17="td2_div17_nodid_new";
						class15="td2_div15_nodid_new";
						class16="td2_div16_nodid_new";
						img1="pass.png";
						img2="pass.png";
						img3="pass.png";
						img4="error.png";
						img8="notdid.png";
						img7="notdid.png";
						img5="notdid.png";
						img6="notdid.png";
						time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						time3=dft.format(lastFlowTime(24,flowList)).replace("#", "<br/>");
						time4="";
						time8="";
						time7="";
						time5="";
						time6="";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_nopass_new";
						class38="td2_div181_nodid_new";
						class14="td2_div141_nodid_new";
						class15="td2_div151_nodid_new";
						class16="td2_div161_nodid_new";
						img1="pass.png";
						img2="pass.png";
						img3="error.png";
						img8="notdid.png";
						img4="notdid.png";
						img5="notdid.png";
						img6="notdid.png";
						time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						time3="";
						time8="";
						time4="";
						time5="";
						time6="";
					}
					if(task.getProject_type()==2){
						class22="td2_div2_agree_new_2";
						class24="td2_div2_agree_new";
						class26="td2_div2_disagree_new";
						class30="td2_div2_nodid_new";
						class39="td2_div2_nodid_new";
						class28="td2_div2_nodid_new";
						class210="td2_div2_nodid_new";
					}else{
						class22="td2_div3_agree_new";
						class24="td2_div3_disagree_new";
						class39="td2_div3_nodid_new";
						class26="td2_div3_nodid_new";
						class28="td2_div3_nodid_new";
						class210="td2_div3_nodid_new";
					}
				}else{
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class14="td2_div14_nopass_new";
						class38="td2_div13_nodid_new";
						class17="td2_div17_nodid_new";
						class15="td2_div15_nodid_new";
						class16="td2_div16_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img4="error.png";
						 img8="notdid.png";
						 img7="notdid.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
						 time4="";
						 time8="";
						 time7="";
						 time5="";
						 time6="";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class14="td2_div141_nopass_new";
						class38="td2_div181_nodid_new";
						class15="td2_div151_nodid_new";
						class16="td2_div161_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img4="error.png";
						 img8="notdid.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
						 time4="";
						 time8="";
						 time5="";
						 time6="";
					}
					 if(task.getProject_type()==2){
						 class22="td2_div2_agree_new_2";
						 class24="td2_div2_agree_new";
						 class26="td2_div2_disagree_new";
						 class30="td2_div2_nodid_new";
						 class39="td2_div2_nodid_new";
						 class28="td2_div2_nodid_new";
						 class210="td2_div2_nodid_new";
					 }else{
						 class22="td2_div3_agree_new";
						 class24="td2_div3_agree_new";
						 class26="td2_div3_disagree_new";
						 class39="td2_div3_nodid_new";
						 class28="td2_div3_nodid_new";
						 class210="td2_div3_nodid_new";
					 }
				}
			}else if(operation==24){
				if(task.getProject_case()==0){
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class14="td2_div14_pass_new";
						class38="td2_div18_nodid_new";
						class17="td2_div17_nodid_new";
						class15="td2_div15_nodid_new";
						class16="td2_div16_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img4="go.png";
						 img8="notdid.png";
						 img7="notdid.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
						 time4="";
						 time8="";
						 time7="";
						 time5="";
						 time6="";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class14="td2_div141_nodid_new";
						class15="td2_div151_nodid_new";
						class16="td2_div161_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img4="go.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
						 time4="";
						 time5="";
						 time6="";
					}
					 if(task.getProject_type()==2){
						 class22="td2_div2_agree_new";
						 class24="td2_div2_agree_new";
						 class26="td2_div2_agree_new";
						 class30="td2_div2_nodid_new";
						 class39="td2_div2_nodid_new";
						 class28="td2_div2_nodid_new";
						 class210="td2_div2_nodid_new";
					 }else{
						 class22="td2_div3_agree_new";
						 class24="td2_div3_agree_new";
						 class26="td2_div3_agree_new";
						 class30="td2_div3_nodid_new";
						 class28="td2_div3_nodid_new";
						 class210="td2_div3_nodid_new";
					 }
				}else{
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class14="td2_div14_pass_new";
						class38="td2_div18_pass_new";
						class17="td2_div17_pass_new";
						class15="td2_div15_pass_new";
						class16="td2_div16_nodid_new";
						img1="pass.png";
						img2="pass.png";
						img3="pass.png";
						img4="pass.png";
						img8="pass.png";
						img7="pass.png";
						img5="go.png";
						img6="notdid.png";
						time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						time3=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
						time4=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						time8=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
						time7=dft.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
						time5="";
						time6="";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class14="td2_div141_nodid_new";
						class15="td2_div151_nodid_new";
						class16="td2_div161_nodid_new";
						img1="pass.png";
						img2="pass.png";
						img3="pass.png";
						img4="go.png";
						img5="notdid.png";
						img6="notdid.png";
						time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						time3=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
						time4="";
						time5="";
						time6="";
					}
					 if(task.getProject_type()==2){
						class22="td2_div2_agree_new_2";
						class24="td2_div2_agree_new";
						class26="td2_div2_agree_new";
						class30="td2_div2_agree_new";
						class39="td2_div2_agree_new";
						class28="td2_div2_agree_new";
						class210="td2_div2_nodid_new";
					 }else{
						 class22="td2_div3_agree_new";
						class24="td2_div3_agree_new";
						class26="td2_div3_agree_new";
						class30="td2_div3_agree_new";
						class28="td2_div3_nodid_new";
						class210="td2_div3_nodid_new";
					 }
				}
			}else if(operation==25){
				if(task.getProject_case()==0){
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_nopass_new";
						class14="td2_div14_nodid_new";
						class38="td2_div18_nodid_new";
						class17="td2_div17_nodid_new";
						class15="td2_div15_nodid_new";
						class16="td2_div16_nodid_new";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_nopass_new";
						class14="td2_div141_nodid_new";
						class15="td2_div151_nodid_new";
						class16="td2_div161_nodid_new";
					}
					 img1="pass.png";
					 img2="pass.png";
					 img3="error.png";
					 img4="notdid.png";
					 img8="notdid.png";
					 img7="notdid.png";
					 img5="notdid.png";
					 img6="notdid.png";
					 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					 time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
					 time3="";
					 time4="";
					 time8="";
					 time7="";
					 time5="";
					 time6="";
					 if(task.getProject_type()==2){
						 class22="td2_div2_agree_new_2";
						 class24="td2_div2_disagree_new";
						 class26="td2_div2_nodid_new";
						 class30="td2_div2_nodid_new";
						 class39="td2_div2_nodid_new";
						 class28="td2_div2_nodid_new";
						 class210="td2_div2_nodid_new";
					 }else{
						 class22="td2_div3_agree_new";
						 class24="td2_div3_disagree_new";
						 class26="td2_div3_nodid_new";
						 class30="td2_div3_nodid_new";
						 class28="td2_div3_nodid_new";
						 class210="td2_div3_nodid_new";
					 }
				}else{
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class14="td2_div14_pass_new";
						class38="td2_div18_pass_new";
						class17="td2_div17_nopass_new";
						class15="td2_div15_nodid_new";
						class16="td2_div16_nodid_new";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class14="td2_div141_nopass_new";
						class15="td2_div151_nodid_new";
						class16="td2_div161_nodid_new";
					}
					 img1="pass.png";
					 img2="pass.png";
					 img3="pass.png";
					 img4="pass.png";
					 img8="pass.png";
					 img7="error.png";
					 img5="notdid.png";
					 img6="notdid.png";
					 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
					 time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
					 time3=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
					 time4=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
					 time8=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
					 time7="";
					 time5="";
					 time6="";
					 if(task.getProject_type()==2){
						 class22="td2_div2_agree_new_2";
						 class24="td2_div2_agree_new";
						 class26="td2_div2_agree_new";
						 class30="td2_div2_agree_new";
						 class39="td2_div2_disagree_new";
						 class28="td2_div2_nodid_new";
						 class210="td2_div2_nodid_new";
					 }else{
						 class22="td2_div3_agree_new";
						 class24="td2_div3_agree_new";
						 class26="td2_div3_disagree_new";
						 class30="td2_div3_nodid_new";
						 class28="td2_div3_nodid_new";
						 class210="td2_div3_nodid_new"; 
					 }
				}
			}else if(operation==19){
				if(task.getProject_case()==0){
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class14="td2_div14_pass_new";
						class38="td2_div18_pass_new";
						class17="td2_div17_pass_new";
						class15="td2_div15_pass_new";
						class16="td2_div16_nodid_new";
						img1="pass.png";
						img2="pass.png";
						img3="pass.png";
						img4="pass.png";
						img8="pass.png";
						img7="pass.png";
						img5="go.png";
						img6="notdid.png";
						time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						time3=dft.format(lastFlowTime(24,flowList)).replace("#", "<br/>");
						time4=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						time8=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
						time7=dft.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
						time5="";
						time6="";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class38="td2_div181_pass_new";
						class14="td2_div141_pass_new";
						class15="td2_div151_pass_new";
						class16="td2_div161_nodid_new";
						img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img8="pass.png";
						 img4="pass.png";
						 img5="go.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						 time8=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
						 time4=dft.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
						 time5="";
						 time6="";
					}
					 if(task.getProject_type()==2){
						 class22="td2_div2_agree_new_2";
						 class24="td2_div2_agree_new";
						 class26="td2_div2_agree_new";
						 class30="td2_div2_agree_new";
						 class39="td2_div2_agree_new";
						 class28="td2_div2_agree_new";
						 class210="td2_div2_nodid_new";
					 }else{
						 class22="td2_div3_agree_new";
						 class24="td2_div3_agree_new";
						 class26="td2_div3_agree_new";
						 class39="td2_div3_agree_new";
						 class30="td2_div3_agree_new";
						 class28="td2_div3_agree_new";
						 class210="td2_div3_nodid_new"; 
					 }
				}else{
					if(task.getProject_type()==2){
						 class11="td2_div11_pass_new";
						 class12="td2_div12_pass_new";
						 class13="td2_div13_pass_new";
						 class14="td2_div14_nodid_new";
						 class38="td2_div18_nodid_new";
						 class17="td2_div17_nodid_new";
						 class15="td2_div15_nodid_new";
						 class16="td2_div16_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="go.png";
						 img4="notdid.png";
						 img8="notdid.png";
						 img7="notdid.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
						 time3="";
						 time4="";
						 time8="";
						 time7="";
						 time5="";
						 time6="";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class14="td2_div141_nodid_new";
						class38="td2_div181_nodid_new";
						class15="td2_div151_nodid_new";
						class16="td2_div161_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="go.png";
						 img4="notdid.png";
						 img8="notdid.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
						 time3="";
						 time4="";
						 time8="";
						 time5="";
						 time6="";
					}
					 if(task.getProject_type()==2){
						 class22="td2_div2_agree_new_2";
						 class24="td2_div2_agree_new";
						 class26="td2_div2_nodid_new";
						 class30="td2_div2_nodid_new";
						 class39="td2_div2_nodid_new";
						 class28="td2_div2_nodid_new";
						 class210="td2_div2_nodid_new";
					 }else{
						 class22="td2_div3_agree_new";
						 class24="td2_div3_agree_new";
						 class26="td2_div3_nodid_new";
						 class30="td2_div3_nodid_new";
						 class39="td2_div3_nodid_new";
						 class28="td2_div3_nodid_new";
						 class210="td2_div3_nodid_new";
					 }
				}
			}else if(operation==20){
				if(task.getProject_case()==0){
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class14="td2_div14_pass_new";
						class38="td2_div18_pass_new";
						class17="td2_div17_nopass_new";
						class15="td2_div15_nodid_new";
						class16="td2_div16_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img4="pass.png";
						 img8="pass.png";
						 img7="error.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(24,flowList)).replace("#", "<br/>");
						 time4=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						 time8=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
						 time7="";
						 time5="";
						 time6="";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class38="td2_div181_pass_new";
						class14="td2_div141_nopass_new";
						class15="td2_div151_nodid_new";
						class16="td2_div161_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img8="pass.png";
						 img4="error.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						 time8=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
						 time4="";
						 time5="";
						 time6="";
					}
					 if(task.getProject_type()==2){
						 class22="td2_div2_agree_new_2";
						 class24="td2_div2_agree_new";
						 class26="td2_div2_agree_new";
						 class30="td2_div2_agree_new";
						 class39="td2_div2_disagree_new";
						 class28="td2_div2_nodid_new";
						 class210="td2_div2_nodid_new";
					 }else{
						 class22="td2_div3_agree_new";
						 class24="td2_div3_agree_new";
						 class39="td2_div3_agree_new";
						 class26="td2_div3_disagree_new";
						 class28="td2_div3_nodid_new";
						 class210="td2_div3_nodid_new";
					 }
				}else{
					if(task.getProject_type()==2){
						 class11="td2_div11_pass_new";
						 class12="td2_div12_nopass_new";
						 class13="td2_div13_nodid_new";
						 class14="td2_div14_nodid_new";
						 class38="td2_div18_nodid_new";
						 class17="td2_div17_nodid_new";
						 class15="td2_div15_nodid_new";
						 class16="td2_div16_nodid_new";
						 img1="pass.png";
						 img2="error.png";
						 img3="notdid.png";
						 img4="notdid.png";
						 img8="notdid.png";
						 img7="notdid.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2="";
						 time3="";
						 time4="";
						 time8="";
						 time7="";
						 time5="";
						 time6="";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_nopass_new";
						class13="td2_div131_nodid_new";
						class14="td2_div141_nodid_new";
						class38="td2_div181_nodid_new";
						class15="td2_div151_nodid_new";
						class16="td2_div161_nodid_new";
						 img1="pass.png";
						 img2="error.png";
						 img3="notdid.png";
						 img4="notdid.png";
						 img8="notdid.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2="";
						 time3="";
						 time4="";
						 time8="";
						 time5="";
						 time6="";
					}
					 if(task.getProject_type()==2){
						 class22="td2_div2_disagree_new_2";
						 class24="td2_div2_nodid_new";
						 class26="td2_div2_nodid_new";
						 class30="td2_div2_nodid_new";
						 class39="td2_div2_nodid_new";
						 class28="td2_div2_nodid_new";
						 class210="td2_div2_nodid_new";
					 }else{
						 class22="td2_div3_disagree_new";
						 class24="td2_div3_nodid_new";
						 class26="td2_div3_nodid_new";
						 class39="td2_div3_nodid_new";
						 class28="td2_div3_nodid_new";
						 class210="td2_div3_nodid_new"; 
					 }
				}
			}else if(operation==21){
				if(task.getProject_case()==1){
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class14="td2_div14_pass_new";
						class38="td2_div18_nodid_new";
						class17="td2_div17_nodid_new";
						class15="td2_div15_nodid_new";
						class16="td2_div16_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img4="go.png";
						 img8="notdid.png";
						 img7="notdid.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
						 time4="";
						 time8="";
						 time7="";
						 time5="";
						 time6="";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class14="td2_div141_pass_new";
						class38="td2_div181_nodid_new";
						class15="td2_div151_nodid_new";
						class16="td2_div161_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img4="go.png";
						 img8="notdid.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
						 time4="";
						 time8="";
						 time5="";
						 time6="";
					}
					 if(task.getProject_type()==2){
						 class22="td2_div2_agree_new_2";
						 class24="td2_div2_agree_new";
						 class26="td2_div2_agree_new";
						 class30="td2_div2_nodid_new";
						 class39="td2_div2_nodid_new";
						 class28="td2_div2_nodid_new";
						 class210="td2_div2_nodid_new";
					 }else{
						 class22="td2_div3_agree_new";
						 class24="td2_div3_agree_new";
						 class26="td2_div3_agree_new";
						 class30="td2_div3_nodid_new";
						 class39="td2_div3_nodid_new";
						 class28="td2_div3_nodid_new";
						 class210="td2_div3_nodid_new"; 
					 }
				}
			}else if(operation==22){
				if(task.getProject_case()==0){
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class14="td2_div14_pass_new";
						class38="td2_div18_pass_new";
						class17="td2_div17_pass_new";
						class15="td2_div15_nopass_new";
						class16="td2_div16_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img4="pass.png";
						 img8="pass.png";
						 img7="pass.png";
						 img5="error.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(24,flowList)).replace("#", "<br/>");
						 time4=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						 time8=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
						 time7=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time5="";
						 time6="";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class38="td2_div181_pass_new";
						class14="td2_div141_pass_new";
						class15="td2_div151_nopass_new";
						class16="td2_div161_nodid_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img8="pass.png";
						 img4="pass.png";
						 img5="error.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						 time8=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
						 time4=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time5="";
						 time6="";
					}
					 if(task.getProject_type()==2){
						 class22="td2_div2_agree_new_2";
						 class24="td2_div2_agree_new";
						 class26="td2_div2_agree_new";
						 class30="td2_div2_agree_new";
						 class39="td2_div2_agree_new";
						 class28="td2_div2_disagree_new";
						 class210="td2_div2_nodid_new";
					 }else{
						 class22="td2_div3_agree_new";
						 class24="td2_div3_agree_new";
						 class39="td2_div3_agree_new";
						 class26="td2_div3_agree_new";
						 class30="td2_div3_agree_new";
						 class28="td2_div3_disagree_new";
						 class210="td2_div3_nodid_new";
					 }
				}else{
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_nopass_new";
						class14="td2_div14_nodid_new";
						class38="td2_div18_nodid_new";
						class17="td2_div17_nodid_new";
						class15="td2_div15_nodid_new";
						class16="td2_div16_nodid_new";
						img1="pass.png";
						 img2="pass.png";
						 img3="error.png";
						 img4="notdid.png";
						 img8="notdid.png";
						 img7="notdid.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time3="";
						 time4="";
						 time8="";
						 time7="";
						 time5="";
						 time6="";
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_nopass_new";
						class14="td2_div141_nodid_new";
						class38="td2_div181_nodid_new";
						class15="td2_div151_nodid_new";
						class16="td2_div161_nodid_new";
						img1="pass.png";
						 img2="pass.png";
						 img3="error.png";
						 img4="notdid.png";
						 img8="notdid.png";
						 img5="notdid.png";
						 img6="notdid.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time3="";
						 time4="";
						 time8="";
						 time5="";
						 time6="";
					}
					 if(task.getProject_type()==2){
						 class22="td2_div2_agree_new_2";
						 class24="td2_div2_disagree_new";
						 class26="td2_div2_nodid_new";
						 class30="td2_div2_nodid_new";
						 class39="td2_div2_nodid_new";
						 class28="td2_div2_nodid_new";
						 class210="td2_div2_nodid_new"; 
					 }else{
						 class22="td2_div3_agree_new";
						 class24="td2_div3_disagree_new";
						 class26="td2_div3_nodid_new";
						 class30="td2_div3_nodid_new";
						 class39="td2_div3_nodid_new";
						 class28="td2_div3_nodid_new";
						 class210="td2_div3_nodid_new"; 
					 }
					 
				}
			}else if(operation==23){
				if(task.getProject_case()==0){
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class14="td2_div14_pass_new";
						class38="td2_div18_pass_new";
						class17="td2_div17_pass_new";
						class15="td2_div15_pass_new";
						class16="td2_div16_pass_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img4="pass.png";
						 img8="pass.png";
						 img7="pass.png";
						 img5="pass.png";
						 img6="pass.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(24,flowList)).replace("#", "<br/>");
						 time4=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						 time8=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
						 time7=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time5=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
						 time6=time5;
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class38="td2_div181_pass_new";
						class14="td2_div141_pass_new";
						class15="td2_div151_pass_new";
						class16="td2_div161_pass_new";
						 img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img8="pass.png";
						 img4="pass.png";
						 img5="pass.png";
						 img6="pass.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						 time8=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
						 time4=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time5=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
						 time6=time5;
					}
					 if(task.getProject_type()==2){
						 class22="td2_div2_agree_new_2";
						 class24="td2_div2_agree_new";
						 class26="td2_div2_agree_new";
						 class30="td2_div2_agree_new";
						 class39="td2_div2_agree_new";
						 class28="td2_div2_agree_new";
						 class210="td2_div2_agree_new";
					 }else{
						 class22="td2_div3_agree_new";
						 class24="td2_div3_agree_new";
						 class39="td2_div3_agree_new";
						 class26="td2_div3_agree_new";
						 class30="td2_div3_agree_new";
						 class28="td2_div3_agree_new";
						 class210="td2_div3_agree_new";
					 }
				}else{
					if(task.getProject_type()==2){
						class11="td2_div11_pass_new";
						class12="td2_div12_pass_new";
						class13="td2_div13_pass_new";
						class17="td2_div17_pass_new";
						class38="td2_div18_pass_new";
						class14="td2_div14_pass_new";
						class15="td2_div15_pass_new";
						class16="td2_div16_pass_new";
						img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img7="pass.png";
						 img4="pass.png";
						 img8="pass.png";
						 img5="pass.png";
						 img6="pass.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
						 time4=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						 time8=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
						 time7=dft.format(lastFlowTime(24,flowList)).replace("#", "<br/>");
						 time5=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						 time6=time5;
					}else{
						class11="td2_div111_pass_new";
						class12="td2_div121_pass_new";
						class13="td2_div131_pass_new";
						class14="td2_div141_pass_new";
						class38="td2_div181_pass_new";
						class15="td2_div151_pass_new";
						class16="td2_div161_pass_new";
						img1="pass.png";
						 img2="pass.png";
						 img3="pass.png";
						 img4="pass.png";
						 img8="pass.png";
						 img5="pass.png";
						 img6="pass.png";
						 time1=dft.format(task.getCreate_time()).replace("#", "<br/>");
						 time2=dft.format(lastFlowTime(19,flowList)).replace("#", "<br/>");
						 time3=dft.format(lastFlowTime(21,flowList)).replace("#", "<br/>");
						 time4=dft.format(lastFlowTime(26,flowList)).replace("#", "<br/>");
						 time8=dft.format(lastFlowTime(17,flowList)).replace("#", "<br/>");
						 time5=dft.format(lastFlowTime(13,flowList)).replace("#", "<br/>");
						 time6=time5;
					}
					 if(task.getProject_type()==2){
						 class22="td2_div2_agree_new_2";
						 class24="td2_div2_agree_new";
						 class26="td2_div2_agree_new";
						 class30="td2_div2_agree_new";
						 class39="td2_div2_agree_new";
						 class28="td2_div2_agree_new";
						 class210="td2_div2_agree_new";
					 }else{
						 class22="td2_div3_agree_new";
						 class24="td2_div3_agree_new";
						 class26="td2_div3_agree_new";
						 class30="td2_div3_agree_new";
						 class39="td2_div3_agree_new";
						 class28="td2_div3_agree_new";
						 class210="td2_div3_agree_new";
					 }
				}
			}else{
				return null;
			}
			map.put("name1", name1);
			map.put("name2", name2);
			map.put("name3", name3);
			map.put("name4", name4);
			map.put("name5", name5);
			map.put("name6", name6);
			map.put("name7", name7);
			map.put("name8", name8);
			map.put("class11", class11);
			map.put("class12", class12);
			map.put("class13", class13);
			map.put("class14", class14);
			map.put("class15", class15);
			map.put("class16", class16);
			map.put("class17", class17);
			map.put("class22", class22);
			map.put("class24", class24);
			map.put("class26", class26);
			map.put("class28", class28);
			map.put("class210", class210);
			map.put("class30", class30);
			map.put("class38", class38);
			map.put("class39", class39);
			map.put("img1", img1);
			map.put("img2", img2);
			map.put("img3", img3);
			map.put("img4", img4);
			map.put("img5", img5);
			map.put("img6", img6);
			map.put("img7", img7);
			map.put("img8", img8);
			map.put("time1", time1);
			map.put("time2", time2);
			map.put("time3", time3);
			map.put("time4", time4);
			map.put("time5", time5);
			map.put("time6", time6);
			map.put("time7", time7);
			map.put("time8", time8);
		}
		return map;
	}
	public void updateRemarks(Task task){
		taskDAO.updateRemarks(task);
	}

	public List<Task> getFinishTaskList() {
		// TODO Auto-generated method stub
		return taskDAO.getFinishTaskList();
	}
}
