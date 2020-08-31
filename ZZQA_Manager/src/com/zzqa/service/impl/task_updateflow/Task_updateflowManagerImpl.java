package com.zzqa.service.impl.task_updateflow;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.task_updateflow.ITask_updateflowDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.task_updateflow.Task_updateflow;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.task_updateflow.Task_updateflowManager;
import com.zzqa.util.DataUtil;

@Service("task_updateflowManager")
public class Task_updateflowManagerImpl implements Task_updateflowManager {
	
	@Autowired
	private ITask_updateflowDAO task_updateflowDAO;
	@Autowired
	private IFlowDAO flowDAO;
	@Autowired
	private IUserDAO userDAO;
	@Autowired
	private IPermissionsDAO permissionsDAO;
	@Override
	public int insertTask_updateflow(Task_updateflow task_updateflow) {
		// TODO Auto-generated method stub
		return task_updateflowDAO.insertTask_updateflow(task_updateflow);
	}
	@Override
	public Map<String, String> getTask_updateflow(Flow flow) {
		// TODO Auto-generated method stub
		int operation=flow.getOperation();
		Map<String, String> map=new HashMap<String, String>();
		List<Flow> flowList=flowDAO.getFlowListByCondition(21,flow.getForeign_id());
		SimpleDateFormat dft=new SimpleDateFormat("yyyy-MM-dd*HH:mm:ss");
		String td2_div1_1="td2_div1_1";
		String td2_div1_2="td2_div1_2";
		String td2_div1_3="td2_div1_3";
		String class11="";
		String class12="";
		String class13="";
		String class14="";
		String class15="";
		String class16="";
		String class110="";
		String img1="";
		String img2="";
		String img3="";
		String img4="";
		String img5="";
		String img6="";
		String img10="";
		String time1="";
		String time2="";
		String time3="";
		String time4="";
		String time5="";
		String time6="";
		String time10="";
		String class21="";
		String class22="";
		String class23="";
		String class24="";
		String class25="";
		String class26="";
		String class29="";
		if(operation==1){
			//创建
			 class11="title_did";
			 class12="title_notdid";
			 class13="title_notdid";
			 class14="title_notdid";
			 class15="title_notdid";
			 class16="title_notdid";
			 img1="pass.png";
			 img2="go.png";
			 img3="notdid.png";
			 img4="notdid.png";
			 img5="notdid.png";
			 img6="notdid.png";
			 time1=dft.format(flowList.get(0).getCreate_time()).replace("*", "<br/>");
			 time2="";
			 time3="";
			 time4="";
			 time5="";
			 time6="";
			 class21="td2_div2_agree";
			 class22="td2_div2_nodid";
			 class23="td2_div2_nodid";
			 class24="td2_div2_nodid";
			 class25="td2_div2_nodid";
			 class26="td2_div2_nodid";
		}else if(operation==2){
			//财务部门审核通过
			 class11="title_did";
			 class12="title_did";
			 class13="title_notdid";
			 class14="title_notdid";
			 class15="title_notdid";
			 class16="title_notdid";
			 img1="pass.png";
			 img2="pass.png";
			 img3="go.png";
			 img4="notdid.png";
			 img5="notdid.png";
			 img6="notdid.png";
			 time1=dft.format(flowList.get(0).getCreate_time()).replace("*", "<br/>");
			 time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			 time3="";
			 time4="";
			 time5="";
			 time6="";
			 class21="td2_div2_agree";
			 class22="td2_div2_agree";
			 class23="td2_div2_nodid";
			 class24="td2_div2_nodid";
			 class25="td2_div2_nodid";
			 class26="td2_div2_nodid";
		}else if(operation==4){
			//生产部门审核通过
			 class11="title_did";
			 class12="title_did";
			 class13="title_did";
			 class14="title_notdid";
			 class15="title_notdid";
			 class16="title_notdid";
			 img1="pass.png";
			 img2="pass.png";
			 img3="pass.png";
			 img4="go.png";
			 img5="notdid.png";
			 img6="notdid.png";
			 time1=dft.format(flowList.get(0).getCreate_time()).replace("*", "<br/>");
			 time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			 time3=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
			 time4="";
			 time5="";
			 time6="";
			 class21="td2_div2_agree";
			 class22="td2_div2_agree";
			 class23="td2_div2_agree";
			 class24="td2_div2_nodid";
			 class25="td2_div2_nodid";
			 class26="td2_div2_nodid";
		}else if(operation==6){
			//部门总监审核通过
			 class11="title_did";
			 class12="title_did";
			 class13="title_did";
			 class14="title_did";
			 class15="title_notdid";
			 class16="title_notdid";
			 img1="pass.png";
			 img2="pass.png";
			 img3="pass.png";
			 img4="pass.png";
			 img5="go.png";
			 img6="notdid.png";
			 time1=dft.format(flowList.get(0).getCreate_time()).replace("*", "<br/>");
			 time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			 time3=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
			 time4=dft.format(lastFlowTime(6, flowList)).replace("*", "<br/>");
			 time5="";
			 time6="";
			 class21="td2_div2_agree";
			 class22="td2_div2_agree";
			 class23="td2_div2_agree";
			 class24="td2_div2_agree";
			 class25="td2_div2_nodid";
			 class26="td2_div2_nodid";
		}else if(operation==8){
			//总经理确认
			class11="title_did";
			 class12="title_did";
			 class13="title_did";
			 class14="title_did";
			 class15="title_did";
			 class16="title_notdid";
			 img1="pass.png";
			 img2="pass.png";
			 img3="pass.png";
			 img4="pass.png";
			 img5="pass.png";
			 img6="pass.png";
			 time1=dft.format(flowList.get(0).getCreate_time()).replace("*", "<br/>");
			 time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			 time3=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
			 time4=dft.format(lastFlowTime(6, flowList)).replace("*", "<br/>");
			 time5=dft.format(lastFlowTime(8, flowList)).replace("*", "<br/>");
			 time6="";
			 class21="td2_div2_agree";
			 class22="td2_div2_agree";
			 class23="td2_div2_agree";
			 class24="td2_div2_agree";
			 class25="td2_div2_agree";
			 class26="td2_div2_nodid";
		}else if(operation==11){
			//完成
			 class11="title_did";
			 class12="title_did";
			 class13="title_did";
			 class14="title_did";
			 class15="title_did";
			 class16="title_did";
			 img1="pass.png";
			 img2="pass.png";
			 img3="pass.png";
			 img4="pass.png";
			 img5="pass.png";
			 img6="pass.png";
			 time1=dft.format(flowList.get(0).getCreate_time()).replace("*", "<br/>");
			 time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			 time3=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
			 time4=dft.format(lastFlowTime(6, flowList)).replace("*", "<br/>");
			 time5=dft.format(lastFlowTime(8, flowList)).replace("*", "<br/>");
			 time6=dft.format(lastFlowTime(11, flowList)).replace("*", "<br/>");
			 class21="td2_div2_agree";
			 class22="td2_div2_agree";
			 class23="td2_div2_agree";
			 class24="td2_div2_agree";
			 class25="td2_div2_agree";
			 class26="td2_div2_agree";
		}else if(operation==10 || operation==3 || operation==5 || operation==7 || operation==9){
			//已撤销
			 class11="title_did";
			 class110="title_error";
			 img1="pass.png";
			 img10="error.png";
			 time1=dft.format(flowList.get(0).getCreate_time()).replace("*", "<br/>");
			 time10=dft.format(lastFlowTime(operation, flowList)).replace("*", "<br/>");
			 class29="td2_div2_disagree";
		}
		map.put("td2_div1_1", td2_div1_1);
		map.put("td2_div1_2", td2_div1_2);
		map.put("td2_div1_3", td2_div1_3);
		
		map.put("class11", class11);
		map.put("class12", class12);
		map.put("class13", class13);
		map.put("class14", class14);
		map.put("class15", class15);
		map.put("class16", class16);
		map.put("class110", class110);
		
		map.put("img1", img1);
		map.put("img2", img2);
		map.put("img3", img3);
		map.put("img4", img4);
		map.put("img5", img5);
		map.put("img6", img6);
		map.put("img10", img10);
		
		map.put("time1", time1);
		map.put("time2", time2);
		map.put("time3", time3);
		map.put("time4", time4);
		map.put("time5", time5);
		map.put("time6", time6);
		map.put("time10", time10);
		
		map.put("class21", class21);
		map.put("class22", class22);
		map.put("class23", class23);
		map.put("class24", class24);
		map.put("class25", class25);
		map.put("class26", class26);
		map.put("class29", class29);
		return map;
	}
	
	public long lastFlowTime(int operation,List<Flow> flowList){
		int len=flowList.size();
		for (int i = 0; i < len; i++) {
			if(flowList.get(len-i-1).getOperation()==operation){
				return flowList.get(len-i-1).getCreate_time();
			}
		}
		return 0;
	}
	
	public List<Task_updateflow> getTask_updateflowListByUID(User mUser) {
		// TODO Auto-generated method stub
		List<Task_updateflow> task_updateflowList = task_updateflowDAO.getRunningTask_updateflow();
		SimpleDateFormat sdf=DataUtil.getSdf("yyyy.MM.dd");
		String[] flowArray21=DataUtil.getFlowArray(21);
		Iterator<Task_updateflow> iterator = task_updateflowList.iterator();
		while (iterator.hasNext()) {
			Task_updateflow task_updateflow = iterator.next();
			Flow flow=flowDAO.getNewFlowByFID(21, task_updateflow.getId());//查询最新流程
			if(flow!=null&&checkMyOperation(flow.getOperation(),mUser,task_updateflow)){
				String process=sdf.format(flow.getCreate_time())+flowArray21[flow.getOperation()];
				task_updateflow.setProcess(process);
				task_updateflow.setName("项目启动任务单修改申请流程");
			}else{
				iterator.remove();
			}
		}
		return task_updateflowList;
	}
	
	public boolean checkMyOperation(int operation,User user,Task_updateflow task_updateflow){
		boolean flag=false;
		switch (operation) {
		case 1:
			flag=permissionsDAO.checkPermission(user.getPosition_id(), 160);
			break;
		case 2:
			flag=permissionsDAO.checkPermission(user.getPosition_id(), 161);
			break;
		case 3:
			flag=task_updateflow.getCreate_id()==user.getId();
			break;
		case 4:
			flag=permissionsDAO.checkPermission(user.getPosition_id(), 162);
			break;
		case 5:
			flag=task_updateflow.getCreate_id()==user.getId();
			break;
		case 6:
			flag=permissionsDAO.checkPermission(user.getPosition_id(), 9);/*||product_procurement.getCreate_id()==user.getId()*/
			break;
		case 7:
			flag=task_updateflow.getCreate_id()==user.getId();
			break;
		/*case 8:
			flag=permissionsDAO.checkPermission(user.getPosition_id(), 23);
			break;*/
		case 9:
			flag=task_updateflow.getCreate_id()==user.getId();
			break;
		default:
			break;
		}
		return flag;
	}
	@Override
	public Task_updateflow getTask_updateflowById(int id) {
		// TODO Auto-generated method stub
		return task_updateflowDAO.getTask_updateflowById(id);
	}
	@Override
	public Task_updateflow getTask_updateflowByTaskId(int forignId) {
		// TODO Auto-generated method stub
		return task_updateflowDAO.getTask_updateflowByTaskId(forignId);
	}
	@Override
	public void updateTask_updateflowCount(int task_id) {
		// TODO Auto-generated method stub
		task_updateflowDAO.updateTask_updateflowCount(task_id);
	}

}
