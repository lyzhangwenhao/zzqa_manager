package com.zzqa.service.impl.seal;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.seal.ISealDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.aftersales_task.Aftersales_task;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.seal.Seal;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.seal.SealManager;
import com.zzqa.util.DataUtil;
@Component("sealManager")
public class SealManagerImpl implements SealManager {
	@Autowired
	private ISealDAO sealDAO;
	@Autowired
	private IUserDAO userDAO;
	@Autowired
	private IFlowDAO flowDAO;
	@Autowired
	private IPermissionsDAO permissionsDAO;
	

	@Override
	public int insertSeal(Seal seal) {
		// TODO Auto-generated method stub
		sealDAO.insertSeal(seal);
		return sealDAO.getNewSealIDByCreateID(seal.getCreate_id());
	}

	@Override
	public void updateSeal(Seal seal) {
		// TODO Auto-generated method stub
		sealDAO.updateSeal(seal);
	}

	@Override
	public Seal getSealByID(int id) {
		// TODO Auto-generated method stub
		Seal seal=sealDAO.getSealByID(id);
		seal.setCreate_name(userDAO.getUserNameByID(seal.getCreate_id()));
		seal.setApprove_name(userDAO.getUserNameByID(seal.getApprover()));
		seal.setExecutor_name(userDAO.getUserNameByID(seal.getExecutor()));
		return seal;
	}

	@Override
	public Seal getSealByID2(int id) {
		// TODO Auto-generated method stub
		Seal seal=sealDAO.getSealByID(id);
		if(seal!=null){
			SimpleDateFormat format = new SimpleDateFormat( "yyyy.MM.dd" );
			Flow flow=flowDAO.getNewFlowByFID(14, seal.getId());
			String process=format.format(flow.getCreate_time())+DataUtil.getFlowArray(14)[flow.getOperation()];
			seal.setName(DataUtil.getNameByTime(14,seal.getCreate_time()));
			seal.setProcess(process);
			seal.setCreate_name(userDAO.getUserNameByID(seal.getCreate_id()));
		}
		return seal;
	}

	@Override
	public List<Seal> getSealByUID(User user) {
		// TODO Auto-generated method stub
		List<Seal> sealList=sealDAO.getRunningSeal();
		SimpleDateFormat format = new SimpleDateFormat( "yyyy.MM.dd" );
		String[] flowArray=DataUtil.getFlowArray(14);
		if(sealList!=null){
			Iterator<Seal> iterator=sealList.iterator();
			while (iterator.hasNext()) {
				Seal seal=(Seal)iterator.next();
				User userByID = userDAO.getUserByID(seal.getCreate_id());
				if(userByID==null || userByID.getPosition_id()==56){
					iterator.remove();
					continue;
				}
				Flow flow=flowDAO.getNewFlowByFID(14, seal.getId());//查询最新流程
				if(flow!=null&&checkMyOperation(flow.getOperation(),user,seal)){
					String process=format.format(flow.getCreate_time())+flowArray[flow.getOperation()];
					seal.setProcess(process);
					seal.setName(DataUtil.getNameBySealUserAndTime(seal.getReason(),14,seal.getCreate_time()));
					seal.setCreate_name(userByID.getTruename());
				}else{
					iterator.remove();
				}
			}
		}
		return sealList;
	}
	public boolean canApproveSeal(User user,Seal seal){
		int permissionID=DataUtil.getSealApprovePermissionID(seal.getApply_department(), seal.getType());
		if(permissionID==0){
			User user2=userDAO.getTopUser();
			if(user2!=null){
				return user.getId()==user2.getId();
			}
		}else{
			return permissionsDAO.checkPermission(user.getPosition_id(), permissionID);
		}
		return false;
	}
	private boolean checkMyOperation(int operation,User user,Seal seal){
		boolean flag=false;
		int seal_type = seal.getType();
		int apply_d = seal.getApply_department();
		boolean flags=(apply_d>8 && apply_d<16 && apply_d!=14 && (seal_type==0 || seal_type==1));
 		switch (operation) {
		case 1:
			flag=canApproveSeal(user,seal);
			break;
		case 2:
			if(flags){
				flag=permissionsDAO.checkPermission(user.getPosition_id(),9);
			}else {
				flag=permissionsDAO.checkPermission(user.getPosition_id(),DataUtil.getSealManagerPermission(seal_type));
			}
			break;
		case 3:
			flag=user.getId()==seal.getCreate_id();
			break;
		case 6:
			flag=permissionsDAO.checkPermission(user.getPosition_id(),DataUtil.getSealManagerPermission(seal_type));
			break;
		case 7:
			flag=user.getId()==seal.getCreate_id();
			break;
		default:
			break;
		}
		return flag;
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
	public Map<String, String> getSealFlowForDraw(Seal seal, Flow flow) {
		// TODO Auto-generated method stub
		int operation=flow.getOperation();
		int type = seal.getType();
		int apply_d = seal.getApply_department();
		boolean flag=(apply_d>8 && apply_d<16 && apply_d!=14 && (type==0 || type==1));
		Map<String, String> map=new HashMap<String, String>();
		List<Flow> flowList=flowDAO.getFlowListByCondition(14,seal.getId());
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd#HH:mm:ss");
		String title1_flow="title1_flow1";
		String title2_flow="title2_flow1";
		String title3_flow="title3_flow1";
		String color1=null;
		String color2=null;
		String color3=null;
		String color4=null;
		String color5=null;
		String img1=null;
		String img2=null;
		String img3=null;
		String img4=null;
		String img5=null;
		String time1=null;
		String time2=null;
		String time3=null;
		String time4=null;
		String time5=null;
		String bg_color1=null;
		String bg_color2=null;
		String bg_color3=null;
		String bg_color4=null;
		if(operation==1){//提交用印单 用印部门经理审批
			if(flag){
				color5="color_nodid";
				img5="notdid.png";
				bg_color4="background_color_nodid";
			}
			color1="color_did";
			color2="color_nodid";
			color3="color_nodid";
			color4="color_nodid";
			img1="pass.png";
			img2="go.png";
			img3="notdid.png";
			img4="notdid.png";
			bg_color1="background_color_did";
			bg_color2="background_color_nodid";
			bg_color3="background_color_nodid";
			time1=sdf.format(seal.getCreate_time()).replace("#", "<br/>");
		}else if(operation==2){//1、印章管理人执行 。2、用印审批通过 总经理审批
			if(flag){
				color5="color_nodid";
				img5="notdid.png";
				bg_color4="background_color_nodid";
			}
			color1="color_did";
			color2="color_did";
			color3="color_nodid";
			color4="color_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="go.png";
			img4="notdid.png";
			bg_color1="background_color_did";
			bg_color2="background_color_did";
			bg_color3="background_color_nodid";
			time1=sdf.format(seal.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==3){//用印审批不通过
			if(flag){
				color5="color_nodid";
				img5="notdid.png";
				bg_color4="background_color_nodid";
			}
			color1="color_did";
			color2="color_error";
			color3="color_nodid";
			color4="color_nodid";
			img1="pass.png";
			img2="error.png";
			img3="notdid.png";
			img4="notdid.png";
			bg_color1="background_color_error";
			bg_color2="background_color_nodid";
			bg_color3="background_color_nodid";
			time1=sdf.format(seal.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==4){//1、用印流程结束 
			if(flag){
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
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_did";
				bg_color4="background_color_did";
				time1=sdf.format(seal.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
				time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
				time5=time4;
				//让之前没有总经理审核流程显示不报错
				if(time3==null){
					time3=time4;
				}
			}else{
				color1="color_did";
				color2="color_did";
				color3="color_did";
				color4="color_did";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_did";
				time1=sdf.format(seal.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
				time4=time3;
			}
		}else if(operation==5){//撤销
			title1_flow="title1_flow0";
			title2_flow="title2_flow0";
			title3_flow="title3_flow0";
			color1="color_did";
			color4="color_error";
			img1="pass.png";
			img4="error.png";
			bg_color3="background_color_error";
			time1=sdf.format(seal.getCreate_time()).replace("#", "<br/>");
			time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==6){//2、印章管理人执行
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
			bg_color1="background_color_did";
			bg_color2="background_color_did";
			bg_color3="background_color_did";
			bg_color4="background_color_nodid";
			time1=sdf.format(seal.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==7){//总经理审核不通过
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
			bg_color1="background_color_did";
			bg_color2="background_color_error";
			bg_color3="background_color_nodid";
			bg_color4="background_color_nodid";
			time1=sdf.format(seal.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}
		if(flag){
			title1_flow="title1_flow2";
			title2_flow="title2_flow2";
			title3_flow="title3_flow2";
		}
		map.put("title1_flow", title1_flow);
		map.put("title2_flow", title2_flow);
		map.put("title3_flow", title3_flow);
		map.put("color1", color1);
		map.put("color2", color2);
		map.put("color3", color3);
		map.put("color4", color4);
		map.put("img1", img1);
		map.put("img2", img2);
		map.put("img3", img3);
		map.put("img4", img4);
		map.put("time1", time1);
		map.put("time2", time2);
		map.put("time3", time3);
		map.put("time4", time4);
		map.put("bg_color1", bg_color1);
		map.put("bg_color2", bg_color2);
		map.put("bg_color3", bg_color3);
		map.put("bg_color4", bg_color4);
		map.put("color5", color5);
		map.put("img5", img5);
		map.put("time5", time5);
		return map;
	}

}
