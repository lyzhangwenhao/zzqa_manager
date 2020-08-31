package com.zzqa.service.impl.project_procurement;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.file_path.IFile_pathDAO;
import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.position_user.IPosition_userDAO;
import com.zzqa.dao.interfaces.procurement.IProcurementDAO;
import com.zzqa.dao.interfaces.project_procurement.IProject_procurementDAO;
import com.zzqa.dao.interfaces.task.ITaskDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.project_procurement.Project_procurement;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.project_procurement.Project_procurementManager;
import com.zzqa.util.DataUtil;
@Component("project_procurementManager")
public class Project_procurementManagerImpl implements
		Project_procurementManager {
	@Autowired
	private IProject_procurementDAO project_procurementDAO;
	@Autowired
	private IProcurementDAO procurementDAO;
	@Autowired
	private ITaskDAO taskDAO;
	@Autowired
	private IUserDAO userDAO;
	@Autowired
	private IPosition_userDAO position_userDAO;
	@Autowired
	private IFile_pathDAO file_pathDAO;
	@Autowired
	private IFlowDAO flowDAO;
	@Autowired
	private IPermissionsDAO permissionsDAO;
	
	public void delProject_procurementByID(int id) {
		// TODO Auto-generated method stub
		project_procurementDAO.delProject_procurementByID(id);
	}
	public Project_procurement getProject_procurementByID(int id) {
		// TODO Auto-generated method stub
		Project_procurement pp=project_procurementDAO.getProject_procurementByID(id);
		if(pp!=null){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			pp.setCreate_name(userDAO.getUserNameByID(pp.getCreate_id()));
			pp.setReceive_name(userDAO.getUserNameByID(pp.getReceive_id()));
			pp.setPredict_date(pp.getPredict_time()==0?"":sdf.format(pp.getPredict_time()));
			pp.setAog_date(pp.getAog_time()==0?"":sdf.format(pp.getAog_time()));
			pp.setCheck_name(userDAO.getUserNameByID(pp.getCheck_id()));
		    pp.setPutin_name(userDAO.getUserNameByID(pp.getPutin_id()));
		}
		return pp;
	}
	public Project_procurement getProject_procurementByID2(int id) {
		// TODO Auto-generated method stub
		Project_procurement pp=project_procurementDAO.getProject_procurementByID(id);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		Flow flow=flowDAO.getNewFlowByFID(3, pp.getId());//查询最新流程
		String process=sdf.format(flow.getCreate_time())+DataUtil.getFlowArray(3)[flow.getOperation()];
		pp.setName(DataUtil.getFlowNameArray()[3]+"-"+taskDAO.getTask2ByID(pp.getTask_id()).getProject_name());
		pp.setProcess(process);
		pp.setCreate_name(userDAO.getUserNameByID(pp.getCreate_id()));
		return pp;
	}
	public int getProject_procurementCount() {
		// TODO Auto-generated method stub
		return project_procurementDAO.getProject_procurementCount();
	}
	public List<Project_procurement> getProject_procurementList(int beginrow,int rows) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("beginrow", beginrow);
		map.put("rows", rows);
		List<Project_procurement> ppList=project_procurementDAO.getProject_procurementList(map);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		List<Project_procurement> ppList2=new ArrayList<Project_procurement>();
		String flowTypeName=DataUtil.getFlowNameArray()[3]+"-";
		String[] flowArray3=DataUtil.getFlowArray(3);
		for(Project_procurement pp:ppList){
			Flow flow=flowDAO.getNewFlowByFID(3, pp.getId());//查询最新流程
			Task task=taskDAO.getTask2ByID(pp.getTask_id());
			if(flow!=null&&pp.getTask_id()>0&&task!=null){
				String process=sdf.format(pp.getCreate_time())+flowArray3[flow.getOperation()];
				pp.setName(flowTypeName+task.getProject_name());
				pp.setProcess(process);
				ppList2.add(pp);
			}
		}
		return ppList2;
	}
	public void insertProject_procurement(
			Project_procurement project_procurement) {
		// TODO Auto-generated method stub
		project_procurementDAO.insertProject_procurement(project_procurement);
	}
	public void updateProject_procurement(
			Project_procurement project_procurement) {
		// TODO Auto-generated method stub
		project_procurementDAO.updateProject_procurement(project_procurement);
	}
	public int getNewProject_procurementByUID(int create_id) {
		// TODO Auto-generated method stub
		return project_procurementDAO.getNewProject_procurementByUID(create_id);
	}
	public Map<String, String> getProjectPFlowForDraw(Project_procurement project_procurement,Flow flow) {
		// TODO Auto-generated method stub
		int operation=flow.getOperation();
		Map<String, String> map=new HashMap<String, String>();
		List<Flow> flowList=flowDAO.getFlowListByCondition(3,project_procurement.getId());
		boolean isRelate=project_procurement.getProject_pid()>0;//是否关联其他项目采购单
		SimpleDateFormat dft=new SimpleDateFormat("yyyy-MM-dd*HH:mm:ss");
//		Task taskByID = taskDAO.getTaskByID(project_procurement.getTask_id());
		//String is_new_data = taskByID.getIs_new_data();
		String td2_div1_1=null;
		String td2_div1_2=null;
		String td2_div1_3=null;
		if(operation==17){
			td2_div1_1="td2_div1_1_del";
			td2_div1_2="td2_div1_2_del";
			td2_div1_3="td2_div1_3_del";
		}else if(isRelate){
			td2_div1_1="td2_div1_1_hide";
			td2_div1_2="td2_div1_2_hide";
			td2_div1_3="td2_div1_3_hide";
		}else {
			td2_div1_1="td2_div1_1";
			td2_div1_2="td2_div1_2";
			td2_div1_3="td2_div1_3";
		}
		String class11="";
		String class12="";
		String class13="";
		String class14="";
		String class15="";
		String class16="";
		String class17="";
		String class19="";
		String class110="";
		String img1="";
		String img2="";
		String img3="";
		String img4="";
		String img5="";
		String img6="";
		String img7="";
		String img9="";
		String img10="";
		String time1="";
		String time2="";
		String time3="";
		String time4="";
		String time5="";
		String time6="";
		String time7="";
		String time9="";
		String time10="";
		String class21="";
		String class22="";
		String class23="";
		String class24="";
		String class25="";
		String class26="";
		String class275="";
		String class276="";
		String class29="";
//		if ("1".equals(is_new_data)){
		//直接按照新的流程显示
		if (true){
			if(operation==1){
				//创建
				class11="title_did";
				class12="title_notdid";
				class13="title_notdid";
				class14="title_notdid";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="go.png";
				img3="notdid.png";
				img4="notdid.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2="";
				time3="";
				time4="";
				time5="";
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_nodid";
				class23="td2_div2_nodid";
				class24="td2_div2_nodid";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==2){
				//项目经理审核通过(原来)
				//销售总监审核通过
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_notdid";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="go.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(18, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time4="";
				time5="";
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_nodid";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==3){
				//项目经理审核未通过
				class11="title_did";
				class12="title_error";
				class13="title_notdid";
				class14="title_notdid";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="error.png";
				img3="notdid.png";
				img4="notdid.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(3, flowList)).replace("*", "<br/>");
				time3="";
				time4="";
				time5="";
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_disagree";
				class22="td2_div2_nodid";
				class23="td2_div2_nodid";
				class24="td2_div2_nodid";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==18){
				//工程经理审核通过
				class11="title_did";
				class12="title_did";
				class13="title_notdid";
				class14="title_notdid";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="go.png";
				img4="notdid.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(18, flowList)).replace("*", "<br/>");
				time3="";
				time4="";
				time5="";
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_nodid";
				class24="td2_div2_nodid";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==19){
				//销售总监审核未通过
				class11="title_did";
				class12="title_did";
				class13="title_error";
				class14="title_notdid";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="error.png";
				img4="notdid.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(18, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(19, flowList)).replace("*", "<br/>");
				time4="";
				time5="";
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_disagree";
				class23="td2_div2_nodid";
				class24="td2_div2_nodid";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==12){
				//运营总监审核通过
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_notdid";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="go.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(12, flowList)).replace("*", "<br/>");
				time4="";
				time5="";
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_nodid";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==13){
				//运营总监审核未通过
				class11="title_did";
				class12="title_did";
				class13="title_error";
				class14="title_notdid";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="error.png";
				img4="notdid.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(13, flowList)).replace("*", "<br/>");
				time4="";
				time5="";
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_disagree";
				class23="td2_div2_nodid";
				class24="td2_div2_nodid";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==14){
				//总经理审核通过
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_did";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="go.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(18, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(14, flowList)).replace("*", "<br/>");
				time5="";
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_agree";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==15){
				//总经理审核未通过
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_error";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="error.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(18, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(15, flowList)).replace("*", "<br/>");
				time5="";
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_disagree";
				class24="td2_div2_nodid";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==16){
				//关联采购预算表
				class11="title_did";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_disagree";
				class24="td2_div2_nodid";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==4){
				//创建项目采购需求单
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_did";
				class15="title_did";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img6="go.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(18, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(14, flowList)).replace("*", "<br/>");
				time5=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_agree";
				class25="td2_div2_agree";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==5){
				//运营总监审核通过(采购单审核)
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_did";
				class15="title_did";
				class16="title_did";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img6="pass.png";
				img7="go.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(18, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(14, flowList)).replace("*", "<br/>");
				time5=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
				time6=dft.format(lastFlowTime(5, flowList)).replace("*", "<br/>");
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_agree";
				class25="td2_div2_agree";
				class26="td2_div2_agree";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==6){
				//运营总监审核未通过
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_did";
				class15="title_did";
				class16="title_error";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img6="error.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(18, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(14, flowList)).replace("*", "<br/>");
				time5=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
				time6=dft.format(lastFlowTime(6, flowList)).replace("*", "<br/>");
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_agree";
				class25="td2_div2_disagree";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==7){
				//采购人员已确认
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_did";
				class15="title_did";
				class16="title_did";
				class17="title_did";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img6="pass.png";
				img7="pass.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(18, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(14, flowList)).replace("*", "<br/>");
				time5=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
				time6=dft.format(lastFlowTime(5, flowList)).replace("*", "<br/>");
				time7=dft.format(lastFlowTime(7, flowList)).replace("*", "<br/>");
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_agree";
				class25="td2_div2_agree";
				class26="td2_div2_agree";
				class275="td2_div2_agree_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==8){
				//采购完成
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_did";
				class15="title_did";
				class16="title_did";
				class17="title_did";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img6="pass.png";
				img7="pass.png";
				img9="go.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(18, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(14, flowList)).replace("*", "<br/>");
				time5=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
				time6=dft.format(lastFlowTime(5, flowList)).replace("*", "<br/>");
				time7=dft.format(lastFlowTime(7, flowList)).replace("*", "<br/>");
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_agree";
				class25="td2_div2_agree";
				class26="td2_div2_agree";
				class275="td2_div2_agree_c";
				class276="td2_div2_agree_c";
				class29="td2_div2_nodid";
			}else if(operation==10){
				//验货
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_did";
				class15="title_did";
				class16="title_did";
				class17="title_did";
				class19="title_did";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img6="pass.png";
				img7="pass.png";
				img9="pass.png";
				img10="go.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(18, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(14, flowList)).replace("*", "<br/>");
				time5=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
				time6=dft.format(lastFlowTime(5, flowList)).replace("*", "<br/>");
				time7=dft.format(lastFlowTime(7, flowList)).replace("*", "<br/>");
				time9=dft.format(lastFlowTime(10, flowList)).replace("*", "<br/>");
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_agree";
				class25="td2_div2_agree";
				class26="td2_div2_agree";
				class275="td2_div2_agree_c";
				class276="td2_div2_agree_c";
				class29="td2_div2_agree";
			}else if(operation==11){
				//入库
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_did";
				class15="title_did";
				class16="title_did";
				class17="title_did";
				class19="title_did";
				class110="title_did";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img6="pass.png";
				img7="pass.png";
				img9="pass.png";
				img10="pass.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(18, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(14, flowList)).replace("*", "<br/>");
				time5=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
				time6=dft.format(lastFlowTime(5, flowList)).replace("*", "<br/>");
				time7=dft.format(lastFlowTime(7, flowList)).replace("*", "<br/>");
				time9=dft.format(lastFlowTime(10, flowList)).replace("*", "<br/>");
				time10=dft.format(lastFlowTime(11, flowList)).replace("*", "<br/>");
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_agree";
				class25="td2_div2_agree";
				class26="td2_div2_agree";
				class275="td2_div2_agree_c";
				class276="td2_div2_agree_c";
				class29="td2_div2_agree";
			}else if(operation==17){
				//已撤销
				class11="title_did";
				class110="title_error";
				img1="pass.png";
				img10="error.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time10=dft.format(lastFlowTime(17, flowList)).replace("*", "<br/>");
				class29="td2_div2_disagree";
			}
		}else{//旧数据




















			if(operation==1){
				//创建
				class11="title_did";
				class12="title_notdid";
				class13="title_notdid";
				class14="title_notdid";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="go.png";
				img3="notdid.png";
				img4="notdid.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2="";
				time3="";
				time4="";
				time5="";
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_nodid";
				class23="td2_div2_nodid";
				class24="td2_div2_nodid";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==2){
				//项目经理审核通过
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_notdid";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="go.png";
				img4="go.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time3="";
				time4="";
				time5="";
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_nodid";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==3){
				//项目经理审核未通过
				class11="title_did";
				class12="title_error";
				class13="title_error";
				class14="title_notdid";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="error.png";
				img3="error.png";
				img4="notdid.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(3, flowList)).replace("*", "<br/>");
				time3="";
				time4="";
				time5="";
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_disagree";
				class22="td2_div2_nodid";
				class23="td2_div2_nodid";
				class24="td2_div2_nodid";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==12){
				//运营总监审核通过
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_notdid";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="go.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(12, flowList)).replace("*", "<br/>");
				time4="";
				time5="";
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_nodid";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==13){
				//运营总监审核未通过
				class11="title_did";
				class12="title_did";
				class13="title_error";
				class14="title_notdid";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="error.png";
				img4="notdid.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(13, flowList)).replace("*", "<br/>");
				time4="";
				time5="";
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_disagree";
				class23="td2_div2_nodid";
				class24="td2_div2_nodid";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==14){
				//总经理审核通过
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_did";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="go.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(14, flowList)).replace("*", "<br/>");
				time5="";
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_agree";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==15){
				//总经理审核未通过
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_error";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="error.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(12, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(15, flowList)).replace("*", "<br/>");
				time5="";
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_disagree";
				class23="td2_div2_disagree";
				class24="td2_div2_nodid";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==16){
				//关联采购预算表
				class11="title_did";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_disagree";
				class24="td2_div2_nodid";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==18){
				//工程经理审核通过
				class11="title_did";
				class12="title_did";
				class13="title_notdid";
				class14="title_notdid";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="go.png";
				img4="notdid.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(18, flowList)).replace("*", "<br/>");
				time3="";
				time4="";
				time5="";
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_nodid";
				class24="td2_div2_nodid";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==19){
				//销售总监审核未通过
				class11="title_did";
				class12="title_did";
				class13="title_error";
				class14="title_notdid";
				class15="title_notdid";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="error.png";
				img4="notdid.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(18, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(19, flowList)).replace("*", "<br/>");
				time4="";
				time5="";
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_disagree";
				class23="td2_div2_nodid";
				class24="td2_div2_nodid";
				class25="td2_div2_nodid";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==4){
				//创建项目采购需求单
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_did";
				class15="title_did";
				class16="title_notdid";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img6="go.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(12, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(14, flowList)).replace("*", "<br/>");
				time5=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
				time6="";
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_agree";
				class25="td2_div2_agree";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==5){
				//运营总监审核通过
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_did";
				class15="title_did";
				class16="title_did";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img6="pass.png";
				img7="go.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(12, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(14, flowList)).replace("*", "<br/>");
				time5=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
				time6=dft.format(lastFlowTime(5, flowList)).replace("*", "<br/>");
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_agree";
				class25="td2_div2_agree";
				class26="td2_div2_agree";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==6){
				//运营总监审核未通过
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_did";
				class15="title_did";
				class16="title_error";
				class17="title_notdid";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img6="error.png";
				img7="notdid.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(12, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(14, flowList)).replace("*", "<br/>");
				time5=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
				time6=dft.format(lastFlowTime(6, flowList)).replace("*", "<br/>");
				time7="";
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_agree";
				class25="td2_div2_disagree";
				class26="td2_div2_nodid";
				class275="td2_div2_nodid_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==7){
				//采购人员已确认
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_did";
				class15="title_did";
				class16="title_did";
				class17="title_did";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img6="pass.png";
				img7="pass.png";
				img9="notdid.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(12, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(14, flowList)).replace("*", "<br/>");
				time5=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
				time6=dft.format(lastFlowTime(5, flowList)).replace("*", "<br/>");
				time7=dft.format(lastFlowTime(7, flowList)).replace("*", "<br/>");
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_agree";
				class25="td2_div2_agree";
				class26="td2_div2_agree";
				class275="td2_div2_agree_c";
				class276="td2_div2_nodid_c";
				class29="td2_div2_nodid";
			}else if(operation==8){
				//采购完成
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_did";
				class15="title_did";
				class16="title_did";
				class17="title_did";
				class19="title_notdid";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img6="pass.png";
				img7="pass.png";
				img9="go.png";
				img10="notdid.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(12, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(14, flowList)).replace("*", "<br/>");
				time5=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
				time6=dft.format(lastFlowTime(5, flowList)).replace("*", "<br/>");
				time7=dft.format(lastFlowTime(7, flowList)).replace("*", "<br/>");
				time9="";
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_agree";
				class25="td2_div2_agree";
				class26="td2_div2_agree";
				class275="td2_div2_agree_c";
				class276="td2_div2_agree_c";
				class29="td2_div2_nodid";
			}else if(operation==10){
				//验货
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_did";
				class15="title_did";
				class16="title_did";
				class17="title_did";
				class19="title_did";
				class110="title_notdid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img6="pass.png";
				img7="pass.png";
				img9="pass.png";
				img10="go.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(12, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(14, flowList)).replace("*", "<br/>");
				time5=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
				time6=dft.format(lastFlowTime(5, flowList)).replace("*", "<br/>");
				time7=dft.format(lastFlowTime(7, flowList)).replace("*", "<br/>");
				time9=dft.format(lastFlowTime(10, flowList)).replace("*", "<br/>");
				time10="";
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_agree";
				class25="td2_div2_agree";
				class26="td2_div2_agree";
				class275="td2_div2_agree_c";
				class276="td2_div2_agree_c";
				class29="td2_div2_agree";
			}else if(operation==11){
				//入库
				class11="title_did";
				class12="title_did";
				class13="title_did";
				class14="title_did";
				class15="title_did";
				class16="title_did";
				class17="title_did";
				class19="title_did";
				class110="title_did";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img6="pass.png";
				img7="pass.png";
				img9="pass.png";
				img10="pass.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(12, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(14, flowList)).replace("*", "<br/>");
				time5=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
				time6=dft.format(lastFlowTime(5, flowList)).replace("*", "<br/>");
				time7=dft.format(lastFlowTime(7, flowList)).replace("*", "<br/>");
				time9=dft.format(lastFlowTime(10, flowList)).replace("*", "<br/>");
				time10=dft.format(lastFlowTime(11, flowList)).replace("*", "<br/>");
				class21="td2_div2_agree";
				class22="td2_div2_agree";
				class23="td2_div2_agree";
				class24="td2_div2_agree";
				class25="td2_div2_agree";
				class26="td2_div2_agree";
				class275="td2_div2_agree_c";
				class276="td2_div2_agree_c";
				class29="td2_div2_agree";
			}else if(operation==17){
				//已撤销
				class11="title_did";
				class110="title_error";
				img1="pass.png";
				img10="error.png";
				time1=dft.format(project_procurement.getCreate_time()).replace("*", "<br/>");
				time10=dft.format(lastFlowTime(17, flowList)).replace("*", "<br/>");
				class29="td2_div2_disagree";
			}
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
		map.put("class17", class17);
		map.put("class19", class19);
		map.put("class110", class110);
		
		map.put("img1", img1);
		map.put("img2", img2);
		map.put("img3", img3);
		map.put("img4", img4);
		map.put("img5", img5);
		map.put("img6", img6);
		map.put("img7", img7);
		map.put("img9", img9);
		map.put("img10", img10);
		
		map.put("time1", time1);
		map.put("time2", time2);
		map.put("time3", time3);
		map.put("time4", time4);
		map.put("time5", time5);
		map.put("time6", time6);
		map.put("time7", time7);
		map.put("time9", time9);
		map.put("time10", time10);
		
		map.put("class21", class21);
		map.put("class22", class22);
		map.put("class23", class23);
		map.put("class24", class24);
		map.put("class25", class25);
		map.put("class26", class26);
		map.put("class275", class275);
		map.put("class276", class276);
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
	public List<Project_procurement> getProject_procurementListByUID(User user) {
		// TODO Auto-generated method stub
		List<Project_procurement> prodject_procurementList=project_procurementDAO.getRunningProject_procurement();//查询未完成的项目采购流程
//		List<Project_procurement> pList=new ArrayList<Project_procurement>();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		String flowTypeName=DataUtil.getFlowNameArray()[3]+"-";
		String[] flowArray3=DataUtil.getFlowArray(3);
		Iterator<Project_procurement> iterator=prodject_procurementList.iterator();
		while (iterator.hasNext()) {
			Project_procurement project_procurement = (Project_procurement) iterator.next();
			User userByID = userDAO.getUserByID(project_procurement.getCreate_id());
			if(userByID==null || userByID.getPosition_id()==56){
				iterator.remove();
				continue;
			}
			Flow flow=flowDAO.getNewFlowByFID(3, project_procurement.getId());//查询最新流程
			if(checkMyOperation(flow.getOperation(),user,project_procurement)){
				String process=sdf.format(flow.getCreate_time())+flowArray3[flow.getOperation()];
				Task task2ByID = taskDAO.getTask2ByID(project_procurement.getTask_id());
				if(task2ByID==null){
//					return prodject_procurementList;
					iterator.remove();
					continue;
				}
				project_procurement.setName(flowTypeName+task2ByID.getProject_name());
				project_procurement.setProcess(process);
				project_procurement.setCreate_name(userByID.getTruename());
			}else{
				iterator.remove();
			}
			
		}
		return prodject_procurementList;
	}
	public boolean checkMyOperation(int operation,User user,Project_procurement project_procurement){
		boolean flag=false;
		int position_id=user.getPosition_id();
		Task task=taskDAO.getTaskByID(project_procurement.getTask_id());
		switch (operation) {
		case 1:
			if(task!=null){
				flag=permissionsDAO.checkPermission(position_id,DataUtil.getPurchasePIDArray(task.getType(), task.getProject_category()));
			}
			break;
		case 2:
//			flag=permissionsDAO.checkPermission(position_id,DataUtil.getOfficerPIDArray(task.getType(), task.getProject_category()));
			flag=permissionsDAO.checkPermission(position_id,16 );
			break;
		case 3:
			flag=project_procurement.getCreate_id()==user.getId();
			break;
		case 4:
			flag=permissionsDAO.checkPermission(position_id,17 );
			break;
		case 5:
			flag=permissionsDAO.checkPermission(position_id,21 );
			break;
		case 6:
			flag=project_procurement.getCreate_id()==user.getId();
			break;
		case 7:
			flag=permissionsDAO.checkPermission(position_id,21 )||permissionsDAO.checkPermission(position_id,22 );//分批采购，与收获同时进行
			break;
		case 8:
			flag=permissionsDAO.checkPermission(position_id,22 );
			break;
		case 9:
			flag=permissionsDAO.checkPermission(position_id,22 );
			break;
		case 10:
			flag=permissionsDAO.checkPermission(position_id,23 );
			break;
		case 12:
			flag=permissionsDAO.checkPermission(position_id,16 );
			break;
		case 13:
			flag=project_procurement.getCreate_id()==user.getId();	
			break;
		case 14:
			flag=permissionsDAO.checkPermission(position_id, 3);//提交项目采购需求单
			break;
		case 15:
			flag=project_procurement.getCreate_id()==user.getId();	
			break;
		case 16:
			flag=project_procurement.getCreate_id()==user.getId();	//本人是生产主管
			break;
		case 18:
			flag=permissionsDAO.checkPermission(position_id,DataUtil.getPurchaseMarketPIDArray(task.getType(), task.getProject_category()) ); //项目经理
			break;
		default:
			break;
		}
		return flag;
	}
	
	@Override
	public List<Project_procurement> getAllApplyedProjectList(int create_id) {
		// TODO Auto-generated method stub
		List<Project_procurement> list=project_procurementDAO.getAllApplyedProjectList(create_id);
		Iterator<Project_procurement> iterator=list.iterator();while (iterator.hasNext()) {
			Project_procurement project_procurement = (Project_procurement) iterator.next();
			Task task=taskDAO.getTask2ByID(project_procurement.getTask_id());
			if(task==null){
				iterator.remove();
				continue;
			}
			project_procurement.setName("项目采购单-"+task.getProject_name()+"-编号:"+project_procurement.getId());
		}
		return list;
	}
	
	//查询绑定的采购流程
	@Override
	public List<Project_procurement> getProject_procurementListByTaskID(int task_id) {
		// TODO Auto-generated method stub
		List<Project_procurement> prodject_procurementList=project_procurementDAO.getProject_procurementListByTaskID(task_id);//查询未完成的项目采购流程
//		List<Project_procurement> pList=new ArrayList<Project_procurement>();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		String flowTypeName=DataUtil.getFlowNameArray()[3]+"-";
		String[] flowArray3=DataUtil.getFlowArray(3);
		Iterator<Project_procurement> iterator=prodject_procurementList.iterator();
		while (iterator.hasNext()) {
			Project_procurement project_procurement = (Project_procurement) iterator.next();
			Flow flow=flowDAO.getNewFlowByFID(3, project_procurement.getId());//查询最新流程
			String process=sdf.format(flow.getCreate_time())+flowArray3[flow.getOperation()];
			project_procurement.setName(flowTypeName+taskDAO.getTask2ByID(project_procurement.getTask_id()).getProject_name());
			project_procurement.setProcess(process);
			project_procurement.setCreate_name(userDAO.getUserNameByID(project_procurement.getCreate_id()));
		}
		return prodject_procurementList;
	}
}
