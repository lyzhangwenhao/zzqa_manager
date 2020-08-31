package com.zzqa.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.StringTokenizer;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.web.context.support.WebApplicationContextUtils;

import com.zzqa.pojo.aftersales_task.Aftersales_task;
import com.zzqa.pojo.file_path.File_path;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.linkman.Linkman;
import com.zzqa.pojo.operation.Operation;
import com.zzqa.pojo.project.Project;
import com.zzqa.pojo.seal.Seal;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.task_conflict.Task_conflict;
import com.zzqa.pojo.task_updateflow.Task_updateflow;
import com.zzqa.pojo.vehicle.Vehicle;
import com.zzqa.pojo.work.Work;
import com.zzqa.pojo.work_day.Work_day;
import com.zzqa.pojo.workday_project.Workday_project;
import com.zzqa.service.interfaces.aftersales_task.Aftersales_taskManager;
import com.zzqa.service.interfaces.file_path.File_pathManager;
import com.zzqa.service.interfaces.flow.FlowManager;
import com.zzqa.service.interfaces.linkman.LinkmanManager;
import com.zzqa.service.interfaces.operation.OperationManager;
import com.zzqa.service.interfaces.position_user.Position_userManager;
import com.zzqa.service.interfaces.seal.SealManager;
import com.zzqa.service.interfaces.task.TaskManager;
import com.zzqa.service.interfaces.task_conflict.Task_conflictManager;
import com.zzqa.service.interfaces.task_updateflow.Task_updateflowManager;
import com.zzqa.service.interfaces.user.UserManager;
import com.zzqa.service.interfaces.vehicle.VehicleManager;
import com.zzqa.service.interfaces.work.WorkManager;

public class NewFlowServlet extends HttpServlet {
	private Aftersales_taskManager aftersales_taskManager;
	private File_pathManager file_pathManager;
	private FlowManager flowManager;
	private OperationManager operationManager;
	private Position_userManager position_userManager;
	private UserManager userManager;
	private SealManager sealManager;
	private VehicleManager vehicleManager;
	private WorkManager workManager;
	private TaskManager taskManager;
	private LinkmanManager linkmanManager;
	private Task_conflictManager task_conflictManager;
	private Task_updateflowManager task_updateflowManager;
	private static final ReadWriteLock lock13= new ReentrantReadWriteLock(false);
	private static final ReadWriteLock lock14 = new ReentrantReadWriteLock(false);
	private static final ReadWriteLock lock15= new ReentrantReadWriteLock(false);
	private static final ReadWriteLock lock16 = new ReentrantReadWriteLock(false);
	private static final ReadWriteLock lock17 = new ReentrantReadWriteLock(false);
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String type = req.getParameter("type");
		HttpSession session=req.getSession();
		Object uidObject=session.getAttribute("uid");
		if(uidObject==null){
			resp.sendRedirect("login.jsp");
			return;
		}
		String sessionID=session.getId();
		int uid=((Integer)uidObject);
		String time_str=req.getParameter("file_time");
		long save_time=0l;
		if(time_str!=null){
			try {
				save_time=Long.parseLong(time_str);
			} catch (Exception e) {
				// TODO: handle exception
				save_time=0l;
			}
		}
		if("addaftersales_task".equals(type)){
			try {
				String project_id=req.getParameter("project_id");
				String project_name=req.getParameter("project_name");
				int project_case=Integer.parseInt(req.getParameter("project_case"));
				int project_category=Integer.parseInt(req.getParameter("project_category"));
				int product_type=Integer.parseInt(req.getParameter("product_type"));
				Aftersales_task aftersales_task=new Aftersales_task();
				long nowTime=System.currentTimeMillis();
				aftersales_task.setProject_id(project_id);
				aftersales_task.setProject_name(project_name);
				aftersales_task.setCreate_id(uid);
				aftersales_task.setProject_case(project_case);
				aftersales_task.setProduct_type(product_type);
				aftersales_task.setProject_category(project_category);
				aftersales_task.setCreate_time(nowTime);
				aftersales_task.setUpdate_time(nowTime);
				int aftersales_tid=aftersales_taskManager.insertAlterSales_Task(aftersales_task);
				Flow flow=new Flow();
				flow.setCreate_time(nowTime);
				flow.setForeign_id(aftersales_tid);
				flow.setOperation(1);
				flow.setUid(uid);
				flow.setType(13);
				flowManager.insertFlow(flow);
				Operation operation=new Operation();
				operation.setContent("创建售后任务单id："+aftersales_tid);
				operation.setCreate_time(nowTime);
				operation.setUid(uid);
				operationManager.insertOperation(operation);
				session.setAttribute("aftersales_tid", aftersales_tid);
				file_pathManager.saveFile(uid, sessionID, 13, aftersales_tid, 1, 0, save_time);
				resp.sendRedirect("flowmanager/aftersalestaskflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
			}
		}else if("task_updateflow".equals(type)){
			String reason=req.getParameter("reason");
			int foreign_id=Integer.parseInt(req.getParameter("task_id")==null?"0":req.getParameter("task_id"));
			long nowTime=System.currentTimeMillis();
			Task_updateflow task_updateflow = new Task_updateflow();
			task_updateflow.setCreate_id(uid);
			task_updateflow.setForeign_id(foreign_id);
			task_updateflow.setCreate_time(nowTime);
			task_updateflow.setUpdate_time(nowTime);
			int task_updateflow_id = task_updateflowManager.insertTask_updateflow(task_updateflow);
			Flow flow=new Flow();
			flow.setCreate_time(nowTime);
			flow.setForeign_id(task_updateflow_id);
			flow.setOperation(1);
			flow.setUid(uid);
			flow.setType(21);
			flow.setReason(reason);
			flowManager.insertFlow(flow);
			Operation operation=new Operation();
			operation.setContent("创建提前启动任务单修改单id："+task_updateflow_id);
			operation.setCreate_time(nowTime);
			operation.setUid(uid);
			operationManager.insertOperation(operation);
			session.setAttribute("task_id", foreign_id);
			session.setAttribute("task_updateflow_id", task_updateflow_id);
			resp.sendRedirect("flowmanager/task_updateflow.jsp");
		}else if("aftersales_task".equals(type)){
			try {
				lock13.writeLock().lock();
				int opera=Integer.parseInt(req.getParameter("operation"));
				int aftersales_tid=(Integer)session.getAttribute("aftersales_tid");
				Flow flow=flowManager.getNewFlowByFID(13, aftersales_tid);
				Aftersales_task aftersales_task=aftersales_taskManager.getAlterSales_TaskByID(aftersales_tid);
				if(aftersales_task==null||flow==null||flow.getOperation()!=opera){
					resp.sendRedirect("flowmanager/aftersalestaskflow_detail.jsp");
					return;
				}
				String reason=req.getParameter("reason");
				int isagree=Integer.parseInt(req.getParameter("isagree"));
				long nowTime=System.currentTimeMillis();
				Flow nowFlow=new Flow();
				nowFlow.setCreate_time(nowTime);
				nowFlow.setForeign_id(aftersales_tid);
				nowFlow.setType(13);
				nowFlow.setUid(uid);
				nowFlow.setReason(reason);
				Operation operation=new Operation();
				operation.setCreate_time(nowTime);
				operation.setUid(uid);
				int addfile=Integer.parseInt(req.getParameter("addfile"));//-0：鉴别修改文件 1：确认 2：审批;3:挂起
				if(opera==1){
					if(addfile==2){
						if(isagree==0){
							nowFlow.setOperation(2);
							operation.setContent("售后任务单id："+aftersales_tid+"现场服务负责人审批通过<br/>理由："+reason);
						}else{
							nowFlow.setOperation(3);
							operation.setContent("售后任务单id："+aftersales_tid+"现场服务负责人审批不予通过<br/>理由："+reason);
						}
						flowManager.insertFlow(nowFlow);
					}else{
						resp.sendRedirect("flowmanager/aftersalestaskflow_detail.jsp");
						return;
					}
				}else if(opera==2){
					if(addfile==0){//步骤4完成后->流程修改,回到步骤1->在
						String delFileIDs=req.getParameter("delFileIDs")+"の";//被删除的文件的id  の1の2の3の4の5の
						Flow flow4=flowManager.getFlowByOperation(13, aftersales_tid, 4);
						nowFlow.setOperation(4);
						flowManager.insertFlow(nowFlow);
						Flow nowFlow4=flowManager.getFlowByOperation(13, aftersales_tid, 4);
						if(flow4!=null){
							List<File_path> file_path4=file_pathManager.getAllFileByCondition(13, flow4.getId(), 1, 1);
							for (File_path file_path : file_path4) {
								file_pathManager.delFileByID(file_path.getId());
								if(delFileIDs.indexOf("の"+file_path.getId()+"の")==-1){
									//文件未被删除
									file_path.setForeign_id(nowFlow4.getId());
									file_pathManager.insertFile(file_path);
								}
							}
							operation.setContent("售后任务单id："+aftersales_tid+"现场服务助理确认并修改附件");
						}else{
							operation.setContent("售后任务单id："+aftersales_tid+"现场服务助理确认并上传附件");
						}
						file_pathManager.saveFile(uid, sessionID, 13, nowFlow4.getId(), 1, 1, save_time);
					}else{
						resp.sendRedirect("flowmanager/aftersalestaskflow_detail.jsp");
						return;
					}
				}else if(opera==3){
					if(addfile==2){
						//审批
						nowFlow.setOperation(2);
						flowManager.insertFlow(nowFlow);
						operation.setContent("售后任务单id："+aftersales_tid+"现场服务负责人审批通过<br/>理由："+reason);
					}else{
						resp.sendRedirect("flowmanager/aftersalestaskflow_detail.jsp");
						return;
					}
				}else if(opera==4){
					if(addfile==0){
						//上一步修改文件
						String delFileIDs=req.getParameter("delFileIDs")+"の";//被删除的文件的id  の1の2の3の4の5の
						Flow flow4=flowManager.getFlowByOperation(13, aftersales_tid, 4);
						flowManager.deleteRecentOperat(13, aftersales_tid, 4);//删除最新一步（未审批前修改附件的记录只保留一条，修改任务单除外）
						nowFlow.setOperation(4);
						flowManager.insertFlow2(nowFlow);//仅修改时不重复发邮件
						if(flow4!=null){
							List<File_path> file_path4=file_pathManager.getAllFileByCondition(13, flow4.getId(), 1, 1);
							file_pathManager.delAllFileByCondition(13, flow4.getId(), 1, 1);
							for (File_path file_path : file_path4) {
								if(delFileIDs.indexOf("の"+file_path.getId()+"の")==-1){
									//文件未被删除
									file_path.setForeign_id(nowFlow.getId());
									file_pathManager.insertFile(file_path);
								}
							}
						}
						operation.setContent("售后任务单id："+aftersales_tid+"现场服务助理确认并修改附件");
						file_pathManager.saveFile(uid, sessionID, 13, nowFlow.getId(), 1, 1, save_time);
					}else if(addfile==1){
						//确认
						operation.setContent("售后任务单id："+aftersales_tid+"任务完成情况确认");
						nowFlow.setOperation(5);
						flowManager.insertFlow(nowFlow);
						file_pathManager.saveFile(uid, sessionID, 13, nowFlow.getId(), 2, 1, save_time);
					}else if(addfile==3){
						//挂起
						operation.setContent("售后任务单id："+aftersales_tid+"挂起");
						nowFlow.setOperation(10);
						flowManager.insertFlow(nowFlow);
						file_pathManager.saveFile(uid, sessionID, 13, nowFlow.getId(), 2, 1, save_time);
					}else{
						resp.sendRedirect("flowmanager/aftersalestaskflow_detail.jsp");
						return;
					}
				}else if(opera==5){
					if(addfile==0){
						nowFlow.setOperation(6);
						flowManager.insertFlow(nowFlow);
						Flow nowFlow6=flowManager.getFlowByOperation(13, aftersales_tid, 6);
						operation.setContent("售后任务单id："+aftersales_tid+"上传任务记录");
						file_pathManager.saveFile(uid, sessionID, 13, nowFlow6.getId(), 1, 1, save_time);
					}else{
						resp.sendRedirect("flowmanager/aftersalestaskflow_detail.jsp");
						return;
					}
				}else if(opera==6){
					if(addfile==0){
						//修改文件
						String delFileIDs=req.getParameter("delFileIDs")+"の";//被删除的文件的id  の1の2の3の4の5の
						Flow flow6=flowManager.getFlowByOperation(13, aftersales_tid, 6);
						flowManager.deleteRecentOperat(13, aftersales_tid, 6);//删除最新一步（未审批前修改附件的记录只保留一条，修改任务单除外）
						nowFlow.setOperation(6);
						flowManager.insertFlow2(nowFlow);//仅修改时不重复发邮件
						Flow nowFlow6=flowManager.getFlowByOperation(13, aftersales_tid, 6);
						if(flow6!=null){
							List<File_path> file_path4=file_pathManager.getAllFileByCondition(13, flow6.getId(), 1, 1);
							for (File_path file_path : file_path4) {
								file_pathManager.delFileByID(file_path.getId());
								if(delFileIDs.indexOf("の"+file_path.getId()+"の")==-1){
									//文件未被删除
									file_path.setForeign_id(nowFlow6.getId());
									file_pathManager.insertFile(file_path);
								}
							}
						}
						operation.setContent("售后任务单id："+aftersales_tid+"修改任务记录");
						file_pathManager.saveFile(uid, sessionID, 13, nowFlow6.getId(), 1, 1, save_time);
					}else if(addfile==2){
						//审批
						if(isagree==0){
							nowFlow.setOperation(7);
							operation.setContent("售后任务单id："+aftersales_tid+"任务完成情况审批通过<br/>理由："+reason);
						}else{
							nowFlow.setOperation(8);
							operation.setContent("售后任务单id："+aftersales_tid+"任务完成情况审批不予通过<br/>理由："+reason);
						}
						flowManager.insertFlow(nowFlow);
					}else{
						resp.sendRedirect("flowmanager/aftersalestaskflow_detail.jsp");
						return;
					}
				}else if(opera==8){
					if(addfile==0){
						//修改文件
						String delFileIDs=req.getParameter("delFileIDs")+"の";//被删除的文件的id  の1の2の3の4の5の
						Flow flow6=flowManager.getFlowByOperation(13, aftersales_tid, 6);
						nowFlow.setOperation(6);
						flowManager.insertFlow(nowFlow);
						Flow nowFlow6=flowManager.getFlowByOperation(13, aftersales_tid, 6);
						if(flow6!=null){
							List<File_path> file_path4=file_pathManager.getAllFileByCondition(13, flow6.getId(), 1, 1);
							for (File_path file_path : file_path4) {
								if(delFileIDs.indexOf("の"+file_path.getId()+"の")==-1){
									//文件未被删除
									file_path.setForeign_id(nowFlow6.getId());
									file_pathManager.insertFile(file_path);
								}
							}
						}
						operation.setContent("售后任务单id："+aftersales_tid+"修改任务记录");
						file_pathManager.saveFile(uid, sessionID, 13, nowFlow6.getId(), 1, 1, save_time);
					}else if(addfile==2){
						//审批
						if(isagree==0){
							nowFlow.setOperation(7);
							operation.setContent("售后任务单id："+aftersales_tid+"任务完成情况审批通过<br/>理由："+reason);
							flowManager.insertFlow(nowFlow);
						}else{
							resp.sendRedirect("flowmanager/aftersalestaskflow_detail.jsp");
							return;
						}
					}else{
						resp.sendRedirect("flowmanager/aftersalestaskflow_detail.jsp");
						return;
					}
				}else if(opera==10){
					if(addfile==1){
						operation.setContent("售后任务单id："+aftersales_tid+"任务完成情况确认");
						nowFlow.setOperation(5);
						flowManager.insertFlow(nowFlow);
						file_pathManager.saveFile(uid, sessionID, 13, nowFlow.getId(), 2, 1, save_time);
					}
					if(addfile==2){
						operation.setContent("售后任务单id："+aftersales_tid+"任务完成情况确认");
						nowFlow.setOperation(10);
						flowManager.insertFlow(nowFlow);
						file_pathManager.saveFile(uid, sessionID, 13, nowFlow.getId(), 2, 1, save_time);
					}
				}else{
					resp.sendRedirect("flowmanager/aftersalestaskflow_detail.jsp");
					return;
				}
				aftersales_task.setUpdate_time(nowTime);
				aftersales_taskManager.updateAlterSales_Task(aftersales_task);
				operationManager.insertOperation(operation);
				resp.sendRedirect("flowmanager/aftersalestaskflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
			}finally{
				lock13.writeLock().unlock();
			}
		}else if("alteraftersales_task".equals(type)){
			try {
				lock13.writeLock().lock();
				int opera=Integer.parseInt(req.getParameter("operation"));
				int aftersales_tid=(Integer)session.getAttribute("aftersales_tid");
				Flow flow=flowManager.getNewFlowByFID(13, aftersales_tid);
				Aftersales_task aftersales_task=aftersales_taskManager.getAlterSales_TaskByID(aftersales_tid);
				if(flow==null||aftersales_task==null||flow.getOperation()!=opera||(opera!=1&&opera!=3)){
					resp.sendRedirect("flowmanager/aftersalestaskflow_detail.jsp");
					return;
				}
				String project_id=req.getParameter("project_id");
				String project_name=req.getParameter("project_name");
				int project_case=Integer.parseInt(req.getParameter("project_case"));
				int project_category=Integer.parseInt(req.getParameter("project_category"));
				int product_type=Integer.parseInt(req.getParameter("product_type"));
//				if(aftersales_task==null){
//					resp.sendRedirect("login.jsp");
//					return;
//				}
				long nowTime=System.currentTimeMillis();
				aftersales_task.setProject_id(project_id);
				aftersales_task.setProject_name(project_name);
				aftersales_task.setProduct_type(product_type);
				aftersales_task.setProject_case(project_case);
				aftersales_task.setProject_category(project_category);
				aftersales_task.setUpdate_time(nowTime);
				aftersales_taskManager.updateAlterSales_Task(aftersales_task);
				String delFileIDs=req.getParameter("delFileIDs")+"の";//被删除的文件的id  の1の2の3の4の5の
				List<File_path> file_paths=file_pathManager.getAllFileByCondition(13, aftersales_tid, 1, 0);
				for (File_path file_path : file_paths) {
					if(delFileIDs.indexOf("の"+file_path.getId()+"の")!=-1){
						//文件未被删除
						file_pathManager.delFileByID(file_path.getId());
					}
				}
				file_pathManager.saveFile(uid, sessionID, 13, aftersales_tid, 1, 0, save_time);
				Flow nowFlow=new Flow();
				nowFlow.setCreate_time(nowTime);
				nowFlow.setUid(uid);
				nowFlow.setForeign_id(aftersales_tid);
				nowFlow.setOperation(0);
				nowFlow.setType(13);
				nowFlow.setReason(req.getParameter("reason"));
				flowManager.insertFlow2(nowFlow);
				nowFlow.setOperation(1);
				nowFlow.setReason(null);
				if(opera==1){
					flowManager.insertFlow2(nowFlow);//未审批前修改不发邮件
				}else{
					flowManager.insertFlow(nowFlow);
				}
				Operation operation=new Operation();
				operation.setContent("修改售后任务单id："+aftersales_tid);
				operation.setCreate_time(nowTime);
				operation.setUid(uid);
				operationManager.insertOperation(operation);
				resp.sendRedirect("flowmanager/aftersalestaskflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
			}finally{
				lock13.writeLock().unlock();
			}
		}else if("deleteAfterSalesTask".equals(type)){
			try {
				lock13.writeLock().lock();
				int opera=Integer.parseInt(req.getParameter("operation"));
				int aftersales_tid=(Integer)session.getAttribute("aftersales_tid");
				Flow flow=flowManager.getNewFlowByFID(13, aftersales_tid);
				Aftersales_task aftersales_task=aftersales_taskManager.getAlterSales_TaskByID(aftersales_tid);
				if(aftersales_task==null||flow.getOperation()!=opera){
					resp.sendRedirect("flowmanager/aftersalestaskflow_detail.jsp");
					return;
				}
				long nowTime=System.currentTimeMillis();
				Flow nowFlow=new Flow();
				nowFlow.setCreate_time(nowTime);
				nowFlow.setUid(uid);
				nowFlow.setForeign_id(aftersales_tid);
				nowFlow.setOperation(9);
				nowFlow.setType(13);
				nowFlow.setReason(req.getParameter("reason"));
				flowManager.insertFlow(nowFlow);
				Operation operation=new Operation();
				operation.setContent("撤销售后任务单id："+aftersales_tid);
				operation.setCreate_time(nowTime);
				operation.setUid(uid);
				operationManager.insertOperation(operation);
				aftersales_task.setUpdate_time(nowTime);
				aftersales_taskManager.updateAlterSales_Task(aftersales_task);
				resp.sendRedirect("flowmanager/aftersalestaskflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
			}
			finally{
				lock13.writeLock().unlock();
			}
		}else if("canaelAfterSalesTask".equals(type)){
			try {
				lock13.writeLock().lock();
				int opera=Integer.parseInt(req.getParameter("operation"));
				int aftersales_tid=(Integer)session.getAttribute("aftersales_tid");
				Flow flow=flowManager.getNewFlowByFID(13, aftersales_tid);
				if(flow.getOperation()!=opera||opera!=5){
					resp.sendRedirect("flowmanager/aftersalestaskflow_detail.jsp");
					return;
				}
				Operation operation=new Operation();
				operation.setContent("撤回售后任务单id："+aftersales_tid);
				operation.setCreate_time(System.currentTimeMillis());
				operation.setUid(uid);
				operationManager.insertOperation(operation);
				flowManager.deleteRecentOperat(13, aftersales_tid, 5);
				resp.sendRedirect("flowmanager/aftersalestaskflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
			}
			finally{
				lock13.writeLock().unlock();
			}
		}else if("addsealflow".equals(type)){
			try {
				int department=Integer.parseInt(req.getParameter("department"));
				int sealType=Integer.parseInt(req.getParameter("sealType"));
				String apply_date=req.getParameter("apply_date");
				String seal_reason=req.getParameter("seal_reason");
				String seal_user=req.getParameter("seal_user");
				int num=Integer.parseInt(req.getParameter("num"));
				Seal seal=new Seal();
				long nowTime=System.currentTimeMillis();
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy/M/d");
				seal.setCreate_id(uid);
				seal.setCreate_time(nowTime);
				seal.setUpdate_time(nowTime);
				seal.setApply_department(department);
				seal.setType(sealType);
				seal.setApply_time(sdf.parse(apply_date).getTime());
				seal.setNum(num);
				seal.setReason(seal_reason);
				seal.setSeal_user(seal_user);
				int seal_id=sealManager.insertSeal(seal);
				file_pathManager.saveFile(uid, sessionID, 14, seal_id, 1, 0, save_time);
				Flow flow=new Flow();
				flow.setUid(uid);
				flow.setCreate_time(nowTime);
				flow.setOperation(1);
				flow.setType(14);
				flow.setForeign_id(seal_id);
				flowManager.insertFlow(flow);
				Operation operation=new Operation();
				operation.setContent("提交用印申请单id："+seal_id);
				operation.setCreate_time(nowTime);
				operation.setUid(uid);
				operationManager.insertOperation(operation);
				session.setAttribute("seal_id", seal_id);
				resp.sendRedirect("flowmanager/sealflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
			}
		}else if("sealflow".equals(type)){
			try {
				lock14.writeLock().lock();
				int opera=Integer.parseInt(req.getParameter("operation"));
				int seal_id=(Integer)session.getAttribute("seal_id");
				Seal seal=sealManager.getSealByID(seal_id);
				Flow flow=flowManager.getNewFlowByFID(14, seal_id);
				if(seal==null||flow==null||flow.getOperation()!=opera){
					resp.sendRedirect("flowmanager/sealflow_detail.jsp");
					return;
				}
				int seal_type = seal.getType();
				int apply_d = seal.getApply_department();
				boolean flag=(apply_d>8 && apply_d<16 && apply_d!=14 && (seal_type==0 || seal_type==1));
				long nowTime=System.currentTimeMillis();
				Flow nowFlow=new Flow();
				nowFlow.setCreate_time(nowTime);
				nowFlow.setUid(uid);
				nowFlow.setForeign_id(seal_id);
				nowFlow.setType(14);
				Operation operation=new Operation();
				operation.setCreate_time(nowTime);
				operation.setUid(uid);
				if(opera==1){
					seal.setApprover(uid);
					boolean isagree="0".equals(req.getParameter("isagree"));
					String reason=req.getParameter("reason");
					nowFlow.setOperation(isagree?2:3);
					nowFlow.setReason(reason);
					operation.setContent("用印申请表id："+seal_id+(isagree?"审批通过。<br/>理由：":"审批不予通过。<br/>理由：")+reason);
					flowManager.insertFlow(nowFlow);
					operationManager.insertOperation(operation);
				}else if(opera==2){
					seal.setExecutor(uid);
					String reason=req.getParameter("reason");
					//公章 、和同章需要总经理审批
					if(flag){
						boolean isagree="0".equals(req.getParameter("isagree"));
						nowFlow.setOperation(isagree?6:7);
						operation.setContent("用印申请表id："+seal_id+(isagree?"审批通过。<br/>理由：":"审批不予通过。<br/>理由：")+reason);
					}else {
						nowFlow.setOperation(4);
						operation.setContent("用印申请表id："+seal_id+"确认盖章");
					}
					nowFlow.setReason(reason);
					flowManager.insertFlow(nowFlow);
					operationManager.insertOperation(operation);
				}else if(opera==6){
					seal.setExecutor(uid);
					String reason=req.getParameter("reason");
					nowFlow.setOperation(4);
					nowFlow.setReason(reason);
					operation.setContent("用印申请表id："+seal_id+"确认盖章");
					flowManager.insertFlow(nowFlow);
					operationManager.insertOperation(operation);
				}else if(opera==3){
					boolean isagree="0".equals(req.getParameter("isagree"));
					if(isagree){
						seal.setApprover(uid);
						String reason=req.getParameter("reason");
						nowFlow.setOperation(2);
						nowFlow.setReason(reason);
						operation.setContent("用印申请表id："+seal_id+"审批通过。<br/>理由："+reason);
						flowManager.insertFlow(nowFlow);
						operationManager.insertOperation(operation);
					}
				}else if(opera==7){
					boolean isagree="0".equals(req.getParameter("isagree"));
					if(isagree){
						seal.setApprover(uid);
						String reason=req.getParameter("reason");
						nowFlow.setOperation(6);
						nowFlow.setReason(reason);
						operation.setContent("用印申请表id："+seal_id+"审批通过。<br/>理由："+reason);
						flowManager.insertFlow(nowFlow);
						operationManager.insertOperation(operation);
					}
				}else{
					resp.sendRedirect("flowmanager/sealflow_detail.jsp");
					return;
				}
				seal.setUpdate_time(nowTime);
				sealManager.updateSeal(seal);
				resp.sendRedirect("flowmanager/sealflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
			}
			finally{
				lock14.writeLock().unlock();
			}
		}else if("updatesealflow".equals(type)){
			try {
				lock14.writeLock().lock();
				int opera=Integer.parseInt(req.getParameter("operation"));
				int seal_id=(Integer)session.getAttribute("seal_id");
				Seal seal=sealManager.getSealByID(seal_id);
				int sealType_before=seal.getType();//前一次的印章审批类型
				Flow flow=flowManager.getNewFlowByFID(14, seal_id);
				if(seal==null||flow==null||flow.getOperation()!=opera){
					resp.sendRedirect("flowmanager/sealflow_detail.jsp");
					return;
				}
				int department=Integer.parseInt(req.getParameter("department"));
				int sealType=Integer.parseInt(req.getParameter("sealType"));
				String apply_date=req.getParameter("apply_date");
				String seal_reason=req.getParameter("seal_reason");
				String seal_user=req.getParameter("seal_user");
				int num=Integer.parseInt(req.getParameter("num"));
				long nowTime=System.currentTimeMillis();
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy/M/d");
				seal.setUpdate_time(nowTime);
				seal.setApply_department(department);
				seal.setType(sealType);
				seal.setApply_time(sdf.parse(apply_date).getTime());
				seal.setNum(num);
				seal.setReason(seal_reason);
				seal.setSeal_user(seal_user);
				sealManager.updateSeal(seal);
				String reason=req.getParameter("reason");
				Flow nowFlow=new Flow();
				nowFlow.setCreate_time(nowTime);
				nowFlow.setUid(uid);
				nowFlow.setForeign_id(seal_id);
				nowFlow.setType(14);
				nowFlow.setOperation(0);
				nowFlow.setReason(reason);
				flowManager.insertFlow2(nowFlow);
				nowFlow.setOperation(1);
				nowFlow.setReason(null);
				/****
				 * 本流程未审批前： 
				 * 			1.修改且未改变用章类型时，不发邮件给审批者；
				 * 			2.修改用印类型，发两份邮件，（通知用印审批者审批，通知之前审批者已取消用章）。
				 * 不同意时修改：
				 * 			1未改变用章类型时，只发邮件给审批者；
				 * 			2.修改用印类型，发两份邮件，（通知用印审批者审批，通知之前审批者已取消用章）。
				 */
				if(sealType_before==sealType){
					if(opera==1){
						flowManager.insertFlow2(nowFlow);
					}else{
						flowManager.insertFlow(nowFlow);
					}
				}else{
					nowFlow.setId(sealType_before+1);//与flow_id默认值0区分，后面减去1
					flowManager.insertFlow(nowFlow);
				}
				String delFileIDs=req.getParameter("delFileIDs")+"の";//被删除的文件的id  の1の2の3の4の5の
				List<File_path> file_paths=file_pathManager.getAllFileByCondition(14, seal_id, 1, 0);
				for (File_path file_path : file_paths) {
					if(delFileIDs.indexOf("の"+file_path.getId()+"の")!=-1){
						//文件未被删除
						file_pathManager.delFileByID(file_path.getId());
					}
				}
				file_pathManager.saveFile(uid, sessionID, 14, seal_id, 1, 0, save_time);
				Operation operation=new Operation();
				operation.setCreate_time(nowTime);
				operation.setUid(uid);
				operation.setContent("修改用印申请表id："+seal_id);
				operationManager.insertOperation(operation);
				resp.sendRedirect("flowmanager/sealflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
			}
			finally{
				lock14.writeLock().unlock();
			}
		}else if("deleteSeal".equals(type)){
			try {
				lock14.writeLock().lock();
				int opera=Integer.parseInt(req.getParameter("operation"));
				int seal_id=(Integer)session.getAttribute("seal_id");
				Seal seal=sealManager.getSealByID(seal_id);
				Flow flow=flowManager.getNewFlowByFID(14, seal_id);
				if(seal==null||flow==null||flow.getOperation()!=opera){
					resp.sendRedirect("flowmanager/sealflow_detail.jsp");
					return;
				}
				long nowTime=System.currentTimeMillis();
				seal.setUpdate_time(nowTime);
				sealManager.updateSeal(seal);
				Flow nowFlow=new Flow();
				nowFlow.setCreate_time(nowTime);
				nowFlow.setUid(uid);
				nowFlow.setForeign_id(seal_id);
				nowFlow.setOperation(5);
				nowFlow.setType(14);
				nowFlow.setReason(req.getParameter("reason"));
				flowManager.insertFlow(nowFlow);
				Operation operation=new Operation();
				operation.setContent("撤销用印申请表id："+seal_id);
				operation.setCreate_time(nowTime);
				operation.setUid(uid);
				operationManager.insertOperation(operation);
				resp.sendRedirect("flowmanager/sealflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
			}
			finally{
				lock14.writeLock().unlock();
			}
		}else if("addvehicleflow".equals(type)){
			try {
				int department=Integer.parseInt(req.getParameter("department"));
				String initial_address=req.getParameter("initial_address");
				String address=req.getParameter("address");
				String vehicle_person=req.getParameter("vehicle_person");
				long starttime=Long.parseLong(req.getParameter("starttime"));
				long endtime=Long.parseLong(req.getParameter("endtime"));
				String vehicle_reason=req.getParameter("vehicle_reason");
				Vehicle vehicle=new Vehicle();
				long nowTime=System.currentTimeMillis();
				vehicle.setCreate_id(uid);
				vehicle.setCreate_time(nowTime);
				vehicle.setUpdate_time(nowTime);
				vehicle.setApply_department(department);
				vehicle.setInitial_address(initial_address);
				vehicle.setVehicle_person(vehicle_person);
				vehicle.setAddress(address);
				vehicle.setStarttime(starttime);
				vehicle.setEndtime(endtime);
				vehicle.setReason(vehicle_reason);
				int vehicle_id=vehicleManager.insertVehicle(vehicle);
				Flow flow=new Flow();
				flow.setUid(uid);
				flow.setCreate_time(nowTime);
				flow.setOperation(1);
				flow.setType(15);
				flow.setForeign_id(vehicle_id);
				flowManager.insertFlow(flow);
				Operation operation=new Operation();
				operation.setContent("提交用车申请表id："+vehicle_id);
				operation.setCreate_time(nowTime);
				operation.setUid(uid);
				operationManager.insertOperation(operation);
				session.setAttribute("vehicle_id", vehicle_id);
				resp.sendRedirect("flowmanager/vehicleflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
			}
		}else if("vehicleflow".equals(type)){
			try {
				lock15.writeLock().lock();
				int opera=Integer.parseInt(req.getParameter("operation"));
				int vehicle_id=(Integer)session.getAttribute("vehicle_id");
				Vehicle vehicle=vehicleManager.getVehicleByID(vehicle_id);
				Flow flow=flowManager.getNewFlowByFID(15, vehicle_id);
				if(vehicle==null||flow==null||flow.getOperation()!=opera){
					resp.sendRedirect("flowmanager/vehicleflow_detail.jsp");
					return;
				}
				long nowTime=System.currentTimeMillis();
				Flow nowFlow=new Flow();
				nowFlow.setCreate_time(nowTime);
				nowFlow.setUid(uid);
				nowFlow.setForeign_id(vehicle_id);
				nowFlow.setType(15);
				Operation operation=new Operation();
				operation.setCreate_time(nowTime);
				operation.setUid(uid);
				if(opera==1){
					int driver=Integer.parseInt(req.getParameter("driver"));
					String car_info=req.getParameter("car_info");
					vehicle.setApprover(uid);
					vehicle.setCar_info(car_info);
					vehicle.setDriver(driver);
//					boolean isagree="0".equals(req.getParameter("isagree"));
					String isagree = req.getParameter("isagree");
					String reason=req.getParameter("reason");
					if("0".equals(isagree)){
						nowFlow.setOperation(2);
					}else if("2".equals(isagree)){
						nowFlow.setOperation(10);
					}else{
						nowFlow.setOperation(3);
					}
					nowFlow.setReason(reason);
					nowFlow.setDriver(driver);
					operation.setContent("用车申请表id："+vehicle_id+(("0".equals(isagree) || "2".equals(isagree))?"审批通过。<br/>理由：":"审批不予通过。<br/>理由：")+reason);
					flowManager.insertFlow(nowFlow);
					operationManager.insertOperation(operation);
				}else if(opera==2 || opera==10){
					if(opera==10){
						String start_mail=req.getParameter("start_mail");
						String end_mail=req.getParameter("end_mail");
						long start_driver_time=Long.parseLong(req.getParameter("start_driver_time"));
						long end_driver_time=Long.parseLong(req.getParameter("end_driver_time"));
						vehicle.setStart_mail(start_mail);
						vehicle.setEnd_mail(end_mail);
						vehicle.setStart_driver_time(start_driver_time);
						vehicle.setEnd_driver_time(end_driver_time);
					}
					int cost_attributable=Integer.parseInt(req.getParameter("cost_attributable"));
					String mileage_used=req.getParameter("mileage_used");
					vehicle.setCost_attributable(cost_attributable);
					vehicle.setMileage_used(mileage_used);
					vehicle.setExecutor(uid);
					String remark=req.getParameter("remark");
					vehicle.setRemark(remark);
					vehicle.setExecutor(uid);
					String reason=req.getParameter("reason");
					nowFlow.setOperation(4);
					nowFlow.setReason(reason);
					operation.setContent("用车申请表id："+vehicle_id+"填写车辆信息");
					flowManager.insertFlow(nowFlow);
					operationManager.insertOperation(operation);
				}else if(opera==3){
					String isagree = req.getParameter("isagree");
					if(isagree!=null && ("0".equals(isagree) || "2".equals(isagree))){
						if("0".equals(isagree)){
							nowFlow.setOperation(2);
						}else if("2".equals(isagree)){
							nowFlow.setOperation(10);
						}
						vehicle.setApprover(uid);
						String reason=req.getParameter("reason");
						nowFlow.setReason(reason);
						operation.setContent("用车申请表id："+vehicle_id+"审批通过。<br/>理由："+reason);
						flowManager.insertFlow(nowFlow);
						operationManager.insertOperation(operation);
					}
				}else if(opera==4){
					String reason=req.getParameter("reason");
					nowFlow.setOperation(5);
					nowFlow.setReason(reason);
					operation.setContent("用车申请表id："+vehicle_id+"归还确认");
					flowManager.insertFlow(nowFlow);
					operationManager.insertOperation(operation);
				}else{
					resp.sendRedirect("flowmanager/vehicleflow_detail.jsp");
					return;
				}
				vehicle.setUpdate_time(nowTime);
				vehicleManager.updateVehicle(vehicle);
				resp.sendRedirect("flowmanager/vehicleflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
			}
			finally{
				lock15.writeLock().unlock();
			}
		}else if("updatevehicleflow".equals(type)){
			try {
				lock15.writeLock().lock();
				int opera=Integer.parseInt(req.getParameter("operation"));
				int vehicle_id=(Integer)session.getAttribute("vehicle_id");
				Vehicle vehicle=vehicleManager.getVehicleByID(vehicle_id);
				Flow flow=flowManager.getNewFlowByFID(15, vehicle_id);
				if(vehicle==null||flow==null||flow.getOperation()!=opera){
					resp.sendRedirect("flowmanager/vehicleflow_detail.jsp");
					return;
				}
				int department=Integer.parseInt(req.getParameter("department"));
				String initial_address=req.getParameter("initial_address");
				String address=req.getParameter("address");
				String vehicle_person=req.getParameter("vehicle_person");
				long starttime=Long.parseLong(req.getParameter("starttime"));
				long endtime=Long.parseLong(req.getParameter("endtime"));
				String vehicle_reason=req.getParameter("vehicle_reason");
				long nowTime=System.currentTimeMillis();
				vehicle.setUpdate_time(nowTime);
				vehicle.setApply_department(department);
				vehicle.setAddress(address);
				vehicle.setInitial_address(initial_address);
				vehicle.setVehicle_person(vehicle_person);
				vehicle.setStarttime(starttime);
				vehicle.setEndtime(endtime);
				vehicle.setReason(vehicle_reason);
				vehicleManager.updateVehicle(vehicle);
				String reason=req.getParameter("reason");
				Flow nowFlow=new Flow();
				nowFlow.setCreate_time(nowTime);
				nowFlow.setUid(uid);
				nowFlow.setForeign_id(vehicle_id);
				nowFlow.setType(15);
				nowFlow.setOperation(0);
				nowFlow.setReason(reason);
				flowManager.insertFlow2(nowFlow);
				nowFlow.setOperation(1);
				nowFlow.setReason(null);
				if(opera==1){
					flowManager.insertFlow2(nowFlow);//未审批前修改就不发邮件
				}else{
					flowManager.insertFlow(nowFlow);
				}
				Operation operation=new Operation();
				operation.setCreate_time(nowTime);
				operation.setUid(uid);
				operation.setContent("修改用车申请表id："+vehicle_id);
				operationManager.insertOperation(operation);
				resp.sendRedirect("flowmanager/vehicleflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
			}
			finally{
				lock15.writeLock().unlock();
			}
		}else if("deleteVehicle".equals(type)){
			try {
				lock15.writeLock().lock();
				int opera=Integer.parseInt(req.getParameter("operation"));
				int vehicle_id=(Integer)session.getAttribute("vehicle_id");
				Flow flow=flowManager.getNewFlowByFID(15, vehicle_id);
				Vehicle vehicle=vehicleManager.getVehicleByID(vehicle_id);
				if(flow==null||vehicle==null||flow.getOperation()!=opera){
					resp.sendRedirect("flowmanager/vehicleflow_detail.jsp");
					return;
				}
				long nowTime=System.currentTimeMillis();
				vehicle.setUpdate_time(nowTime);
				vehicleManager.updateVehicle(vehicle);
				Flow nowFlow=new Flow();
				nowFlow.setCreate_time(nowTime);
				nowFlow.setUid(uid);
				nowFlow.setForeign_id(vehicle_id);
				nowFlow.setOperation(6);
				nowFlow.setType(15);
				nowFlow.setReason(req.getParameter("reason"));
				flowManager.insertFlow(nowFlow);
				Operation operation=new Operation();
				operation.setContent("撤销用车申请表id："+vehicle_id);
				operation.setCreate_time(nowTime);
				operation.setUid(uid);
				operationManager.insertOperation(operation);
				resp.sendRedirect("flowmanager/vehicleflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
			}
			finally{
				lock15.writeLock().unlock();
			}
		}else if("addProject".equals(type)){
			int flag=0;//0：重复；其他：p_id
			String pname=req.getParameter("pname");
			if(!workManager.checkProjectByPName(pname,0)){
				Project project=new Project();
				project.setProject_name(pname);
				int p_id=workManager.insertProject(project);
				flag=p_id;
				Operation operation=new Operation();
				operation.setContent("添加项目id："+p_id);
				operation.setCreate_time(System.currentTimeMillis());
				operation.setUid(uid);
				operationManager.insertOperation(operation);
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setCharacterEncoding("UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.print(flag);  
		}else if("alterProject".equals(type)){
			int flag=0;//0：重复；其他：p_id
			String pname=req.getParameter("pname");
			int p_id=Integer.parseInt(req.getParameter("p_id"));
			if(!workManager.checkProjectByPName(pname,p_id)){
				flag=p_id;
				Project project=new Project();
				project.setProject_name(pname);
				project.setId(p_id);
				workManager.updateProject(project);
				Operation operation=new Operation();
				operation.setContent("修改项目id："+p_id);
				operation.setCreate_time(System.currentTimeMillis());
				operation.setUid(uid);
				operationManager.insertOperation(operation);
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setCharacterEncoding("UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.print(flag);  
		}else if("delProject".equals(type)){
			int p_id=Integer.parseInt(req.getParameter("p_id"));
			int flag=1;//0：删除失败；1：删除成功
			if(workManager.delProjectByID(p_id)){
				Operation operation=new Operation();
				operation.setContent("删除项目id："+p_id);
				operation.setCreate_time(System.currentTimeMillis());
				operation.setUid(uid);
				operationManager.insertOperation(operation);
			}else{
				flag=0;
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setCharacterEncoding("UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.print(flag);  
		}else if("getWorkByMonth".equals(type)){
			long workmonth=Long.parseLong(req.getParameter("workmonth"));
			int create_id=Integer.parseInt(req.getParameter("create_id"));
			Work work=workManager.getWorkByMonthAndUID(workmonth, create_id);
			session.setAttribute("workmonth", workmonth);
			JSONObject jsonObject=JSONObject.fromObject(work);
			resp.setContentType("text/json");
			resp.setCharacterEncoding("UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.print(jsonObject);
		}else if("addWorkDayProjectByMonth".equals(type)){
			try {
				//审批，添加，修改  create_id流程提交者
				long workmonth=Long.parseLong(req.getParameter("workmonth"));
				int create_id=Integer.parseInt(req.getParameter("create_id"));
				Work work=workManager.getWorkByMonthAndUID2(workmonth, create_id);
				long nowTime=System.currentTimeMillis();
				Operation operation=new Operation();
				operation.setUid(uid);
				operation.setCreate_time(nowTime);
				if(work==null){
					if(uid!=create_id){
						resp.sendRedirect("login.jsp");//报错
						return;
					}
					work=new Work();
					work.setCreate_id(uid);
					work.setCreate_time(nowTime);
					work.setUpdate_time(nowTime);
					work.setOperation(0);
					work.setWorkmonth(workmonth);
					int id=workManager.insertWork(work);
					work.setId(id);
					Flow flow=new Flow();
					flow.setCreate_time(nowTime);
					flow.setUid(uid);
					flow.setOperation(1);
					flow.setType(16);
					flow.setForeign_id(id);
					flowManager.insertFlow(flow);
					operation.setContent("创建工时统计安排表id："+id);
				}else{
					Flow flow=new Flow();
					flow.setCreate_time(nowTime);
					flow.setUid(uid);
					flow.setOperation(1);
					flow.setType(16);
					flow.setForeign_id(work.getId());
					flowManager.insertFlow2(flow);
					work.setUpdate_time(nowTime);
					workManager.updateWork(work);
					operation.setContent("修改工时统计安排表id："+work.getId());
				}
				operationManager.insertOperation(operation);
				int workday=Integer.parseInt(req.getParameter("workday"));
				Work_day work_day=workManager.getWork_dayByWIDAndWD(work.getId(),workday);
				String wdproject=req.getParameter("wdproject");
				String job_content=req.getParameter("job_content");
				String remark=req.getParameter("remark");
				if(work_day==null){
					//添加工时
					work_day=new Work_day();
					work_day.setJob_content(job_content);
					work_day.setStatus(0);
					work_day.setWorkday(workday);
					work_day.setWork_id(work.getId());
					int id=workManager.insertWork_day(work_day);
					if(id==0){
						resp.sendRedirect("flowmanager/workflow_detail.jsp");
						return;
					}else{
						work_day.setId(id);
					}
					boolean deleteWorkDay=true;//工时为全为0时，删除当天的记录
					for (String wdString : wdproject.split("い")) {
						String[] wd_project=wdString.split("の");
						float hours=Float.parseFloat(wd_project[1]);
						if(hours>0){
							deleteWorkDay=false;
							Workday_project workday_project=new Workday_project();
							workday_project.setProject_id(Integer.parseInt(wd_project[0]));
							workday_project.setWorkday_id(work_day.getId());
							workday_project.setHours(Float.parseFloat(wd_project[1]));
							workManager.insertWorkday_project(workday_project);
						}
					}
					if(deleteWorkDay){
						workManager.delWork_dayByID(work_day.getId());
					}
				}else{
					if(wdproject.length()!=0){
						workManager.delWorkday_projectByWDID(work_day.getId());
						boolean deleteWorkDay=true;//工时为全为0时，删除当天的记录
						for (String wdString : wdproject.split("い")) {
							String[] wd_project=wdString.split("の");
							float hours=Float.parseFloat(wd_project[1]);
							if(hours>0){
								deleteWorkDay=false;
								Workday_project workday_project=new Workday_project();
								workday_project.setProject_id(Integer.parseInt(wd_project[0]));
								workday_project.setWorkday_id(work_day.getId());
								workday_project.setHours(hours);
								workManager.insertWorkday_project(workday_project);
							}
						}
						if(deleteWorkDay){
							workManager.delWork_dayByID(work_day.getId());
						}else{
							work_day.setJob_content(job_content);
							work_day.setStatus(0);
							workManager.updateWork_day(work_day);
						}
					}else{
						work_day.setStatus(3);//设为有未读评论状态
						work_day.setRemark(remark);
						workManager.updateWork_day(work_day);
					}
				}
				Work work2=workManager.getWorkByMonthAndUID(workmonth, create_id);
				JSONObject jsonObject=JSONObject.fromObject(work2);
				resp.setContentType("text/json");
				resp.setCharacterEncoding("UTF-8");
		        PrintWriter out = resp.getWriter();
		        out.print(jsonObject);
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("flowmanager/workflow_detail.jsp");
			}
		}else if("workflow".equals(type)){
			try {
				lock16.writeLock().lock();
				int work_id=(Integer)session.getAttribute("work_id");
				Flow laseflow=flowManager.getNewFlowByFID(16,work_id);
				if(laseflow!=null){
					long nowTime=System.currentTimeMillis();
					String reason=req.getParameter("reason");
					Flow flow=new Flow();
					flow.setCreate_time(nowTime);
					flow.setType(16);
					flow.setUid(uid);
					flow.setReason(reason);
					flow.setForeign_id(work_id);
					Operation operation=new Operation();
					operation.setUid(uid);
					operation.setCreate_time(nowTime);
					flow.setOperation(1);
					flowManager.insertFlow2(flow);
					operation.setContent("工时统计id："+work_id+"提交审批意见");
					operationManager.insertOperation(operation);
					resp.sendRedirect("flowmanager/workflow_detail.jsp");
				}else{
					resp.sendRedirect("flowmanager/workflow_detail.jsp");
				}
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("flowmanager/workflow_detail.jsp");
			}
			finally{
				lock16.writeLock().unlock();
			}
		}else if("updateWorkStatus".equals(type)){
			int status=Integer.parseInt(req.getParameter("status"));
			int id=Integer.parseInt(req.getParameter("workday_id"));
			workManager.updateStatus(id,status);
			resp.getWriter().println();
		}else if("addstartuptaskflow".equals(type)){
			try {
				String project_name = req.getParameter("project_name");
				String project_id = req.getParameter("project_id");
				int project_case = Integer.parseInt(req.getParameter("project_case"));
				int stage = Integer.parseInt(req.getParameter("stage"));
				int project_type = Integer.parseInt(req.getParameter("project_type"));
				String customer = req.getParameter("customer");
				String linkman_user = req.getParameter("linkman_user");
				String linkman_bill = req.getParameter("linkman_bill");
				String linkman_device = req.getParameter("linkman_device");
				String delivery_time = req.getParameter("delivery_time");
				String contract_time = req.getParameter("contract_time");
				int pCategory = Integer.parseInt(req.getParameter("pCategory"));
				int productType = Integer.parseInt(req.getParameter("productType"));
				int inspection = Integer.parseInt(req.getParameter("inspection"));
				int verify = Integer.parseInt(req.getParameter("verify"));
				String description = req.getParameter("description");
				String other = req.getParameter("other").trim();
				String other2 = req.getParameter("other2").trim();
				String other3 = req.getParameter("other3").trim();
				String other4 = req.getParameter("other4").trim();
				String other5 = req.getParameter("other5").trim();
				String other6 = req.getParameter("other6").trim();
				int hasProtocol = 1;
				Task task = new Task();
				task.setType(1);//项目启动任务单
				task.setProject_name(project_name);
				task.setProject_id(project_id);
				task.setProject_case(project_case);
				task.setStage(stage);
				task.setProduct_type(productType);
				task.setProject_category(pCategory);
				task.setProject_type(project_type);
				task.setCustomer(customer);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				task.setDelivery_time(sdf.parse(delivery_time).getTime());
				task.setContract_time(sdf.parse(contract_time).getTime());
				task.setDescription(description);
				task.setInspection(inspection);
				task.setVerify(verify);
				task.setProtocol(hasProtocol);
				task.setOther(other);
				task.setIsedited(0);
				task.setCreate_id(uid);
				task.setOther2(other2);
				task.setOther3(other3);
				task.setOther4(other4);
				task.setOther5(other5);
				task.setOther6(other6);
				long time = System.currentTimeMillis();
				task.setCreate_time(time);
				task.setUpdate_time(time);
				int task_id = taskManager.insertTask(task);
				String[] linkman_userArray = linkman_user.split("い");
				for (int i = 0; i < linkman_userArray.length; i++) {
					String[] userArray = linkman_userArray[i].split("の");
					Linkman linkman = new Linkman();
					linkman.setType(17);
					linkman.setForeign_id(task_id);
					linkman.setCreate_time(time);
					linkman.setState(0);
					linkman.setLinkman(userArray[0]);
					linkman.setPhone(userArray[1]);
					linkman.setLinkman_case(1);
					linkmanManager.insertLinkman(linkman);
				}
				String[] linkman_billArray = linkman_bill.split("い");
				for (int i = 0; i < linkman_billArray.length; i++) {
					String[] userArray = linkman_billArray[i].split("の");
					Linkman linkman = new Linkman();
					linkman.setType(17);
					linkman.setForeign_id(task_id);
					linkman.setCreate_time(time);
					linkman.setState(0);
					linkman.setLinkman(userArray[0]);
					linkman.setPhone(userArray[1]);
					linkman.setLinkman_case(2);
					linkmanManager.insertLinkman(linkman);
				}
				String[] linkman_deviceArray = linkman_device.split("い");
				for (int i = 0; i < linkman_deviceArray.length; i++) {
					String[] userArray = linkman_deviceArray[i].split("の");
					Linkman linkman = new Linkman();
					linkman.setType(17);
					linkman.setForeign_id(task_id);
					linkman.setCreate_time(time);
					linkman.setState(0);
					linkman.setLinkman(userArray[0]);
					linkman.setPhone(userArray[1]);
					linkman.setLinkman_case(3);
					linkmanManager.insertLinkman(linkman);
				}
				file_pathManager.saveFile(uid, sessionID, 17, task_id, 1, 0, save_time);
				file_pathManager.saveFile(uid, sessionID, 17, task_id, 2, 0, save_time);
				file_pathManager.saveFile(uid, sessionID, 17, task_id, 3, 0, save_time);
				file_pathManager.saveFile(uid, sessionID, 17, task_id, 4, 0, save_time);
				file_pathManager.saveFile(uid, sessionID, 17, task_id, 5, 0, save_time);
				file_pathManager.saveFile(uid, sessionID, 17, task_id, 6, 0, save_time);
				file_pathManager.saveFile(uid, sessionID, 17, task_id, 7, 0, save_time);
				Operation op = new Operation();
				op.setUid(uid);
				op.setContent("创建项目启动任务单 id:" + task_id);
				op.setCreate_time(time);
				operationManager.insertOperation(op);
				Flow flow = new Flow();
				flow.setCreate_time(time);
				flow.setForeign_id(task_id);
				flow.setOperation(1);
				flow.setType(17);
				flow.setUid(uid);
				flow.setReason("");
				flowManager.insertFlow(flow);
				session.setAttribute("task_id", task_id);
				resp.sendRedirect("flowmanager/startuptaskflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				resp.sendRedirect("login.jsp");
			}
		}else if("cancleStartupTask".equals(type)){
			try {
				lock17.writeLock().lock();
				long time = System.currentTimeMillis();
				int task_id = (Integer)req.getSession().getAttribute("task_id");
				Task task = taskManager.getTaskByID(task_id);
				task.setIsedited(0);
				taskManager.updateEdited(task);
				String reason = req.getParameter("reason");
				Flow flow = new Flow();
				flow.setCreate_time(time);
				flow.setUid(uid);
				flow.setType(17);
				flow.setReason(reason);
				flow.setForeign_id(task_id);
				flow.setOperation(8);
				flowManager.insertFlow(flow);
				Operation operation = new Operation();
				operation.setContent("撤销任务单 id：" + task_id);
				operation.setCreate_time(time);
				operation.setUid(uid);
				operationManager.insertOperation(operation);
				task_conflictManager.delTask_conflictByID(task_id);
				resp.sendRedirect("flowmanager/startuptaskflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("flowmanager/startuptaskflow_detail.jsp");
			}finally{
				lock17.writeLock().unlock();
			}
		}else if("recoverStartupTask".equals(type)){
			try {
				lock17.writeLock().lock();
				long time = System.currentTimeMillis();
				int task_id = (Integer)req.getSession().getAttribute("task_id");
				flowManager.deleteRecentOperat(17, task_id, 8);// 恢复到上一步
				Operation operation = new Operation();
				operation.setContent("恢复已撤销的任务单 id：" + task_id);
				operation.setCreate_time(time);
				operation.setUid(uid);
				operationManager.insertOperation(operation);
				resp.sendRedirect("flowmanager/startuptaskflow_detail.jsp");
			} catch (Exception e) {
				resp.sendRedirect("flowmanager/startuptaskflow_detail.jsp");
			} finally {
				lock17.writeLock().unlock();
			}
		}else if("verifystartuptaskflow".equals(type)){
			try {
				lock17.writeLock().lock();
				
				int task_id = (Integer)req.getSession().getAttribute("task_id");
				int operation = flowManager.getNewFlowByFID(17, task_id)
						.getOperation();
				int opera = Integer.parseInt(req.getParameter("operation"));
				if (opera != operation) {
					session.setAttribute("task_id", task_id);
					resp.sendRedirect("flowmanager/startuptaskflow_detail.jsp");
					return;
				}
				String applyState=req.getParameter("isagree");
				boolean isagree="0".equals(applyState);
				String reason = req.getParameter("reason");
				Flow flow = new Flow();
				flow.setUid(uid);
				flow.setCreate_time(System.currentTimeMillis());
				flow.setForeign_id(task_id);
				flow.setType(17);
				flow.setReason(reason);
				long time = System.currentTimeMillis();
				Operation op = new Operation();
				op.setUid(uid);
				op.setCreate_time(time);
				String fids_del=req.getParameter("fids_del");
				if(fids_del!=null&&fids_del.length()>0){
					StringTokenizer stringTokenizer=new StringTokenizer(fids_del, "の");
					while (stringTokenizer.hasMoreTokens()) {
						int fid=Integer.parseInt(stringTokenizer.nextToken());
						file_pathManager.delFileByID(fid);
					}
				}
				if (operation == 1) {
					if(isagree){
						flow.setOperation(2);
						op.setContent("任务单 id:" + task_id + "技术负责人审核通过<br/>理由："
								+ reason);
					}else{
						flow.setOperation(3);
						op.setContent("任务单 id:" + task_id + "技术负责人审核不予通过<br/>理由："
								+ reason);
					}
				}else if(operation==2){
					if(isagree){
						flow.setOperation(4);
						op.setContent("任务单 id:" + task_id + "部门经理审核通过<br/>理由："
								+ reason);
					}else{
						flow.setOperation(5);
						op.setContent("任务单 id:" + task_id + "部门经理审核不予通过<br/>理由："
								+ reason);
					}
				}else if(operation==3){
					if(isagree){
						flow.setOperation(2);
						op.setContent("任务单 id:" + task_id + "技术负责人审核通过<br/>理由："
								+ reason);
					}else{
						resp.sendRedirect("flowmanager/startuptaskflow_detail.jsp");
						return;
					}
				}else if(operation==4){
					if(isagree){
						Task task=taskManager.getTaskByID(task_id);
						if(task==null){
							resp.sendRedirect("flowmanager/startuptaskflow_detail.jsp");
							return;
						}
						flow.setOperation(task.getStage()==4?10:7);
						flowManager.finishFlow(17, task_id);
						op.setContent("任务单 id:" + task_id + "总经理审核通过<br/>理由："
								+ reason);
					}else{
						flow.setOperation(6);
						op.setContent("任务单 id:" + task_id + "总经理审核不予通过<br/>理由："
								+ reason);
					}
				}else if(operation==5){
					if(isagree){
						flow.setOperation(4);
						op.setContent("任务单 id:" + task_id + "部门经理审核通过<br/>理由："
								+ reason);
					}else{
						resp.sendRedirect("flowmanager/startuptaskflow_detail.jsp");
						return;
					}
				}else if(operation==6){
					if(isagree){
						Task task=taskManager.getTaskByID(task_id);
						if(task==null){
							resp.sendRedirect("flowmanager/startuptaskflow_detail.jsp");
							return;
						}
						flow.setOperation(task.getStage()==4?10:7);
						flowManager.finishFlow(17, task_id);
						op.setContent("任务单 id:" + task_id + "总经理审核通过<br/>理由："
								+ reason);
					}else{
						resp.sendRedirect("flowmanager/startuptaskflow_detail.jsp");
						return;
					}
				}else if(operation==10){
					flow.setOperation(11);
					file_pathManager.saveFile(uid, sessionID, 17, task_id, 8, 0, save_time);
					op.setContent("任务单 id:" + task_id + "上传合同");
				}else if(operation==11){
					if(isagree){
						flow.setOperation(9);
						op.setContent("任务单 id:" + task_id + "合同审核通过<br/>理由："+ reason);
					}else{
						flow.setOperation(12);
						op.setContent("任务单 id:" + task_id + "合同审核不予通过<br/>理由："+ reason);
					}
				}else if(operation==12){
					if(applyState.charAt(0)=='3'){
						//修改上传
						flow.setOperation(11);
						file_pathManager.saveFile(uid, sessionID, 17, task_id, 8, 0, save_time);
						op.setContent("任务单 id:" + task_id + "上传合同");
					}else if(isagree){
						flow.setOperation(9);
						op.setContent("任务单 id:" + task_id + "合同审核通过<br/>理由："+ reason);
					}else{
						resp.sendRedirect("flowmanager/startuptaskflow_detail.jsp");
						return;
					}
				}else{
					resp.sendRedirect("flowmanager/startuptaskflow_detail.jsp");
					return;
				}
				operationManager.insertOperation(op);
				flowManager.insertFlow(flow);
				resp.sendRedirect("flowmanager/startuptaskflow_detail.jsp");
			} catch (Exception e) {
				e.printStackTrace();
				resp.sendRedirect("flowmanager/startuptaskflow_detail.jsp");
			} finally {
				lock17.writeLock().unlock();
			}
		}else if("alertstartuptaskflow".equals(type)){
			try {
				lock17.writeLock().lock();
				int task_id = (Integer)req.getSession().getAttribute("task_id");
				int pCategory = Integer.parseInt(req.getParameter("pCategory"));
				int productType = Integer.parseInt(req.getParameter("productType"));
				String project_name = req.getParameter("project_name");
				String project_id = req.getParameter("project_id");
				int project_case = Integer.parseInt(req.getParameter("project_case"));
				int stage = Integer.parseInt(req.getParameter("stage"));
				int project_type = Integer.parseInt(req.getParameter("project_type"));
				String customer = req.getParameter("customer");
				String linkman_user = req.getParameter("linkman_user");
				String linkman_bill = req.getParameter("linkman_bill");
				String linkman_device = req.getParameter("linkman_device");
				String delivery_time = req.getParameter("delivery_time");
				String contract_time = req.getParameter("contract_time");
				int inspection = Integer.parseInt(req.getParameter("inspection"));
				int verify = Integer.parseInt(req.getParameter("verify"));
				String description = req.getParameter("description");
				String other = req.getParameter("other");
				String other2 = req.getParameter("other2");
				String other3 = req.getParameter("other3");
				String other4 = req.getParameter("other4");
				String other5 = req.getParameter("other5");
				String other6 = req.getParameter("other6");
				String remarks = req.getParameter("remarks");
				String reason = req.getParameter("reason");
				String delFids = req.getParameter("delFids");
				Task task=taskManager.getTaskByID(task_id);
				Flow flow = flowManager.getNewFlowByFID(17, task_id);
				if(flow==null||task==null){
					resp.sendRedirect("login.jsp");
					return;
				}
				long nowTime = System.currentTimeMillis();
				List<File_path> fileList= file_pathManager
						.getAllFileByCondition(17, task_id, 0, 0);
				int operation=flow.getOperation();
				if(operation>1){
					Task_conflict task_conflict = task_conflictManager
							.getTask_conflictByTaskID(task_id);
					task_conflict.setTask_id(task_id);
					task_conflict.setProject_category(task
							.getProject_category());
					task_conflict.setProduct_type(task.getProduct_type());
					task_conflict.setProject_name(task.getProject_name());
					task_conflict.setProject_id(task.getProject_id());
					task_conflict.setProject_case(task.getProject_case());
					task_conflict.setStage(task.getStage());
					task_conflict.setProject_type(task.getProject_type());
					task_conflict.setCustomer(task.getCustomer());
					task_conflict.setDelivery_time(task.getDelivery_time());
					task_conflict.setContract_time(task.getContract_time());
					task_conflict.setDescription(task.getDescription());
					task_conflict.setInspection(task.getInspection());
					task_conflict.setVerify(task.getVerify());
					task_conflict.setProtocol(task.getProtocol());
					task_conflict.setOther(task.getOther());
					task_conflict.setOther2(task.getOther2());
					task_conflict.setOther3(task.getOther3());
					task_conflict.setOther4(task.getOther4());
					task_conflict.setOther5(task.getOther5());
					task_conflict.setOther6(task.getOther6());
					task_conflict.setRemarks(task.getRemarks());
					task_conflictManager.updateTask_conflict(task_conflict);
					task.setIsedited(1);
					linkmanManager.deleteLinkmanLimit(17, task_id, 0, 1);
					List<Linkman> linkList = linkmanManager
							.getLinkmanListLimit(17, task_id, 0, 0);
					for (Linkman linkman : linkList) {
						linkman.setState(1);
						linkmanManager.updateLinkman(linkman);
					}
					file_pathManager.delAllFileByCondition(17, task_id, 0, 1);
					for (File_path file_path : fileList) {
						// 在对比任务单中备份文件记录
						file_path.setState(1);
						file_path.setCreate_time(nowTime);
						file_pathManager.insertFile(file_path);
					}
				}
				task.setProject_category(pCategory);
				task.setProduct_type(productType);
				task.setProject_name(project_name);
				task.setProject_id(project_id);
				task.setProject_case(project_case);
				task.setStage(stage);
				task.setProject_type(project_type);
				task.setCustomer(customer);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				task.setDelivery_time(sdf.parse(delivery_time).getTime());
				task.setContract_time(sdf.parse(contract_time).getTime());
				task.setDescription(description);
				task.setInspection(inspection);
				task.setVerify(verify);
				task.setOther(other);
				task.setOther2(other2);
				task.setOther3(other3);
				task.setOther4(other4);
				task.setOther5(other5);
				task.setOther6(other6);
				task.setRemarks(remarks);
				task.setCreate_id(uid);
				task.setUpdate_time(nowTime);
				taskManager.updateTask(task);
				linkmanManager.deleteLinkmanLimit(17, task_id, 0, 0);
				String[] linkman_userArray = linkman_user.split("い");
				for (int i = 0; i < linkman_userArray.length; i++) {
					String[] userArray = linkman_userArray[i].split("の");
					Linkman linkman = new Linkman();
					linkman.setType(17);
					linkman.setForeign_id(task_id);
					linkman.setCreate_time(nowTime);
					linkman.setState(0);
					linkman.setLinkman(userArray[0]);
					linkman.setPhone(userArray[1]);
					linkman.setLinkman_case(1);
					linkmanManager.insertLinkman(linkman);
				}
				String[] linkman_billArray = linkman_bill.split("い");
				for (int i = 0; i < linkman_billArray.length; i++) {
					String[] userArray = linkman_billArray[i].split("の");
					Linkman linkman = new Linkman();
					linkman.setType(17);
					linkman.setForeign_id(task_id);
					linkman.setCreate_time(nowTime);
					linkman.setState(0);
					linkman.setLinkman(userArray[0]);
					linkman.setPhone(userArray[1]);
					linkman.setLinkman_case(2);
					linkmanManager.insertLinkman(linkman);
				}
				String[] linkman_deviceArray = linkman_device.split("い");
				for (int i = 0; i < linkman_deviceArray.length; i++) {
					String[] userArray = linkman_deviceArray[i].split("の");
					Linkman linkman = new Linkman();
					linkman.setType(17);
					linkman.setForeign_id(task_id);
					linkman.setCreate_time(nowTime);
					linkman.setState(0);
					linkman.setLinkman(userArray[0]);
					linkman.setPhone(userArray[1]);
					linkman.setLinkman_case(3);
					linkmanManager.insertLinkman(linkman);
				}
				String[] delFidArray = delFids.split("の");
				if(delFids.length()>0){
					for(String fid:delFidArray){
						file_pathManager.delFileByID(Integer.parseInt(fid));
					}
				}
				if (reason != null && reason.length() > 0) {
					Flow flow_reason = new Flow();
					flow_reason.setUid(uid);
					flow_reason.setCreate_time(nowTime);
					flow_reason.setForeign_id(task_id);
					flow_reason.setType(17);
					flow_reason.setReason(reason);
					flowManager.insertFlow2(flow_reason);
				}
				file_pathManager.saveFile(uid, sessionID, 17, task_id, 1, 0, save_time);
				file_pathManager.saveFile(uid, sessionID, 17, task_id, 2, 0, save_time);
				file_pathManager.saveFile(uid, sessionID, 17, task_id, 3, 0, save_time);
				file_pathManager.saveFile(uid, sessionID, 17, task_id, 4, 0, save_time);
				file_pathManager.saveFile(uid, sessionID, 17, task_id, 5, 0, save_time);
				file_pathManager.saveFile(uid, sessionID, 17, task_id, 6, 0, save_time);
				file_pathManager.saveFile(uid, sessionID, 17, task_id, 7, 0, save_time);
				Operation op = new Operation();
				op.setUid(uid);
				op.setContent("修改任务单 id:" + task_id);
				op.setCreate_time(nowTime);
				operationManager.insertOperation(op);
				task_updateflowManager.updateTask_updateflowCount(task_id);
				Flow flow2 = new Flow();
				flow2.setType(17);
				flow2.setForeign_id(task_id);
				flow2.setCreate_time(nowTime);
				flow2.setOperation(1);
				if(operation==1){
					flowManager.insertFlow2(flow2);
				}else{
					flowManager.insertFlow(flow2);
				}
				resp.sendRedirect("flowmanager/startuptaskflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				resp.sendRedirect("flowmanager/startuptaskflow_detail.jsp");
			}finally {
				lock17.writeLock().unlock();
			}
		}else {
			req.getRequestDispatcher("/login.jsp").forward(req, resp);
		}
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String type = req.getParameter("type");
		HttpSession session=req.getSession();
		Object uidObject=session.getAttribute("uid");
		if(uidObject==null){
			resp.sendRedirect("login.jsp");
			return;
		}
//		String sessionID=session.getId();
		int uid=((Integer)uidObject);
		if("jumpToWorkByMonth".equals(type)){
			try {
				long workmonth=Long.parseLong(req.getParameter("workmonth"));
				Work work=workManager.getWorkByMonthAndUID2(workmonth, uid);
				if(work!=null){
					session.setAttribute("work_id", work.getId());
					resp.sendRedirect("flowmanager/workflow_detail.jsp");
				}else{
					session.setAttribute("workmonth", workmonth);
					resp.sendRedirect("flowmanager/create_workflow.jsp");
				}
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("flowmanager/workflow_detail.jsp");
			}
		}else if("saveAllWorkDayProject".equals(type)){
			try {
				lock16.writeLock().lock();
				int id=Integer.parseInt(req.getParameter("id"));
				Flow laseflow=flowManager.getNewFlowByFID(16,id);
				if(laseflow!=null&&laseflow.getOperation()==1){
					long nowTime=System.currentTimeMillis();
					Flow flow=new Flow();
					flow.setCreate_time(nowTime);
					flow.setType(16);
					flow.setUid(uid);
					flow.setForeign_id(id);
					flow.setOperation(2);
					flowManager.insertFlow(flow);
					Operation operation=new Operation();
					operation.setContent("工时统计id："+id+"全部提交");
					operation.setUid(uid);
					operation.setCreate_time(nowTime);
					operationManager.insertOperation(operation);
				}
				session.setAttribute("work_id", id);
				resp.sendRedirect("flowmanager/workflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("flowmanager/workflow_detail.jsp");
			}
			finally{
				lock16.writeLock().unlock();
			}
		}else {
			req.getRequestDispatcher("/login.jsp").forward(req, resp);
		}
	}

	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		file_pathManager = (File_pathManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"file_pathManager");
		flowManager = (FlowManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"flowManager");
		operationManager = (OperationManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"operationManager");
		position_userManager = (Position_userManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"position_userManager");
		userManager = (UserManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"userManager");
		aftersales_taskManager=(Aftersales_taskManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"aftersales_taskManager");
		sealManager=(SealManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"sealManager");
		vehicleManager=(VehicleManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"vehicleManager");
		workManager=(WorkManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"workManager");
		taskManager=(TaskManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean("taskManager");
		linkmanManager=(LinkmanManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean("linkmanManager");
		task_conflictManager=(Task_conflictManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean("task_conflictManager");
		task_updateflowManager=(Task_updateflowManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean("task_updateflowManager");
	}

}
