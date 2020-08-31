package com.zzqa.service.impl.leave;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.leave.ILeaveDAO;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.position_user.IPosition_userDAO;
import com.zzqa.dao.interfaces.resumption.IResumptionDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.leave.Leave;
import com.zzqa.pojo.position_user.Position_user;
import com.zzqa.pojo.resumption.Resumption;
import com.zzqa.pojo.travel.Travel;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.leave.LeaveManager;
import com.zzqa.servlet.DelayEmailServlet;
import com.zzqa.util.DataUtil;
@Component("leaveManager")
public class LeaveManagerImpl implements LeaveManager {
	@Autowired
	private IUserDAO userDAO;
	@Autowired
	private ILeaveDAO leaveDAO;
	@Autowired
	private IFlowDAO flowDAO;
	@Autowired
	private IPosition_userDAO position_userDAO;
	@Autowired
	private IPermissionsDAO permissionsDAO;
	@Autowired
	private IResumptionDAO resumptionDAO;

	@Override
	public void insertLeave(Leave leave) {
		// TODO Auto-generated method stub
		leaveDAO.insertLeave(leave);
	}

	@Override
	public void updateLeave(Leave leave) {
		// TODO Auto-generated method stub
		leaveDAO.updateLeave(leave);
	}

	@Override
	public Leave getLeaveByID(int id) {
		// TODO Auto-generated method stub
		Leave leave=leaveDAO.getLeaveByID(id);
		leave.setCreate_name(userDAO.getUserNameByID(leave.getCreate_id()));
		leave.setAttendance_name(userDAO.getUserNameByID(leave.getAttendance_id()));
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		String startDate=sdf.format(leave.getStarttime());
		String halfday="0".equals(startDate.substring(11, 12))?"上午":"下午";
		leave.setStartDate(startDate.substring(0, 10)+" "+halfday);
		String endDate=sdf.format(leave.getEndtime());
		halfday="0".equals(endDate.substring(11, 12))?"上午":"下午";
		leave.setEndDate(endDate.substring(0, 10)+" "+halfday);
		leave.setDepartment_name(DataUtil.getdepartment()[leave.getDepartment()]);
		leave.setLeaveType_name(DataUtil.getLeaveType()[leave.getLeave_type()]);
		leave.setAlldays(DataUtil.subZeroAndDot(String.valueOf(DataUtil.getLeaveDays(leave.getStarttime(), leave.getEndtime(),leave.getLeave_type()))));
		return leave;
	}
	@Override
	public List<Leave> getAllLeaveList() {
		// TODO Auto-generated method stub
		return leaveDAO.getAllLeaveList();
	}

	@Override
	public List<Leave> getLeaveListByUID(User user) {
		// TODO Auto-generated method stub
		List<Leave> leaveList=leaveDAO.getRunningLeave();//查询所有未完成的请假流程
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		String[] flowArray8=DataUtil.getFlowArray(8);
//		Iterator<Leave> iterator=leaveList.iterator();
		List<Leave> list=new ArrayList<Leave>();
		int len=leaveList.size();
		for(int i=0;i<len;i++){
			Leave leave =leaveList.get(i);
			User userByID = userDAO.getUserByID(leave.getCreate_id());
			if(userByID==null || userByID.getPosition_id()==56){
				continue;
			}
			int op=leave.getOperation();
			long update_time=leave.getUpdate_time();
			//Flow flow=flowDAO.getNewFlowByFID(8, leave.getId());//查询最新流程
			if(op!=0&&checkMyOperation(op,user,leave)){
				String process=sdf.format(update_time)+flowArray8[op];
				if(op==2){
					process+=getApprovalNum(leave)>1?",等待分管审批":",等待考勤备案";
				}else if(op==4){
					process+=getApprovalNum(leave)>2?",等待总经理审批":",等待考勤备案";
				}
				leave.setProcess(process);
				leave.setName(DataUtil.getNameByTime(8,leave.getCreate_time()));
				list.add(leave);
			}
		}
		return list;
	}
	public long lastFlowTime(int operation,List<Flow> flowList){
		int len=flowList.size();
		for (int i = 0; i < len; i++) {
			if(flowList.get(len-i-1).getOperation()==operation){
				return flowList.get(len-i-1).getCreate_time();
			}
		}
		if(operation==7){
			//老版本中存在三级领导的总经理审批时间默认为上以流程时间（分管领导审批时间）
			return lastFlowTime(4,flowList);
		}
		return 0;//没有就返回0
	}
	@Override
	public Map<String, String> getLeaveFlowForDraw(Leave leave,Flow flow) {
		// TODO Auto-generated method stub
		int operation=flow.getOperation();
		Map<String, String> map=new HashMap<String, String>();
		List<Flow> flowList=flowDAO.getFlowListByCondition(8,leave.getId());
		SimpleDateFormat dft=new SimpleDateFormat("yyyy-MM-dd*HH:mm:ss");
		String class1_1="";
		String style11="";
		String style12="";
		String style13="";
		String style14="";
		String style15="";
		String style16="";
		String class1_2="";
		String img1="";
		String img2="";
		String img3="";
		String img4="";
		String img5="";
		String img6="";
		String style21="";
		String style22="";
		String style23="";
		String style24="";
		String style25="";
		String class1_3="";
		String time1="";
		String time2="";
		String time3="";
		String time4="";
		String time5="";
		String time6="";
		int num=getApprovalNum(leave);
		if(operation==1){
			if(num==1){
				//1次审批
				class1_1="td2_div1_1_4";
				style11="style='color:#42c652;'";//pass
				style12="style='color:#5C5C5C'";//nodid
				style15="style='color:#5C5C5C'";//nodid
				style16="style='color:#5C5C5C'";//nodid
				class1_2="td2_div1_2_4";
				 img1="images/pass.png";
				 img2="images/go.png";
				 img3="images/notdid.png";
				 img4="images/notdid.png";
				style21="style='background-color:#42C752;'";//agree
				style22="style='background-color:#E1EAEF;'";//nodid
				style23="style='background-color:#E1EAEF;'";//nodid
				class1_3="td2_div1_3_4";
				time1=dft.format(leave.getCreate_time()).replace("*", "<br/>");
			}else if(num==2){
				//两次审批
				class1_1="td2_div1_1";
				style11="style='color:#42c652;'";//pass
				style12="style='color:#5C5C5C'";//nodid
				style13="style='color:#5C5C5C'";//nodid
				style15="style='color:#5C5C5C'";//nodid
				style16="style='color:#5C5C5C'";//nodid
				class1_2="td2_div1_2";
				 img1="images/pass.png";
				 img2="images/go.png";
				 img3="images/notdid.png";
				 img4="images/notdid.png";
				 img5="images/notdid.png";
				style21="style='background-color:#42C752;'";//agree
				style22="style='background-color:#E1EAEF;'";//nodid
				style23="style='background-color:#E1EAEF;'";//nodid
				style24="style='background-color:#E1EAEF;'";//nodid
				class1_3="td2_div1_3";
				time1=dft.format(leave.getCreate_time()).replace("*", "<br/>");
			}else{
				class1_1="td2_div1_1_6";
				style11="style='color:#42c652;'";//pass
				style12="style='color:#5C5C5C'";//nodid
				style13="style='color:#5C5C5C'";//nodid
				style14="style='color:#5C5C5C'";//nodid
				style15="style='color:#5C5C5C'";//nodid
				style16="style='color:#5C5C5C'";//nodid
				class1_2="td2_div1_2_6";
				img1="images/pass.png";
				img2="images/go.png";
				img3="images/notdid.png";
				img4="images/notdid.png";
				img5="images/notdid.png";
				img6="images/notdid.png";
				style21="style='background-color:#42C752;'";//agree
				style22="style='background-color:#E1EAEF;'";//nodid
				style23="style='background-color:#E1EAEF;'";//nodid
				style24="style='background-color:#E1EAEF;'";//nodid
				style25="style='background-color:#E1EAEF;'";//nodid
				class1_3="td2_div1_3_6";
				time1=dft.format(leave.getCreate_time()).replace("*", "<br/>");
			}
		}else if(operation==2){
			if(num==1){
				//1次审批
				class1_1="td2_div1_1_4";
				style11="style='color:#42c652;'";//pass
				style12="style='color:#42c652'";//pass
				style15="style='color:#5C5C5C'";//nodid
				style16="style='color:#5C5C5C'";//nodid
				class1_2="td2_div1_2_4";
				 img1="images/pass.png";
				 img2="images/pass.png";
				 img3="images/go.png";
				 img4="images/notdid.png";
				style21="style='background-color:#42C752;'";//agree
				style22="style='background-color:#42C752;'";//agree
				style23="style='background-color:#E1EAEF;'";//nodid
				class1_3="td2_div1_3_4";
				time1=dft.format(leave.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			}else if(num==2){
				//两次审批
				class1_1="td2_div1_1";
				style11="style='color:#42c652;'";//pass
				style12="style='color:#42c652'";//pass
				style13="style='color:#5C5C5C'";//nodid
				style15="style='color:#5C5C5C'";//nodid
				style16="style='color:#5C5C5C'";//nodid
				class1_2="td2_div1_2";
				 img1="images/pass.png";
				 img2="images/pass.png";
				 img3="images/go.png";
				 img4="images/notdid.png";
				 img5="images/notdid.png";
				style21="style='background-color:#42C752;'";//agree
				style22="style='background-color:#42C752;'";//agree
				style23="style='background-color:#E1EAEF;'";//nodid
				style24="style='background-color:#E1EAEF;'";//nodid
				class1_3="td2_div1_3";
				time1=dft.format(leave.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			}else{
				//三次审批
				class1_1="td2_div1_1_6";
				style11="style='color:#42c652;'";//pass
				style12="style='color:#42c652'";//pass
				style13="style='color:#5C5C5C'";//nodid
				style14="style='color:#5C5C5C'";//nodid
				style15="style='color:#5C5C5C'";//nodid
				style16="style='color:#5C5C5C'";//nodid
				class1_2="td2_div1_2_6";
				img1="images/pass.png";
				img2="images/pass.png";
				img3="images/go.png";
				img4="images/notdid.png";
				img5="images/notdid.png";
				img6="images/notdid.png";
				style21="style='background-color:#42C752;'";//agree
				style22="style='background-color:#42C752;'";//agree
				style23="style='background-color:#E1EAEF;'";//nodid
				style24="style='background-color:#E1EAEF;'";//nodid
				style25="style='background-color:#E1EAEF;'";//nodid
				class1_3="td2_div1_3_6";
				time1=dft.format(leave.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			}
		}else if(operation==3){
			class1_1="td2_div1_1_3";
			style11="style='color:#42c652;'";//pass
			style12="style='color:#FF4401'";//nopass
			style16="style='color:#5C5C5C'";//nodid
			class1_2="td2_div1_2_3";
			img1="images/pass.png";
			img2="images/error.png";
			img3="images/notdid.png";
			style21="style='background-color:#FF4401;'";//disagree
			style22="style='background-color:#E1EAEF;'";//nodid
			class1_3="td2_div1_3_3";
			time1=dft.format(leave.getCreate_time()).replace("*", "<br/>");
			time2=dft.format(lastFlowTime(3, flowList)).replace("*", "<br/>");
		}else if(operation==4){
			//两次审批通过
			if(num==2){
				class1_1="td2_div1_1";
				style11="style='color:#42c652;'";//pass
				style12="style='color:#42c652'";//pass
				style13="style='color:#42c652'";//pass
				style15="style='color:#5C5C5C'";//nodid
				style16="style='color:#5C5C5C'";//nodid
				class1_2="td2_div1_2";
				 img1="images/pass.png";
				 img2="images/pass.png";
				 img3="images/pass.png";
				 img4="images/go.png";
				 img5="images/notdid.png";
				style21="style='background-color:#42C752;'";//agree
				style22="style='background-color:#42C752;'";//agree
				style23="style='background-color:#42C752;'";//agree
				style24="style='background-color:#E1EAEF;'";//nodid
				class1_3="td2_div1_3";
				time1=dft.format(leave.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
			}else{
				//三次审批
				class1_1="td2_div1_1_6";
				style11="style='color:#42c652;'";//pass
				style12="style='color:#42c652'";//pass
				style13="style='color:#42c652'";//pass
				style14="style='color:#5C5C5C'";//nodid
				style15="style='color:#5C5C5C'";//nodid
				style16="style='color:#5C5C5C'";//nodid
				class1_2="td2_div1_2_6";
				 img1="images/pass.png";
				 img2="images/pass.png";
				 img3="images/pass.png";
				 img4="images/go.png";
				 img5="images/notdid.png";
				 img6="images/notdid.png";
				style21="style='background-color:#42C752;'";//agree
				style22="style='background-color:#42C752;'";//agree
				style23="style='background-color:#42C752;'";//agree
				style24="style='background-color:#E1EAEF;'";//nodid
				style25="style='background-color:#E1EAEF;'";//nodid
				class1_3="td2_div1_3_6";
				time1=dft.format(leave.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
			}
		}else if(operation==5){
			//第二次审批未通过
			class1_1="td2_div1_1_no4";
			style11="style='color:#42c652;'";//pass
			style12="style='color:#42c652'";//pass
			style13="style='color:#FF4401'";//nopass
			style16="style='color:#5C5C5C'";//nodid
			class1_2="td2_div1_2_4";
			 img1="images/pass.png";
			 img2="images/pass.png";
			 img3="images/error.png";
			 img4="images/notdid.png";
			style21="style='background-color:#42C752;'";//agree
			style22="style='background-color:#FF4401;'";//disagree
			style23="style='background-color:#E1EAEF;'";//nodid
			class1_3="td2_div1_3_4";
			time1=dft.format(leave.getCreate_time()).replace("*", "<br/>");
			time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			time3=dft.format(lastFlowTime(5, flowList)).replace("*", "<br/>");
		}else if(operation==6){
			if(num==1){
				//1次审批
				class1_1="td2_div1_1_4";
				style11="style='color:#42c652;'";//pass
				style12="style='color:#42c652'";//pass
				style15="style='color:#42c652'";//pass
				style16="style='color:#42c652'";//pass
				class1_2="td2_div1_2_4";
				 img1="images/pass.png";
				 img2="images/pass.png";
				 img3="images/pass.png";
				 img4="images/pass.png";
				style21="style='background-color:#42C752;'";//agree
				style22="style='background-color:#42C752;'";//agree
				style23="style='background-color:#42C752;'";//agree
				class1_3="td2_div1_3_4";
				time1=dft.format(leave.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(6, flowList)).replace("*", "<br/>");
				time4=time3;
			}else if(num==2){
				//两次审批
				class1_1="td2_div1_1";
				style11="style='color:#42c652;'";//pass
				style12="style='color:#42c652'";//pass
				style13="style='color:#42c652'";//pass
				style15="style='color:#42c652'";//pass
				style16="style='color:#42c652'";//pass
				class1_2="td2_div1_2";
				 img1="images/pass.png";
				 img2="images/pass.png";
				 img3="images/pass.png";
				 img4="images/pass.png";
				 img5="images/pass.png";
				style21="style='background-color:#42C752;'";//agree
				style22="style='background-color:#42C752;'";//agree
				style23="style='background-color:#42C752;'";//agree
				style24="style='background-color:#42C752;'";//agree
				class1_3="td2_div1_3";
				time1=dft.format(leave.getCreate_time()).replace("*", "<br/>");
				time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
				time3=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
				time4=dft.format(lastFlowTime(6, flowList)).replace("*", "<br/>");
				time5=time4;
			}else{
					class1_1="td2_div1_1_6";
					style11="style='color:#42c652;'";//pass
					style12="style='color:#42c652'";//pass
					style13="style='color:#42c652'";//pass
					style14="style='color:#42c652'";//pass
					style15="style='color:#42c652'";//pass
					style16="style='color:#42c652'";//pass
					class1_2="td2_div1_2_6";
					img1="images/pass.png";
					img2="images/pass.png";
					img3="images/pass.png";
					img4="images/pass.png";
					img5="images/pass.png";
					img6="images/pass.png";
					style21="style='background-color:#42C752;'";//agree
					style22="style='background-color:#42C752;'";//agree
					style23="style='background-color:#42C752;'";//agree
					style24="style='background-color:#42C752;'";//agree
					style25="style='background-color:#42C752;'";//agree
					class1_3="td2_div1_3_6";
					time1=dft.format(leave.getCreate_time()).replace("*", "<br/>");
					time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
					time3=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
					time4=dft.format(lastFlowTime(7, flowList)).replace("*", "<br/>");
					time5=dft.format(lastFlowTime(6, flowList)).replace("*", "<br/>");
					time6=time5;
			}
		}else if(operation==7){
			class1_1="td2_div1_1_6";
			style11="style='color:#42c652;'";//pass
			style12="style='color:#42c652'";//nopass
			style13="style='color:#42c652'";//nodid
			style14="style='color:#42c652'";//nodid
			style15="style='color:#5C5C5C'";//nodid
			style16="style='color:#5C5C5C'";//nodid
			class1_2="td2_div1_2_6";
			img1="images/pass.png";
			img2="images/pass.png";
			img3="images/pass.png";
			img4="images/pass.png";
			img5="images/go.png";
			img6="images/notdid.png";
			style21="style='background-color:#42C752;'";//agree
			style22="style='background-color:#42C752;'";//agree
			style23="style='background-color:#42C752;'";//agree
			style24="style='background-color:#42C752;'";//agree
			style25="style='background-color:#E1EAEF;'";//nodid
			class1_3="td2_div1_3_6";
			time1=dft.format(leave.getCreate_time()).replace("*", "<br/>");
			time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			time3=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
			time4=dft.format(lastFlowTime(7, flowList)).replace("*", "<br/>");
		}else if(operation==8){
			//第三次审批失败
			class1_1="td2_div1_1_5no";
			style11="style='color:#42c652;'";//pass
			style12="style='color:#42c652'";//pass
			style13="style='color:#42c652'";//pass
			style14="style='color:#FF4401'";//nopass
			style16="style='color:#5C5C5C'";//nodid
			class1_2="td2_div1_2";
			img1="images/pass.png";
			img2="images/pass.png";
			img3="images/pass.png";
			img4="images/error.png";
			img5="images/notdid.png";
			style21="style='background-color:#42C752;'";//agree
			style22="style='background-color:#42C752;'";//agree
			style23="style='background-color:#FF4401;'";//disagree
			style24="style='background-color:#E1EAEF;'";//nodid
			class1_3="td2_div1_3";
			time1=dft.format(leave.getCreate_time()).replace("*", "<br/>");
			time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			time3=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
			time4=dft.format(lastFlowTime(8, flowList)).replace("*", "<br/>");
		}else if(operation==9){
			//撤销
			class1_1="td2_div1_1_del";
			style11="style='color:#42c652;'";//pass
			style16="style='color:#FF4401'";//nopass
			class1_2="td2_div1_2_del";
			img1="images/pass.png";
			img6="images/error.png";
			style25="style='background-color:#FF4401;'";//disagree
			class1_3="td2_div1_3_del";
			time1=dft.format(leave.getCreate_time()).replace("*", "<br/>");
			time6=dft.format(lastFlowTime(9, flowList)).replace("*", "<br/>");
		}
		map.put("class1_1", class1_1);
		map.put("class1_2", class1_2);
		map.put("class1_3", class1_3);
		
		map.put("style11", style11);
		map.put("style12", style12);
		map.put("style13", style13);
		map.put("style14", style14);
		map.put("style15", style15);
		map.put("style16", style16);
		
		map.put("img1", img1);
		map.put("img2", img2);
		map.put("img3", img3);
		map.put("img4", img4);
		map.put("img5", img5);
		map.put("img6", img6);
		
		map.put("style21", style21);
		map.put("style22", style22);
		map.put("style23", style23);
		map.put("style24", style24);
		map.put("style25", style25);
		
		map.put("time1", time1);
		map.put("time2", time2);
		map.put("time3", time3);
		map.put("time4", time4);
		map.put("time5", time5);
		map.put("time6", time6);
		return map;
	}
	/****
	 * 检查请假单审核次数
	 * @param operation
	 * @param leave
	 * @return 审核次数
	 */
	private int getApprovalNum(Leave leave){
		int flag=1;
		User user1=userDAO.getUserByID(leave.getCreate_id());
		if(user1==null){
			return flag;
		}
		float alldays=DataUtil.getLeaveDays(leave.getStarttime(), leave.getEndtime(),leave.getLeave_type());
			/****
			 * 1.只有一级领导,审批后直接考勤备案
			 * 2.有两级领导的，1.1：两级领导为总经理,一级领导天数限制为3天;
			 * 							   1.2：总经理非两级领导时，一级领导天数限制为1天
			 */
			if(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()==0){
				//总经理自己不需要备案
			}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()==0){
				//总经理为上级领导的,一次审批后考勤备案
			}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()).getParent()==0){
				//领导的领导为总经理
				if(alldays>3){
					//一级领导审批3天内 下一步考勤备份
					flag=2;
				}
			}else{
				//存在两级以上领导
				if(alldays>7){
					flag=3;
				}else if(alldays>1){
					//一级领导审批3天内 下一步考勤备份
					flag=2;
				}
			}
		return flag;
	}
	private boolean checkMyOperation(int operation,User user,Leave leave){
		boolean flag=false;
		User user1=userDAO.getUserByID(leave.getCreate_id());
		if(user1==null){
			return flag;
		}
		leave.setCreate_name(DataUtil.getUserNameByUser(user1));
		int position_id=user.getPosition_id();
		if(position_id==0){
			return flag;
		}
		Position_user position_user=position_userDAO.getPositionByID(user1.getPosition_id());
		if(position_user==null){
			return flag;
		}
		double alldays;
		try {
			switch (operation) {
			case 1:
				//请假先由上级领导审批
				flag=position_id==position_userDAO.getPositionByID(user1.getPosition_id()).getParent();
				break;
			case 2:
				alldays=DataUtil.getLeaveDays(leave.getStarttime(), leave.getEndtime(),leave.getLeave_type());
				/****
				 * 1.只有一级领导,审批后直接考勤备案
				 * 2.有两级领导的，1.1：两级领导为总经理,一级领导天数限制为3天;
				 * 							   1.2：总经理非两级领导时，一级领导天数限制为1天，两级领导天数限制为7天
				 */
				if(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()==0){
					//总经理自己不需要审批
				}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()==0){
					//总经理为上级领导的,一次审批后考勤备案
					flag=permissionsDAO.checkPermission(position_id, 30);
					if(flag){
						leave.setCanBack(true);
					}
				}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()).getParent()==0){
					//领导的领导为总经理
					if(alldays>3){
						//一级领导天数限制为3天
						flag=position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()==user.getPosition_id();
					}else{
						//考勤备案
						flag=permissionsDAO.checkPermission(position_id, 30);
						if(flag){
							leave.setCanBack(true);
						}
					}
				}else{
					//存在两级以上领导
					if(alldays>1){
						//一级领导天数限制为1天
						flag=position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()==user.getPosition_id();
					}else{
						//考勤备案
						flag=permissionsDAO.checkPermission(position_id, 30);
						if(flag){
							leave.setCanBack(true);
						}
					}
				}
				break;
			case 4:
				alldays=DataUtil.getLeaveDays(leave.getStarttime(), leave.getEndtime(),leave.getLeave_type());
				/****
				 * 1.只有一级领导,审批后直接考勤备案
				 * 2.有两级领导的，1.1：两级领导为总经理,一级领导天数限制为3天;
				 * 							   1.2：总经理非两级领导时，一级领导天数限制为1天，两级领导天数限制为7天
				 */
				if(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()==0){

				}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()==0){
					//领导是在总经理
					flag=permissionsDAO.checkPermission(position_id, 30);
					if(flag){
						leave.setCanBack(true);
					}
				}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()).getParent()==0){
					flag=permissionsDAO.checkPermission(position_id, 30);
					if(flag){
						leave.setCanBack(true);
					}
				}else{
					//存在两级以上领导
					flag=(alldays>7&&position_userDAO.getPositionByID(user.getPosition_id()).getParent()==0)||(alldays<=7&&permissionsDAO.checkPermission(position_id, 30));
					if(flag){
						leave.setCanBack(true);
					}
				}
				break;
			case 7:
				//考勤备案
				flag=permissionsDAO.checkPermission(position_id, 30);
				if(flag){
					leave.setCanBack(true);
				}
				break;
			default:
				break;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return flag;
		}
		
		return flag;
		
	}
	//检查是否可以审批
	public boolean checkLeaveCan(int operation,Leave leave,User user){
		boolean flag=false;
		User user1=userDAO.getUserByID(leave.getCreate_id());
		if(user1==null){
			return false;//用户不存在无法审批
		}
		int position_id=user.getPosition_id();
		if(position_id==0){
			return flag;
		}
		switch (operation) {
		case 1:
			//请假先由上级领导审批
			flag=position_id==position_userDAO.getPositionByID(user1.getPosition_id()).getParent();
			break;
		case 2:
			/****
			 * 1.只有一级领导,审批后直接考勤备案
			 * 2.有两级领导的，1.1：两级领导为总经理,一级领导天数限制为3天;
			 * 							   1.2：总经理非两级领导时，一级领导天数限制为1天，二级领导7天
			 */
			if(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()==0){
				//总经理自己不需要审批
			}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()==0){
				//总经理为上级领导的,一次审批后考勤备案
			}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()).getParent()==0){
				//领导的领导为总经理,一级领导天数限制为3天
				flag=Float.parseFloat(leave.getAlldays())>3&&position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()==user.getPosition_id();
			}else{
				//存在两级以上领导,一级领导天数限制为1天
				flag=Float.parseFloat(leave.getAlldays())>1&&position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()==user.getPosition_id();
			}
			break;
		case 4:
			//已经审批了2次
			if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()).getParent()!=0){
				//有三级领导且超过7天的还需总经理审批
				flag=Float.parseFloat(leave.getAlldays())>7&&position_userDAO.getPositionByID(user.getPosition_id()).getParent()==0;
			}
			break;
		default:
			break;
		}
		return flag;
	}
	
	//检查是否可以备案
	public boolean checkLeaveBackUp(int operation,Leave leave,User user){
		boolean flag=false;
		User user1=userDAO.getUserByID(leave.getCreate_id());
		if(user1==null){
			return false;//用户不存在，无法备案;
		}
		int position_id=user.getPosition_id();
		if(position_id==0){
			return flag;
		}
		float alldays=DataUtil.getLeaveDays(leave.getStarttime(), leave.getEndtime(),leave.getLeave_type());
		try {
			switch (operation) {
			case 2:
				/****
				 * 1.只有一级领导,审批后直接考勤备案
				 * 2.有两级领导的，1.1：两级领导为总经理,一级领导天数限制为3天;
				 * 							   1.2：总经理非两级领导时，一级领导天数限制为1天
				 */
				if(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()==0){
					//总经理自己不需要备案
				}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()==0){
					//总经理为上级领导的,一次审批后考勤备案
					flag=permissionsDAO.checkPermission(position_id, 30);
				}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()).getParent()==0){
					//领导的领导为总经理，一级领导审批上限3天，不超过3天的下一步考勤备份
					flag=alldays<=3&&permissionsDAO.checkPermission(position_id, 30);
				}else{
					//存在两级以上领导
					if(alldays<=1){
						//一级领导天数限制为1天
						flag=permissionsDAO.checkPermission(position_id, 30);
					}
				}
				break;
			case 4:
				if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()).getParent()==0){
					//领导领导为总经理的，下一步必为备案
					flag=permissionsDAO.checkPermission(position_id, 30);
				}else{
					///存在两级以上领导，7天及以内的只需2次审批
					flag=alldays<=7&&permissionsDAO.checkPermission(position_id, 30);
				}
				break;
			case 7:
				flag=permissionsDAO.checkPermission(position_id, 30);
				break;
			default:
				break;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return flag;
		}
		
		return flag;
	}

	@Override
	public Leave getLeaveByID2(int id) {
		// TODO Auto-generated method stub、
		Leave leave=leaveDAO.getLeaveByID(id);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		Flow flow=flowDAO.getNewFlowByFID(8, id);//查询最新流程
		String process=sdf.format(flow.getCreate_time())+DataUtil.getFlowArray(8)[flow.getOperation()];
		int op=flow.getOperation();
		if(op==2){
			process+=getApprovalNum(leave)>1?",等待分管审批":",等待考勤备案";
		}else if(op==4){
			process+=getApprovalNum(leave)>2?",等待总经理审批":",等待考勤备案";
		}
		leave.setProcess(process);
		leave.setName(DataUtil.getNameByTime(8, leave.getCreate_time()));
		leave.setCreate_name(userDAO.getUserNameByID(leave.getCreate_id()));
		return leave;
	}
	@Override
	public List<Leave> getLeaveListAfterApproval(int uid) {
		// TODO Auto-generated method stub
		List<Leave> leaveList=leaveDAO.getLeaveListAfterApproval(uid);
		Iterator<Leave> iterator=leaveList.iterator();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
		while (iterator.hasNext()) {
			Leave leave = (Leave) iterator.next();
			Flow flow=flowDAO.getNewFlowByFID(8, leave.getId());
			//没有全部审批完的滤掉
			if(flow==null||(flow.getOperation()==2&&getApprovalNum(leave)>1)||(flow.getOperation()==4&&getApprovalNum(leave)>2)){
				iterator.remove();
				continue;
			}else{
				String startDate=sdf.format(leave.getStarttime());
				startDate=startDate.substring(0, 11)+("0".equals(startDate.substring(12,13))?"上午":"下午");
				String endDate=sdf.format(leave.getEndtime());
				endDate=endDate.substring(0, 11)+("0".equals(endDate.substring(12,13))?"上午":"下午");
				leave.setName(new StringBuilder().append("请假单-").append(startDate).append("至").append(endDate).toString());
			}
		}
		return leaveList;
	}

	@Override
	public List<Leave> getLeaveListReport(int year, int month) {
		// TODO Auto-generated method stub
		SimpleDateFormat sdf1=new SimpleDateFormat("yyyy.MM.dd HH");
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		List<Leave> leaveList=new ArrayList<Leave>();
		Map map=new HashMap();
		try {
			long starttime=sdf.parse(year+"."+month+"."+"01").getTime();
			long endtime=sdf.parse(year+"."+(month+1)+"."+"01").getTime();
			map.put("starttime",starttime );
			map.put("endtime", endtime);
			leaveList=leaveDAO.getLeaveListReport(map);
			Iterator<Leave> iterator=leaveList.iterator();
			String[] departmentArray=DataUtil.getdepartment();
			String[] leaveTypeArray=DataUtil.getLeaveType();
			while (iterator.hasNext()) {
				Leave leave = (Leave) iterator.next();
				if(leave.getCreate_name()==null){
					leave.setCreate_name(userDAO.getUserNameByID(leave.getCreate_id()));
				}
				leave.setAttendance_name(userDAO.getUserNameByID(leave.getAttendance_id()));
				Resumption resumption=resumptionDAO.getFinishedResumption(2, leave.getId());
				//判断是否有销假
				if(resumption!=null){
					if(resumption.getReback_time()<=starttime||resumption.getReback_time()==leave.getStarttime()){
						//当月已被销假的,或销假到0天的在当月报表中不显示
						iterator.remove();
						continue;
					}
					if(resumption.getStarttime()>0){
						//新版本可以改起始时间
						leave.setStarttime(resumption.getStarttime());
					}
					leave.setEndtime(resumption.getReback_time()-43200000l);//返回时间比时间请假结束时间晚半天
					//判断是否为跨月
					if(leave.getStarttime()>=starttime){
						leave.setStartDate(getDate(sdf1,leave.getStarttime()));
					}else{
						leave.setStarttime(starttime);
						leave.setStartDate(getDate(sdf1,starttime)+"<br/>(跨月)");
					}
					//判断是否为跨月
					if(leave.getEndtime()>=endtime){
						leave.setEndDate(getDate(sdf1, endtime-43200000)+"<br/>(销假)(跨月)");
						leave.setAlldays(DataUtil.subZeroAndDot(String.valueOf(DataUtil.getLeaveDays(leave.getStarttime(), endtime-43200000,leave.getLeave_type()))));
					}else{
						leave.setEndDate(getDate(sdf1, leave.getEndtime())+"<br/>(销假)");
						leave.setAlldays(DataUtil.subZeroAndDot(String.valueOf(DataUtil.getLeaveDays(leave.getStarttime(), resumption.getReback_time()-43200000,leave.getLeave_type()))));
					}
				}else{
					//判断是否为跨月
					if(leave.getStarttime()>=starttime){
						//leave.setStarttime(leave.getStarttime());
						leave.setStartDate(getDate(sdf1,leave.getStarttime()));
					}else{
						leave.setStarttime(starttime);
						leave.setStartDate(getDate(sdf1,starttime)+"<br/>(跨月)");
					}
					//判断是否为跨月
					if(leave.getEndtime()>=endtime){
						leave.setEndDate(getDate(sdf1, endtime-43200000)+"<br/>(跨月)");
						leave.setAlldays(DataUtil.subZeroAndDot(String.valueOf(DataUtil.getLeaveDays(leave.getStarttime(), endtime-43200000,leave.getLeave_type()))));
					}else{
						leave.setEndDate(getDate(sdf1,leave.getEndtime()));
						leave.setAlldays(DataUtil.subZeroAndDot(String.valueOf(DataUtil.getLeaveDays(leave.getStarttime(), leave.getEndtime(),leave.getLeave_type()))));
					}
				}
				if(Float.parseFloat(leave.getAlldays())<0.5){
					iterator.remove();
					continue;
				}
				leave.setDepartment_name(departmentArray[leave.getDepartment()]);
				leave.setLeaveType_name(leaveTypeArray[leave.getLeave_type()]);
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return leaveList;
		}
		return leaveList;
	}
	private String getDate(SimpleDateFormat sdf,long time){
		String date=sdf.format(time);
		return date.substring(0, 10)+("0".equals(date.substring(12,13))?"上午":"下午");
	}
	
	@Override
	public boolean checkLeaveInScope(long starttime, long endtime,
			int create_id) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String, Object>();//endtime = 1491580800000
		map.put("starttime", starttime);
		map.put("endtime", endtime);
		map.put("create_id", create_id);
		List<Leave> leaveList=leaveDAO.checkLeaveInScope(map);
		for (Leave leave : leaveList) {
			Resumption resumption=resumptionDAO.getFinishedResumption(2, leave.getId());
			if(resumption==null){
				return true;//直接返回true，未被成功销假，时间重复
			}
			long st=resumption.getStarttime();
			long et=resumption.getReback_time()-43200000;//销假后的请假结束时间
			if(endtime>=st&&et>=starttime){
				return true;
			}
		}
		return false;
	}
}
