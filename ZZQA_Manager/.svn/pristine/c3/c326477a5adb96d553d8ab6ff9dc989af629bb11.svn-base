package com.zzqa.service.impl.manufacture;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.manufacture.IManufactureDAO;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.position_user.IPosition_userDAO;
import com.zzqa.dao.interfaces.task.ITaskDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.manufacture.Manufacture;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.manufacture.ManufactureManager;
import com.zzqa.servlet.DelayEmailServlet;
import com.zzqa.util.DataUtil;
@Component("manufactureManager")
public class ManufactureManagerImpl implements ManufactureManager {
	@Autowired
	private IManufactureDAO manufactureDAO;
	@Autowired
	private IFlowDAO flowDAO;
	@Autowired
	private IPosition_userDAO position_userDAO;
	@Autowired
	private ITaskDAO taskDAO;
	@Autowired
	private IUserDAO userDAO;
	@Autowired
	private IPermissionsDAO permissionsDAO;

	public void delManufactureByID(int id) {
		// TODO Auto-generated method stub
		manufactureDAO.delManufactureByID(id);
	}

	public Manufacture getManufactureByID(int id) {
		// TODO Auto-generated method stub
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		Manufacture manufacture=manufactureDAO.getManufactureByID(id);
		manufacture.setCreate_name(userDAO.getUserNameByID(manufacture.getCreate_id()));
		manufacture.setPredict_date(manufacture.getPredict_time()==0?"":sdf.format(manufacture.getPredict_time()));
		return manufacture;
	}
	public Manufacture getManufactureByID2(int id) {
		// TODO Auto-generated method stub
		Manufacture manufacture=manufactureDAO.getManufactureByID(id);
		if(manufacture!=null){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
			Flow flow=flowDAO.getNewFlowByFID(5, manufacture.getId());		
			manufacture.setName(getManufacture(manufacture));
			manufacture.setProcess(sdf.format(flow.getCreate_time())+DataUtil.getFlowArray(5)[flow.getOperation()]);
			manufacture.setCreate_name(userDAO.getUserNameByID(manufacture.getCreate_id()));
		}
		return manufacture;
	}
	private String getManufacture(Manufacture manufacture){
		if(manufacture.getTask_id()==0){
			return DataUtil.getNameByTime(5,manufacture.getCreate_time());
		}
		Task task=taskDAO.getTaskByID(manufacture.getTask_id());
		if(task==null){
			return DataUtil.getNameByTime(5,manufacture.getCreate_time());
		}
		return task.getProject_name();
	}
	public void insertManufacture(Manufacture manufacture) {
		// TODO Auto-generated method stub
		manufactureDAO.insertManufacture(manufacture);
	}

	public void updateManufacture(Manufacture manufacture) {
		// TODO Auto-generated method stub
		manufactureDAO.updateManufacture(manufacture);
	}

	public int getNewManufactureByUID(int create_id) {
		// TODO Auto-generated method stub
		return manufactureDAO.getNewManufactureByUID(create_id);
	}

	public List<Manufacture> getManyfactureList(int beginrow, int rows) {
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("beginrow", beginrow);
		map.put("rows", rows);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd.");
		List<Manufacture> list=manufactureDAO.getManufactureList(map);
		for(Manufacture manufacture:list){
			Flow flow=flowDAO.getNewFlowByFID(5, manufacture.getId());
			if(flow!=null){
				manufacture.setName(getManufacture(manufacture));
				manufacture.setProcess(sdf.format(flow.getCreate_time())+DataUtil.getFlowArray(5)[flow.getOperation()]);
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
		return 0;
	}
	
	public Map<String, String> getManufactureFlowForDraw(Manufacture manufacture,Flow flow) {
		// TODO Auto-generated method stub
		int operation=flow.getOperation();
		Map<String, String> map=new HashMap<String, String>();
		List<Flow> flowList=flowDAO.getFlowListByCondition(5,manufacture.getId());
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd*HH:mm:ss");
		String class11="";
		String class12="";
		String class13="";
		String class14="";
		String img1="";
		String img2="";
		String img3="";
		String img4="";
		String time1="";
		String time2="";
		String time3="";
		String time4="";
		String class215="";
		String class225="";
		String class24="";
		String class26="";
		if(operation==1){
			//备货齐全
			class11="td2_div11_pass";
			class12="td2_div12_nodid";
			class13="td2_div13_nodid";
			class14="td2_div14_nodid";
			img1="pass.png";
			img2="notdid.png";
			img3="notdid.png";
			img4="notdid.png";
			time1=sdf.format(manufacture.getCreate_time()).replace("*", "<br/>");
			time2="";
			time3="";
			time4="";
			class215="td2_div2_agree_c";
			class225="td2_div2_nodid_c";
			class24="td2_div2_nodid";
			class26="td2_div2_nodid";
		}else if(operation==5){
			//出库
			class11="td2_div11_pass";
			class12="td2_div12_nodid";
			class13="td2_div13_nodid";
			class14="td2_div14_nodid";
			img1="pass.png";
			img2="go.png";
			img3="notdid.png";
			img4="notdid.png";
			time1=sdf.format(manufacture.getCreate_time()).replace("*", "<br/>");
			time2="";
			time3="";
			time4="";
			class215="td2_div2_agree_c";
			class225="td2_div2_agree_c";
			class24="td2_div2_nodid";
			class26="td2_div2_nodid";
		}else if(operation==2){
			//出库
			class11="td2_div11_pass";
			class12="td2_div12_pass";
			class13="td2_div13_nodid";
			class14="td2_div14_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="go.png";
			img4="notdid.png";
			time1=sdf.format(manufacture.getCreate_time()).replace("*", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			time3="";
			time4="";
			class215="td2_div2_agree_c";
			class225="td2_div2_agree_c";
			class24="td2_div2_agree";
			class26="td2_div2_nodid";
		}else if(operation==3){
			//生产完毕
			class11="td2_div11_pass";
			class12="td2_div12_pass";
			class13="td2_div13_pass";
			class14="td2_div14_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="pass.png";
			img4="go.png";
			time1=sdf.format(manufacture.getCreate_time()).replace("*", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			time3=sdf.format(lastFlowTime(3, flowList)).replace("*", "<br/>");
			time4="";
			class215="td2_div2_agree_c";
			class225="td2_div2_agree_c";
			class24="td2_div2_agree";
			class26="td2_div2_agree";
		}else if(operation==4){
			//入库
			class11="td2_div11_pass";
			class12="td2_div12_pass";
			class13="td2_div13_pass";
			class14="td2_div14_pass";
			img1="pass.png";
			img2="pass.png";
			img3="pass.png";
			img4="pass.png";
			time1=sdf.format(manufacture.getCreate_time()).replace("*", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			time3=sdf.format(lastFlowTime(3, flowList)).replace("*", "<br/>");
			time4=sdf.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
			class215="td2_div2_agree_c";
			class225="td2_div2_agree_c";
			class24="td2_div2_agree";
			class26="td2_div2_agree";
		}
		map.put("class11", class11);
		map.put("class12", class12);
		map.put("class13", class13);
		map.put("class14", class14);
		
		map.put("img1", img1);
		map.put("img2", img2);
		map.put("img3", img3);
		map.put("img4", img4);
		
		map.put("time1", time1);
		map.put("time2", time2);
		map.put("time3", time3);
		map.put("time4", time4);
		
		map.put("class215", class215);
		map.put("class225", class225);
		map.put("class24", class24);
		map.put("class26", class26);
		return map;
	}

	public List getManufactureListByUID(User user) {
		// TODO Auto-generated method stub
		List<Manufacture> mList=manufactureDAO.getRunningManufacture();//查询所有未完成的生产流程
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		Iterator<Manufacture> iterator=mList.iterator();
		while (iterator.hasNext()) {
			Manufacture manufacture = (Manufacture) iterator.next();
			Flow flow=flowDAO.getNewFlowByFID(5, manufacture.getId());//查询最新流程
			if(flow!=null&&checkMyOperation(flow.getOperation(),user,manufacture)){
				String process=sdf.format(flow.getCreate_time())+DataUtil.getFlowArray(5)[flow.getOperation()];
				manufacture.setName(getManufacture(manufacture));
				manufacture.setProcess(process);
				manufacture.setCreate_name(userDAO.getUserNameByID(manufacture.getCreate_id()));
			}else{
				iterator.remove();
			}
		}
		return mList;
	}
	public boolean checkMyOperation(int operation,User user,Manufacture manufacture){
		boolean flag=false;
		int position_id=user.getPosition_id();
		switch (operation) {
		case 1:
			flag=permissionsDAO.checkPermission(position_id, 24);
			break;
		case 5:
			flag=permissionsDAO.checkPermission(position_id, 23);
			break;
		case 2:
			flag=permissionsDAO.checkPermission(position_id, 24);
			break;
		case 3:
			flag=permissionsDAO.checkPermission(position_id, 23);
			break;
		default:
			break;
		}
		return flag;
	}
}
