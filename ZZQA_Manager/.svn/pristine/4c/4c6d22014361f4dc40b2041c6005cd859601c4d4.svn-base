package com.zzqa.service.impl.travel;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.position_user.IPosition_userDAO;
import com.zzqa.dao.interfaces.resumption.IResumptionDAO;
import com.zzqa.dao.interfaces.travel.ITravelDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.resumption.Resumption;
import com.zzqa.pojo.shipments.Shipments;
import com.zzqa.pojo.travel.Travel;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.travel.TravelManager;
import com.zzqa.servlet.DelayEmailServlet;
import com.zzqa.util.DataUtil;
@Component("travelManager")
public class TravelManagerImpl implements TravelManager {
	private IUserDAO userDAO;
	private ITravelDAO travelDAO;
	private IFlowDAO flowDAO;
	private IPosition_userDAO position_userDAO;
	private IPermissionsDAO permissionsDAO;
	private IResumptionDAO resumptionDAO;
	public IResumptionDAO getResumptionDAO() {
		return resumptionDAO;
	}
	@Resource(name="resumptionDAO")
	public void setResumptionDAO(IResumptionDAO resumptionDAO) {
		this.resumptionDAO = resumptionDAO;
	}

	public IPermissionsDAO getPermissionsDAO() {
		return permissionsDAO;
	}
	@Resource(name="permissionsDAO")
	public void setPermissionsDAO(IPermissionsDAO permissionsDAO) {
		this.permissionsDAO = permissionsDAO;
	}

	public IPosition_userDAO getPosition_userDAO() {
		return position_userDAO;
	}
	@Resource(name="position_userDAO")
	public void setPosition_userDAO(IPosition_userDAO position_userDAO) {
		this.position_userDAO = position_userDAO;
	}

	public IFlowDAO getFlowDAO() {
		return flowDAO;
	}
	@Resource(name="flowDAO")
	public void setFlowDAO(IFlowDAO flowDAO) {
		this.flowDAO = flowDAO;
	}

	public IUserDAO getUserDAO() {
		return userDAO;
	}
	@Resource(name="userDAO")
	public void setUserDAO(IUserDAO userDAO) {
		this.userDAO = userDAO;
	}

	public ITravelDAO getTravelDAO() {
		return travelDAO;
	}
	@Resource(name="travelDAO")
	public void setTravelDAO(ITravelDAO travelDAO) {
		this.travelDAO = travelDAO;
	}

	@Override
	public void updateTravel(Travel travel) {
		// TODO Auto-generated method stub
		travelDAO.updateTravel(travel);
	}

	@Override
	public void insertTravel(Travel travel) {
		// TODO Auto-generated method stub
		travelDAO.insertTravel(travel);
	}

	@Override
	public Travel getTravelByID(int id) {
		// TODO Auto-generated method stub
		Travel travel=travelDAO.getTravelByID(id);
		travel.setCreate_name(userDAO.getUserNameByID(travel.getCreate_id()));
		travel.setFinancial_name(userDAO.getUserNameByID(travel.getFinancial_id()));
		travel.setAttendance_name(userDAO.getUserNameByID(travel.getAttendance_id()));
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		String startDate=sdf.format(travel.getStarttime());
		travel.setHalfDay1("0".equals(startDate.substring(11, 12))?0:1);//00:00:00表示上午
		travel.setStartDate(startDate.substring(0, 10));
		String endDate=sdf.format(travel.getEndtime());
		travel.setHalfDay2("0".equals(endDate.substring(11, 12))?0:1);//12:00:00点表示下午
		travel.setEndDate(endDate.substring(0, 10));
		travel.setDepartment_name(DataUtil.getdepartment()[travel.getDepartment()]);
		travel.setAlldays(subZeroAndDot(String.valueOf(((travel.getEndtime()-travel.getStarttime())/86400000d +0.5))));
		return travel;
	}
	/** 
     * 使用java正则表达式去掉多余的.与0 
     * @param s 
     * @return  
     */  
    private String subZeroAndDot(String s){  
        if(s.indexOf(".") > 0){  
            s = s.replaceAll("0+?$", "");//去掉多余的0  
            s = s.replaceAll("[.]$", "");//如最后一位是.则去掉  
        }  
        return s;  
    }

	@Override
	public Travel getNewTravelByCreateID(int create_id) {
		// TODO Auto-generated method stub
		return travelDAO.getNewTravelByCreateID(create_id);
	}

	@Override
	public List<Travel> getAllTravelList() {
		// TODO Auto-generated method stub
		return travelDAO.getAllTravelList();
	}
	private long lastFlowTime(int operation,List<Flow> flowList){
		Flow flow=null;
		int len=flowList.size();
		for (int i = 0; i < len; i++) {
			if(flowList.get(len-i-1).getOperation()==operation){
				return flowList.get(len-i-1).getCreate_time();
			}
		}
		return 0;//找不到就直接返0
	}
	@Override
	public Map<String, String> getTravelFlowForDraw(Travel travel,Flow flow) {
		// TODO Auto-generated method stub
		int operation=flow.getOperation();
		Map<String, String> map=new HashMap<String, String>();
		List<Flow> flowList=flowDAO.getFlowListByCondition(7,travel.getId());
		SimpleDateFormat dft=new SimpleDateFormat("yyyy-MM-dd*HH:mm:ss");
		String class11="";
		String class12="";
		String class13="";
		String class14="";
		String class15="";
		String img1="";
		String img2="";
		String img3="";
		String img4="";
		String img5="";
		String time1="";
		String time2="";
		String time3="";
		String time4="";
		String time5="";
		String class21="";
		String class22="";
		String class23="";
		String class24="";
		String class245="";
		String class246="";
		if(operation==7){
			int opera=flowList.get(flowList.size()-2).getOperation();
			map.put("class1", "del_1_"+opera);
			map.put("class2", "del_2_"+opera);
			map.put("class3", "del_3_"+opera);
			map.put("time1", dft.format(travel.getCreate_time()).replace("*", "<br/>"));
			map.put("time2", dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>"));
			map.put("time3", dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>"));
			map.put("time4", dft.format(lastFlowTime(7, flowList)).replace("*", "<br/>"));
			return map;
		}else if(operation==1){
			//新建
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
			time1=dft.format(travel.getCreate_time()).replace("*", "<br/>");
			time2="";
			time3="";
			time4="";
			time5="";
			class21="td2_div2_agree";
			class22="td2_div2_nodid";
			class23="td2_div2_nodid";
			class245="td2_div2_nodid_half";
			class246="td2_div2_nodid_half";
		}else if(operation==2){
			//上级领导同意
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
			time1=dft.format(travel.getCreate_time()).replace("*", "<br/>");
			time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			time3="";
			time4="";
			time5="";
			class21="td2_div2_agree";
			class22="td2_div2_agree";
			class23="td2_div2_nodid";
			class245="td2_div2_nodid_half";
			class246="td2_div2_nodid_half";
		}else if(operation==3){
			//上级领导审批未通过
			class11="td2_div11_pass";
			class12="td2_div16_nopass";
			class13="hide_css";
			class14="hide_css";
			class15="td2_div15_nodid";
			img1="pass.png";
			img2="error.png";
			img3="notdid.png";
			img4="notdid.png";
			img5="notdid.png";
			time1=dft.format(travel.getCreate_time()).replace("*", "<br/>");
			time2=dft.format(lastFlowTime(3, flowList)).replace("*", "<br/>");
			time3="";
			time4="";
			time5="";
			class21="td2_div2_disagree_no";
			class22="td2_div2_nodid_no";
			class23="hide_css";
			class245="hide_css";
			class246="hide_css";
		}else if(operation==4){
			//考勤备案
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
			time1=dft.format(travel.getCreate_time()).replace("*", "<br/>");
			time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			time3=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
			time4="";
			time5="";
			class21="td2_div2_agree";
			class22="td2_div2_agree";
			class23="td2_div2_agree";
			class245="td2_div2_nodid_half";
			class246="td2_div2_nodid_half";
		}else if(operation==5){
			//财务备案
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
			time1=dft.format(travel.getCreate_time()).replace("*", "<br/>");
			time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			time3=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
			time4=dft.format(lastFlowTime(5, flowList)).replace("*", "<br/>");
			time5=time4;
			class21="td2_div2_agree";
			class22="td2_div2_agree";
			class23="td2_div2_agree";
			class245="td2_div2_agree_half";
			class246="td2_div2_agree_half";
		}else if(operation==8){
			//无责备案
			class11="td2_div11_pass";
			class12="td2_div12_pass";
			class13="td2_div13_pass";
			class14="td2_div14_pass";
			class15="td2_div15_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="pass.png";
			img4="pass.png";
			img5="notdid.png";
			time1=dft.format(travel.getCreate_time()).replace("*", "<br/>");
			time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			time3=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
			time4=dft.format(lastFlowTime(8, flowList)).replace("*", "<br/>");
			class21="td2_div2_agree";
			class22="td2_div2_agree";
			class23="td2_div2_agree";
			class245="td2_div2_agree_half";
			class246="td2_div2_nodid_half";
		}else if(operation==6){
			//审批结束
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
			time1=dft.format(travel.getCreate_time()).replace("*", "<br/>");
			time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			time3=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
			time4=dft.format(lastFlowTime(5, flowList)).replace("*", "<br/>");
			time5=time4;
			class21="td2_div2_agree";
			class22="td2_div2_agree";
			class23="td2_div2_agree";
			class245="td2_div2_agree_half";
			class246="td2_div2_agree_half";
		}
		map.put("class11", class11);
		map.put("class12", class12);
		map.put("class13", class13);
		map.put("class14", class14);
		map.put("class15", class15);
		
		map.put("img1", img1);
		map.put("img2", img2);
		map.put("img3", img3);
		map.put("img4", img4);
		map.put("img5", img5);
		
		map.put("time1", time1);
		map.put("time2", time2);
		map.put("time3", time3);
		map.put("time4", time4);
		map.put("time5", time5);
		
		map.put("class21", class21);
		map.put("class22", class22);
		map.put("class23", class23);
		map.put("class24", class24);
		map.put("class245", class245);
		map.put("class246", class246);
		return map;
	}

	@Override
	public List<Travel> getTravelListByUID(User user) {
		// TODO Auto-generated method stub
		List<Travel> travelList=travelDAO.getRunningTravel();//查询所有未完成的出差流程
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		String[] flowArray7=DataUtil.getFlowArray(7);
		Iterator<Travel> iterator=travelList.iterator();
		while (iterator.hasNext()) {
			Travel travel = (Travel) iterator.next();
			User userByID = userDAO.getUserByID(travel.getCreate_id());
			if(userByID==null || userByID.getPosition_id()==56){
				iterator.remove();
				continue;
			}
			Flow flow=flowDAO.getNewFlowByFID(7, travel.getId());//查询最新流程
			if(flow!=null&&checkMyOperation(flow.getOperation(),user,travel)){
				String process=sdf.format(flow.getCreate_time())+flowArray7[flow.getOperation()];
				travel.setProcess(process);
				travel.setName(DataUtil.getNameByTravel(travel.getAddress(),travel.getStarttime(),travel.getEndtime()));
				travel.setCreate_name(userByID.getTruename());
			}else{
				iterator.remove();
			}
		}
		return travelList;
	}
	private boolean checkMyOperation(int operation,User user,Travel travel){
		boolean flag=false;
		User user1=userDAO.getUserByID(travel.getCreate_id());
		if(user1==null){
			return flag;
		}
		int position_id=user.getPosition_id();
		if(position_id==0){
			return flag;
		}
		switch (operation) {
		case 1:
			//出差由上级领导审批
			flag=position_id==position_userDAO.getPositionByID(user1.getPosition_id()).getParent();
			break;
		case 2:
			//考勤备案
			flag=permissionsDAO.checkPermission(position_id, 32);
			if(flag){
				travel.setCanBack(true);
			}
			break;
		case 4:
			//财务备案
			flag=permissionsDAO.checkPermission(position_id, 31);
			break;
		case 6:
			//出差延时修改
			flag=user.getId()==travel.getCreate_id();
			break;
		case 8:
			//无责备案等待本人确认
			flag=user.getId()==travel.getCreate_id();
			break;
		default:
			break;
		}
		return flag;
		
	}

	@Override
	public List<Travel> getTravelListAfterApproval(int uid) {
		// TODO Auto-generated method stub
		List<Travel> tList=travelDAO.getTravelListAfterApproval(uid);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
		for(Travel travel:tList){
			String startDate=sdf.format(travel.getStarttime());
			startDate=startDate.substring(0, 11)+("0".equals(startDate.substring(12,13))?"上午":"下午");
			String endDate=sdf.format(travel.getEndtime());
			endDate=endDate.substring(0,11)+("0".equals(endDate.substring(12,13))?"上午":"下午");
			travel.setName(new StringBuilder().append("出差单-").append(startDate).append("至").append(endDate).toString());
		}
		return tList;
	}
	
	@Override
	public List<Travel> getTravelListReport(int year, int month) {
		// TODO Auto-generated method stub
		SimpleDateFormat sdf1=new SimpleDateFormat("yyyy.MM.dd HH");
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		List<Travel> travelList=new ArrayList<Travel>();
		Map map=new HashMap();
		try {
			long starttime=sdf.parse(year+"."+month+"."+"01").getTime();
			long endtime=sdf.parse(year+"."+(month+1)+"."+"01").getTime();
			map.put("starttime",starttime );
			map.put("endtime", endtime);
			travelList=travelDAO.getTravelListReport(map);
			Iterator<Travel> iterator=travelList.iterator();
			String[] departmentArray=DataUtil.getdepartment();
			while (iterator.hasNext()) {
				Travel travel = (Travel) iterator.next();
				if(travel.getCreate_name()==null){
					travel.setCreate_name(userDAO.getUserNameByID(travel.getCreate_id()));
				}
				travel.setFinancial_name(userDAO.getUserNameByID(travel.getFinancial_id()));
				travel.setAttendance_name(userDAO.getUserNameByID(travel.getAttendance_id()));
				Resumption resumption=resumptionDAO.getFinishedResumption(1, travel.getId());
				//判断是否有销假
				if(resumption!=null){
					if(resumption.getReback_time()<=starttime||resumption.getReback_time()<=travel.getStarttime()){
						//当月已被销假的或销假到0天的在当月报表中不显示
						iterator.remove();
						continue;
					}
					//判断是否为跨月
					if(travel.getStarttime()>=starttime){
						//travel.setStarttime(travel.getStarttime());
						travel.setStartDate(getDate(sdf1,travel.getStarttime()));
					}else{
						travel.setStarttime(starttime);
						travel.setStartDate(getDate(sdf1,starttime)+"<br/>(跨月)");
					}
					if(resumption.getReback_time()>endtime){
						travel.setEndDate(getDate(sdf1, endtime-43200000)+"<br/>(销假)(跨月)");
						travel.setAlldays(subZeroAndDot(String.valueOf(((endtime-travel.getStarttime())/86400000d))));
					}else{
						//下午回来上班，出差结束时间应为上午
						travel.setEndDate(getDate(sdf1, resumption.getReback_time()-43200000)+"<br/>(销假)");
						travel.setAlldays(subZeroAndDot(String.valueOf(((resumption.getReback_time()-travel.getStarttime())/86400000d))));
					}
				}else{
					if(travel.getStarttime()>=starttime){
						//travel.setStarttime(travel.getStarttime());
						travel.setStartDate(getDate(sdf1,travel.getStarttime()));
					}else{
						travel.setStarttime(starttime);
						travel.setStartDate(getDate(sdf1,starttime)+"<br/>(跨月)");
					}
					//判断是否为跨月
					if(travel.getEndtime()>=endtime){
						travel.setEndDate(getDate(sdf1, endtime-43200000)+"<br/>(跨月)");
						travel.setAlldays(subZeroAndDot(String.valueOf(((endtime-travel.getStarttime())/86400000d))));
					}else{
						travel.setEndDate(getDate(sdf1,travel.getEndtime()));
						travel.setAlldays(subZeroAndDot(String.valueOf(((travel.getEndtime()-travel.getStarttime())/86400000d+0.5))));
					}
				}
				if(Float.parseFloat(travel.getAlldays())<0.5){
					iterator.remove();
					continue;
				}
				travel.setDepartment_name(departmentArray[travel.getDepartment()]);
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return travelList;
		}
		return travelList;
	}
	private String getDate(SimpleDateFormat sdf,long time){
		String date=sdf.format(time);
		return date.substring(0, 10)+("0".equals(date.substring(12,13))?"上午":"下午");
	}

	@Override
	public void delTravelByID(int id) {
		// TODO Auto-generated method stub
		travelDAO.delTravelByID(id);
	}
	@Override
	public boolean checkTravelInScope(long starttime, long endtime, int create_id) {
		// TODO Auto-generated method stub
		Map<String , Object> map=new HashMap<String , Object>();
		map.put("starttime", starttime);
		map.put("endtime", endtime);
		map.put("create_id", create_id);
		return travelDAO.checkTravelInScope(map);
	}
}
