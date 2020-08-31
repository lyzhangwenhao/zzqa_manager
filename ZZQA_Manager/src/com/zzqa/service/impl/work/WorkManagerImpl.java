package com.zzqa.service.impl.work;

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
import com.zzqa.dao.interfaces.project.IProjectDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.dao.interfaces.work.IWorkDAO;
import com.zzqa.dao.interfaces.work_day.IWork_dayDAO;
import com.zzqa.dao.interfaces.workday_project.IWorkday_projectDAO;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.position_user.Position_user;
import com.zzqa.pojo.project.Project;
import com.zzqa.pojo.user.User;
import com.zzqa.pojo.vehicle.Vehicle;
import com.zzqa.pojo.work.Work;
import com.zzqa.pojo.work_day.Work_day;
import com.zzqa.pojo.workday_project.Workday_project;
import com.zzqa.service.interfaces.work.WorkManager;
import com.zzqa.util.DataUtil;
@Component("workManager")
public class WorkManagerImpl implements WorkManager {
	@Resource(name="workday_projectDAO")
	private IWorkday_projectDAO workday_projectDAO;
	@Resource(name="work_dayDAO")
	private IWork_dayDAO work_dayDAO;
	@Resource(name="workDAO")
	private IWorkDAO workDAO;
	@Resource(name="projectDAO")
	private IProjectDAO projectDAO;
	@Resource(name="userDAO")
	private IUserDAO userDAO;
	@Resource(name="permissionsDAO")
	private IPermissionsDAO permissionsDAO;
	@Resource(name="position_userDAO")
	private IPosition_userDAO position_userDAO;
	@Resource(name="flowDAO")
	private IFlowDAO flowDAO;
	
	@Override
	public List getWorkByUID(User user) {
		// TODO Auto-generated method stub
		List<Work> workList=workDAO.getRunningWork();
		if(workList!=null&&workList.size()>0){
			SimpleDateFormat format = new SimpleDateFormat( "yyyy.MM.dd" );
			String[] flowArray=DataUtil.getFlowArray(16);
			Iterator<Work> iterator=workList.iterator();
			while (iterator.hasNext()) {
				Work work=(Work)iterator.next();
				Flow flow=flowDAO.getNewFlowByFID(16, work.getId());//查询最新流程
				if(flow!=null&&checkMyOperation(flow.getOperation(),user,work)){
					String process=format.format(flow.getCreate_time())+flowArray[flow.getOperation()];
					work.setProcess(process);
					work.setName(DataUtil.getNameByTime(16,work.getWorkmonth()));
					work.setCreate_name(userDAO.getUserNameByID(work.getCreate_id()));
				}else{
					iterator.remove();
				}
			}
		}
		return workList;
	}
	private boolean checkMyOperation(int operation,User user,Work work){
		boolean flag=false;
		int position_id=user.getPosition_id();
		Position_user position_user=position_userDAO.getPositionByUID(work.getCreate_id());
		if(position_user!=null&&position_user.getParent()==user.getPosition_id()&&user.getPosition_id()!=0){
			flag=true;
		}else if(operation<3&&work.getCreate_id()==user.getId()){
			return true;
		}
		return flag;
	}
	@Override
	public int insertWork(Work work) {
		// TODO Auto-generated method stub
		workDAO.insertWork(work);
		return workDAO.getNewWorkByUID(work.getCreate_id());
	}
	@Override
	public Work getWorkByID(int id) {
		// TODO Auto-generated method stub
		Work work=workDAO.getWorkByID(id);
		if(work!=null){
			work.setCreate_name(userDAO.getUserNameByID(work.getCreate_id()));
		}
		return work;
	}
	@Override
	public void updateWork(Work work) {
		// TODO Auto-generated method stub
		workDAO.updateWork(work);
	}
	@Override
	public void delWorkByID(int id) {
		// TODO Auto-generated method stub
		workDAO.delWorkByID(id);
	}
	@Override
	public Work getWorkByMonthAndUID2(long month, int create_id) {
		// TODO Auto-generated method stub
		return workDAO.getWorkByMonthAndUID(month, create_id);
	}
	@Override
	public Work getWorkByMonthAndUID(long month, int create_id) {
		// TODO Auto-generated method stub
		Work work=workDAO.getWorkByMonthAndUID(month, create_id);
		if(work!=null){
			Flow flow=flowDAO.getNewFlowByFID(16, work.getId());
			if(flow==null){
				work=null;
			}else{
				work.setOperation(flow.getOperation());
				List<Work_day> list=getWork_daysByWID(work.getId());
				work.setList(list);
			}
		}
		return work;
	}
	@Override
	public List<Work> getWorkByMonths(long starttime,long endtime){
		List<Work> list=workDAO.getWorkByMonths(starttime, endtime);
		if(list!=null){
			for(int i=0,wLen=list.size();i<wLen;i++){
				Work work=list.get(i);
				List<Work_day> wd_list=work.getList();
				List<Work_day> wd_list2=new ArrayList<Work_day>();
				for (Work_day work_day : wd_list) {
					List<Workday_project> wp_list=work_day.getList();
					List<Workday_project> wp_list2=new ArrayList<Workday_project>();
					for (Workday_project workday_project : wp_list) {
						wp_list2.add(workday_project);
					}
					work_day.setList(wp_list2);
					wd_list2.add(work_day);
				}
				work.setList(wd_list2);
			}
		}
		return list;
	}
	public List<User> getAllUserWidthWork(){
		return workDAO.getAllUserWidthWork();
	}
	public boolean checkNumByLeaderId(int uid){
		return workDAO.checkNumByLeaderId(uid);
	}
	@Override
	public int insertWork_day(Work_day work_day) {
		// TODO Auto-generated method stub
		work_dayDAO.insertWork_day(work_day);
		Work_day work_day2=work_dayDAO.getWork_dayByWIDAndWD(work_day.getWork_id(),work_day.getWorkday());
		if(work_day2!=null){
			return work_day2.getId();
		}else{
			return 0;
		}
	}
	@Override
	public Work_day getWork_dayByID(int id) {
		// TODO Auto-generated method stub
		return work_dayDAO.getWork_dayByID(id);
	}
	@Override
	public Work_day getWork_dayByWIDAndWD(int work_id,int workday){
		// TODO Auto-generated method stub
		return work_dayDAO.getWork_dayByWIDAndWD(work_id,workday);
	}
	@Override
	public void updateWork_day(Work_day work_day) {
		// TODO Auto-generated method stub
		work_dayDAO.updateWork_day(work_day);
	}
	@Override
	public void delWork_dayByID(int id) {
		// TODO Auto-generated method stub
		work_dayDAO.delWork_dayByID(id);
	}
	@Override
	public List<Work_day> getWork_daysByWID(int word_id){
		List<Work_day> list=work_dayDAO.getWork_daysByWID(word_id);
		for (int i = 0,size=list.size(); i < size; i++) {
			Work_day work_day=list.get(i);
			List<Workday_project> list2=workday_projectDAO.getWorkday_projectsByWDID(work_day.getId());
			work_day.setList(list2);
		}
		return list;
	}
	@Override
	public void updateStatus(int id, int status){
		work_dayDAO.updateStatus(id, status);
	}
	@Override
	public void insertWorkday_project(Workday_project workday_project) {
		// TODO Auto-generated method stub
		workday_projectDAO.insertWorkday_project(workday_project);
	}
	@Override
	public Workday_project getWorkday_projectByID(int id) {
		// TODO Auto-generated method stub
		return workday_projectDAO.getWorkday_projectByID(id);
	}
	@Override
	public void updateWorkday_project(Workday_project workday_project) {
		// TODO Auto-generated method stub
		workday_projectDAO.updateWorkday_project(workday_project);
	}
	@Override
	public void delWorkday_projectByID(int id) {
		// TODO Auto-generated method stub
		workday_projectDAO.delWorkday_projectByID(id);
	}
	@Override
	public void delWorkday_projectByWDID(int workday_id) {
		// TODO Auto-generated method stub
		workday_projectDAO.delWorkday_projectByWDID(workday_id);
	}
	@Override
	public int insertProject(Project project) {
		// TODO Auto-generated method stub
		projectDAO.insertProject(project);
		return projectDAO.getNewProject();
	}
	@Override
	public Project getProjectByID(int id) {
		// TODO Auto-generated method stub
		return projectDAO.getProjectByID(id);
	}
	@Override
	public void updateProject(Project project) {
		// TODO Auto-generated method stub
		projectDAO.updateProject(project);
	}
	@Override
	public boolean delProjectByID(int id) {
		// TODO Auto-generated method stub
		boolean canDel=!workday_projectDAO.checkProjectBind(id);
		if(canDel){
			projectDAO.delProjectByID(id);
		}
		return canDel;
	}
	@Override
	public List<Project> getProjects() {
		// TODO Auto-generated method stub
		return projectDAO.getProjects();
	}
	@Override
	public boolean checkProjectByPName(String project_name,int id) {
		// TODO Auto-generated method stub
		return projectDAO.checkProjectByPName(project_name,id);
	}
	@Override
	public Map getWorkdaysReport(long startM, int startDay, long endM,
			int endDay) {
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("startM", startM);
		map.put("startDay", startDay);
		map.put("endM", endM);
		map.put("endDay", endDay);
		map.put("sqltype", startM==endM?1:0);
		return workDAO.getWorkdaysReport(map);
	}
}
