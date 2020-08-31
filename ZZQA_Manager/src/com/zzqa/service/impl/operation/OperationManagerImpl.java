package com.zzqa.service.impl.operation;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.operation.IOperationDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.operation.Operation;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.operation.OperationManager;
import com.zzqa.util.DataUtil;
@Component("operationManager")
public class OperationManagerImpl implements OperationManager {
	@Resource(name="operationDAO")
	private IOperationDAO operationDAO;
	@Resource(name="userDAO")
	private IUserDAO userDAO;

	public void delOperationByID(int id) {
		// TODO Auto-generated method stub
		operationDAO.delOperationByID(id);
	}

	public List<Operation> getOperationList(String name_log,int newtime_log,String starttime,String endtime,String keywords,int nowpage) {
		// TODO Auto-generated method stub
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Map<String, Object> map=new HashMap<String, Object>();
		List<Operation> operaList=new ArrayList<Operation>();
		try {
			if(newtime_log==0){
				map.put("starttime", 0);
				map.put("endtime", 0);
			}else{
				map.put("starttime", sdf.parse(starttime).getTime());
				map.put("endtime", sdf.parse(endtime).getTime()+24*3600*1000);
			}
			map.put("keywords", keywords);
			map.put("name", name_log);
			map.put("nowpage", nowpage*20-20);
			operaList=operationDAO.getOperationList(map);
			for(Operation op:operaList){
				op.setUsername(userDAO.getUserNameByID(op.getUid()));
				op.setCreate_date(sdf1.format(op.getCreate_time()));
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return operaList;
	}
	public void insertOperation(Operation operation) {
		// TODO Auto-generated method stub
		operationDAO.insertOperation(operation);
	}

	public void updateOperation(Operation operation) {
		// TODO Auto-generated method stub
		operationDAO.updateOperation(operation);
	}

	@Override
	public int getOperationCount(String name_log, int newtime_log,
			String starttime, String endtime, String keywords) {
		// TODO Auto-generated method stub
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		Map<String, Object> map=new HashMap<String, Object>();
		int count=0;
		try {
			if(newtime_log==0){
				map.put("starttime", 0);
				map.put("endtime", 0);
			}else{
				map.put("starttime", sdf.parse(starttime).getTime());
				map.put("endtime", sdf.parse(endtime).getTime()+24*3600*1000);
			}
			map.put("keywords", keywords);
			map.put("name", name_log);
			count=operationDAO.getOperationCount(map);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count;
	}

}
