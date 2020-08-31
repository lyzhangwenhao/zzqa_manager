package com.zzqa.service.impl.task_conflict;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.file_path.IFile_pathDAO;
import com.zzqa.dao.interfaces.linkman.ILinkmanDAO;
import com.zzqa.dao.interfaces.task.ITaskDAO;
import com.zzqa.dao.interfaces.task_conflict.ITask_conflictDAO;
import com.zzqa.pojo.file_path.File_path;
import com.zzqa.pojo.linkman.Linkman;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.task_conflict.Task_conflict;
import com.zzqa.service.interfaces.task.TaskManager;
import com.zzqa.service.interfaces.task_conflict.Task_conflictManager;
@Component("task_conflictManager")
public class Task_conflictManagerImpl implements Task_conflictManager {
	@Autowired
	private ITask_conflictDAO task_conflictDAO;
	@Autowired
	private ITaskDAO taskDAO;
	@Autowired
	private ILinkmanDAO linkmanDAO;
	@Autowired
	private IFile_pathDAO file_pathDAO;

	public boolean checkTask_conflict(int task_id) {
		// TODO Auto-generated method stub
		return task_conflictDAO.checkTask_conflict(task_id);
	}

	public void delTask_conflictByID(int task_id) {
		// TODO Auto-generated method stub
		task_conflictDAO.delTask_conflictByID(task_id);
	}

	public Task_conflict getTask_conflictByTaskID(int task_id) {
		// TODO Auto-generated method stub
		Task_conflict task_conflict=task_conflictDAO.getTask_conflictByTaskID(task_id);
		SimpleDateFormat format = new SimpleDateFormat( "yyyy.MM.dd" );
		if(task_conflict==null){
			task_conflict=new Task_conflict();
		}else{
			task_conflict.setDelivery_timestr(format.format(task_conflict.getDelivery_time()));
			task_conflict.setContract_timestr(format.format(task_conflict.getContract_time()));
		}
		return task_conflict;
	}

	public void updateTask_conflict(Task_conflict task_conflict) {
		// TODO Auto-generated method stub
		Task_conflict task_conflict2=task_conflictDAO.getTask_conflictByTaskID(task_conflict.getTask_id());
		if(task_conflict2!=null){
			task_conflictDAO.updateTask_conflict(task_conflict);
		}else{
			task_conflictDAO.insertTask_conflict(task_conflict);
		}		
	}

	public boolean[] checkConflict(int task_id) {
		// TODO Auto-generated method stub
		boolean[] checkArray=new boolean[30];//false表示不同
		Task_conflict task_conflict=task_conflictDAO.getTask_conflictByTaskID(task_id);
		Task task=taskDAO.getTaskByID(task_id);
		if(task_conflict==null || task==null){
			return null;
		}
		int task_type=task.getType()==0?1:17;
		checkArray[14]=task_conflict.getProject_category()==task.getProject_category();
		//需要对数据进行判断，是否是新数据，以及是否是风电项目
		if (task_conflict.getProject_category()==0&&"1".equals(task_conflict.getIs_new_data())){
			//为风电项目，且为新数据
			checkArray[15] = checkString(task_conflict.getFan_product_type(), task.getFan_product_type());
		}else{
			//不是新数据和不为风电项目
			checkArray[15] = task_conflict.getProduct_type()==task.getProduct_type();
		}
//		checkArray[15]=task_conflict.getProduct_type()==task.getProduct_type();
		//项目名称对比
//		checkArray[0]=task_conflict.getProject_name().equals(task.getProject_name());
		checkArray[0]=checkString(task_conflict.getProject_name(), task.getProject_name());

//		checkArray[1]=task_conflict.getProject_id().equals(task.getProject_id());
		checkArray[1]=checkString(task_conflict.getProject_id(), task.getProject_id());

		checkArray[2]=task_conflict.getProject_case()==task.getProject_case();

		checkArray[3]=task_conflict.getStage()==task.getStage();

		checkArray[4]=task_conflict.getProject_type()==task.getProject_type();

//		checkArray[5]=task_conflict.getCustomer().equals(task.getCustomer());
		checkArray[5]=checkString(task_conflict.getCustomer(), task.getCustomer());
		
		Map map=new HashMap();
		map.put("type", task_type);
		map.put("foreign_id", task_id);
		map.put("linkman_case", 1);
		map.put("state", 0);
		List<Linkman> userList=linkmanDAO.getLinkmanListLimit(map);
		map.put("state", 1);
		List<Linkman> userList_conflict=linkmanDAO.getLinkmanListLimit(map);
		checkArray[6]=checkLinkman(userList,userList_conflict);
		
		map.put("linkman_case", 2);
		map.put("state", 0);
		List<Linkman> billList=linkmanDAO.getLinkmanListLimit(map);
		map.put("state", 1);
		List<Linkman> billList_conflict=linkmanDAO.getLinkmanListLimit(map);
		checkArray[7]=checkLinkman(billList,billList_conflict);
		
		map.put("linkman_case", 3);
		map.put("state", 0);
		List<Linkman> deviceList=linkmanDAO.getLinkmanListLimit(map);
		map.put("state", 1);
		List<Linkman> deviceList_conflict=linkmanDAO.getLinkmanListLimit(map);
		checkArray[8]=checkLinkman(deviceList,deviceList_conflict);
		
		checkArray[9]=task.getDelivery_time()==task_conflict.getDelivery_time();
		
		if(task.getInspection()!=task_conflict.getInspection()||
				task.getVerify()!=task_conflict.getVerify()){
			checkArray[10]=false;
		}else{
			checkArray[10]=checkString(task.getDescription(),task_conflict.getDescription());
		}
		
		Map map2=new HashMap();
		map2.put("type", task_type);
		map2.put("foreign_id", task_id);
		map2.put("file_type", 1);
		map2.put("state", 0);
		List<File_path> fiList=file_pathDAO.getAllFileByCondition(map2);
		map2.put("state", 1);
		List<File_path> fiList_conflict=file_pathDAO.getAllFileByCondition(map2);
		checkArray[11]=checkFile(fiList, fiList_conflict);
		
		if(checkString(task.getOther(), task_conflict.getOther())){
			map2.put("file_type", 2);
			map2.put("state", 0);
			List<File_path> fiList1=file_pathDAO.getAllFileByCondition(map2);
			map2.put("state", 1);
			List<File_path> fiList1_conflict=file_pathDAO.getAllFileByCondition(map2);
			checkArray[12]=checkFile(fiList1, fiList1_conflict);
		}else{
			checkArray[12]=false;
		}
		checkArray[13]=checkString(task.getRemarks(), task_conflict.getRemarks());
		checkArray[16]=task.getContract_time()==task_conflict.getContract_time();
		if(task.getType()==1&&checkArray[12]){
			if(checkString(task.getOther2(), task_conflict.getOther2())){
				map2.put("file_type", 3);
				map2.put("state", 0);
				List<File_path> fiList3=file_pathDAO.getAllFileByCondition(map2);
				map2.put("state", 1);
				List<File_path> fiList3_conflict=file_pathDAO.getAllFileByCondition(map2);
				checkArray[12]=checkFile(fiList3, fiList3_conflict);
			}else{
				checkArray[12]=false;
			}
			if(checkArray[12]){
				if(checkString(task.getOther3(), task_conflict.getOther3())){
					map2.put("file_type", 4);
					map2.put("state", 0);
					List<File_path> fiList4=file_pathDAO.getAllFileByCondition(map2);
					map2.put("state", 1);
					List<File_path> fiList4_conflict=file_pathDAO.getAllFileByCondition(map2);
					checkArray[12]=checkFile(fiList4, fiList4_conflict);
				}else{
					checkArray[12]=false;
				}
			}
			if(checkArray[12]){
				if(checkString(task.getOther4(), task_conflict.getOther4())){
					map2.put("file_type", 5);
					map2.put("state", 0);
					List<File_path> fiList5=file_pathDAO.getAllFileByCondition(map2);
					map2.put("state", 1);
					List<File_path> fiList5_conflict=file_pathDAO.getAllFileByCondition(map2);
					checkArray[12]=checkFile(fiList5, fiList5_conflict);
				}else{
					checkArray[12]=false;
				}
			}
			if(checkArray[12]){
				if(checkString(task.getOther5(), task_conflict.getOther5())){
					map2.put("file_type", 6);
					map2.put("state", 0);
					List<File_path> fiList6=file_pathDAO.getAllFileByCondition(map2);
					map2.put("state", 1);
					List<File_path> fiList6_conflict=file_pathDAO.getAllFileByCondition(map2);
					checkArray[12]=checkFile(fiList6, fiList6_conflict);
				}else{
					checkArray[12]=false;
				}
			}
			if(checkArray[12]){
				if(checkString(task.getOther6(), task_conflict.getOther6())){
					map2.put("file_type", 7);
					map2.put("state", 0);
					List<File_path> fiList7=file_pathDAO.getAllFileByCondition(map2);
					map2.put("state", 1);
					List<File_path> fiList7_conflict=file_pathDAO.getAllFileByCondition(map2);
					checkArray[12]=checkFile(fiList7, fiList7_conflict);
				}else{
					checkArray[12]=false;
				}
			}
		}
		checkArray[17]=checkString(task.getProject_life(),task_conflict.getProject_life());
		checkArray[18]=checkString(task.getProject_report_peried(), task_conflict.getProject_report_peried());
		checkArray[19]=checkString(task.getAddress(),task_conflict.getAddress());
		//新加字段
		checkArray[20]=checkString(task.getFan_num(), task_conflict.getFan_num());
		checkArray[21]=checkString(task.getFactory(), task_conflict.getFactory());
		checkArray[22]=checkString(task.getSubmit_date(), task_conflict.getSubmit_date());
		checkArray[23]=checkString(task.getContract_type(), task_conflict.getContract_type());
		checkArray[24]=checkString(task.getEquipment_type(), task_conflict.getEquipment_type());
		checkArray[25]=checkString(task.getConsignee(), task_conflict.getConsignee());

		return checkArray;
	}
	//比较联系人
	private boolean checkLinkman(List<Linkman> list1,List<Linkman> list2){
		if(list1.size()!=list2.size()){
			return false;
		}else{
			int len=list1.size();
			for(int i=0;i<len;i++){
				Linkman linkman1=list1.get(i);
				Linkman linkman2=list2.get(i);
				if(!linkman1.getLinkman().equals(linkman2.getLinkman())){
					return false;
				}
				if(!linkman1.getPhone().equals(linkman2.getPhone())){
					return false;
				}
			}
			return true;
		}	
	}
	//比较文件
	private boolean checkFile(List<File_path> list1,List<File_path> list2){ 
		if(list1.size()!=list2.size()){
			return false;
		}else{
			int len=list1.size();
			for(int i=0;i<len;i++){
				File_path file_path1=list1.get(i);
				File_path file_path2=list2.get(i);
				if(!file_path1.getPath_name().equals(file_path2.getPath_name())){
					return false;
				}
			}
		}
		return true;
	}
	//比较字符串
	private boolean checkString(String str1,String str2){
		if(str1==null||str1.length()==0){
			return str2==null||str2.length()==0;
		}else{
			return str1.equals(str2);
		}
	}
}
