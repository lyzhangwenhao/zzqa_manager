package com.zzqa.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.support.WebApplicationContextUtils;

import com.zzqa.pojo.file_path.File_path;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.linkman.Linkman;
import com.zzqa.pojo.operation.Operation;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.task_conflict.Task_conflict;
import com.zzqa.service.interfaces.file_path.File_pathManager;
import com.zzqa.service.interfaces.flow.FlowManager;
import com.zzqa.service.interfaces.linkman.LinkmanManager;
import com.zzqa.service.interfaces.operation.OperationManager;
import com.zzqa.service.interfaces.position_user.Position_userManager;
import com.zzqa.service.interfaces.task.TaskManager;
import com.zzqa.service.interfaces.task_conflict.Task_conflictManager;
import com.zzqa.service.interfaces.user.UserManager;
import com.zzqa.util.FileUploadUtil;

public class DeleteFileServlet extends HttpServlet {
	private UserManager userManager;
	private Position_userManager position_userManager;
	private Task_conflictManager task_conflictManager;
	private TaskManager taskManager;
	private File_pathManager file_pathManager;
	private LinkmanManager linkmanManager;
	private FlowManager flowManager;
	private OperationManager operationManager;
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String type = req.getParameter("type");
		if(req.getSession().getAttribute("uid")==null){
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println();
			out.flush();
		}
		int uid = (Integer)req.getSession().getAttribute("uid");
		if ("delTaskFile".equals(type)) {
			int id = Integer.parseInt(req.getParameter("id"));
			File_path file_path1=file_pathManager.getFileByID(id);
			int task_id=file_path1.getForeign_id();
			Task task=taskManager.getTaskByID(task_id);
			long nowTime=System.currentTimeMillis();
			int task_type=task.getType()==0?1:17;
			int operation=flowManager.getNewFlowByFID(task_type, task_id).getOperation();
			Task_conflict task_conflict1=task_conflictManager.getTask_conflictByTaskID(task_id);
			if((task_type==17&&operation>2&&operation!=7&&operation!=8)||(task_type==1&&operation>2&&operation!=5&&operation!=8&&operation!=23)){
				//一旦有人签名修改必须重新签名 已完成的不能修改
				Task_conflict task_conflict=new Task_conflict();
				task_conflict.setTask_id(task_id);
				task_conflict.setProject_category(task.getProject_category());
				task_conflict.setProduct_type(task.getProduct_type());
				task_conflict.setProject_name(task.getProject_name());
				task_conflict.setProject_id(task.getProject_id());
				task_conflict.setProject_case(task.getProject_case());
				task_conflict.setStage(task.getStage());
				task_conflict.setProject_type(task.getProject_type());
				task_conflict.setCustomer(task.getCustomer());
				task_conflict.setDelivery_time(task.getDelivery_time());
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
				task_conflict.setContract_time(task.getContract_time());
				task_conflict.setRemarks(task.getRemarks());
				task_conflictManager.updateTask_conflict(task_conflict);
				task.setIsedited(1);
				taskManager.updateEdited(task);
				linkmanManager.deleteLinkmanLimit(task_type, task_id, 0, 1);
				List<Linkman> linkList=linkmanManager.getLinkmanListLimit(task_type, task_id, 0, 0);
				for(Linkman linkman:linkList){
					linkman.setState(1);
					linkmanManager.insertLinkman(linkman);
				}
				List<File_path> fileList=file_pathManager.getAllFileByCondition(task_type, task_id, 0, 0);
				for(File_path file_path:fileList){
					file_path.setState(1);
					file_pathManager.insertFile(file_path);
				}
				Flow flow=new Flow();
				flow.setType(task_type);
				flow.setForeign_id(task_id);
				if(task_type==1){
					flow.setOperation(task.getProject_case()==0?1:2);
				}else{
					flow.setOperation(1);
				}
				flow.setCreate_time(System.currentTimeMillis());
				flowManager.insertFlow(flow);
			}else{
				if(!file_pathManager.checkNowFileExists(file_path1.getPath_name(), 1)){
					//该文件没有记录啦，可以从硬盘中删除
					File file = new File(FileUploadUtil.getFilePath()+file_path1.getPath_name());
					if (file.isFile() && file.exists()) {
						file.delete();
					}
				}
			}
			file_pathManager.delFileByID(id);
			int filenum=file_pathManager.getAllFileByCondition(task_type, task_id, 0, 0).size();
			if(filenum==0){
				Task task2=taskManager.getTaskByID(task_id);
				task2.setProtocol(1);
				taskManager.updateTask(task2);
			}
			Operation op=new Operation();
			op.setUid(uid);
			if(task_type==1){
				op.setContent("删除任务单id:"+task_id+"的一个"+(file_path1.getFile_type()==1?"供货清单":"技术附件"));
			}else{
				op.setContent("删除任务单id:"+task_id+"的一个"+(file_path1.getFile_type()==1?"项目成本核算表":"项目技术附件"));
			}
			op.setCreate_time(nowTime);
			operationManager.insertOperation(op);
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println(1);
			out.flush();
		}else if("delTaskFile2".equals(type)){
			//删除项目材料配置单，不需要改变审核流程
			int id = Integer.parseInt(req.getParameter("id"));
			File_path file_path1=file_pathManager.getFileByID(id);
			int task_id=file_path1.getForeign_id();
			File file = new File(FileUploadUtil.getFilePath()+file_path1.getPath_name());
			if (file.isFile() && file.exists()) {
				file.delete();
			}
			file_pathManager.delFileByID(id);
			Operation op=new Operation();
			op.setUid(uid);
			op.setContent("删除任务单id:"+task_id+"的一个项目材料配置单");
			op.setCreate_time(System.currentTimeMillis());
			operationManager.insertOperation(op);
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println(1);
			out.flush();
		}else if("delprojectfile".equals(type)){
			int id = Integer.parseInt(req.getParameter("id"));
			File_path file_path1=file_pathManager.getFileByID(id);
			int project_id=file_path1.getForeign_id();
			File file = new File(FileUploadUtil.getFilePath()+file_path1.getPath_name());
			if (file.isFile() && file.exists()) {
				file.delete();
			}
			file_pathManager.delFileByID(id);
			Operation op=new Operation();
			op.setUid(uid);
			op.setPosition_index(5);
			op.setContent("生产主管删除项目采购单id:"+project_id+"的一个项目采购预算表");
			op.setCreate_time(System.currentTimeMillis());
			operationManager.insertOperation(op);
			
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println(1);
			out.flush();
		}else if("delcommunicatefile".equals(type)){
			int id = Integer.parseInt(req.getParameter("id"));
			File_path file_path1=file_pathManager.getFileByID(id);
			int project_id=file_path1.getForeign_id();
			int ftype=file_path1.getType();
			File file = new File(FileUploadUtil.getFilePath()+file_path1.getPath_name());
			if (file.isFile() && file.exists()) {
				file.delete();
			}
			String str=null;
			if(ftype==21){
				str="反馈";
			}else if(ftype==22){
				str="建议";
			}else if(ftype==22){
				str="通知";
			}
			file_pathManager.delFileByID(id);
			Operation op=new Operation();
			op.setUid(uid);
			op.setContent("删除"+str+"id:"+project_id+"的附件");
			op.setCreate_time(System.currentTimeMillis());
			operationManager.insertOperation(op);
			
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println(1);
			out.flush();
		}
	}

	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		userManager = (UserManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"userManager");
		position_userManager = (Position_userManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"position_userManager");
		task_conflictManager = (Task_conflictManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"task_conflictManager");
		taskManager = (TaskManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"taskManager");
		linkmanManager=(LinkmanManager) WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext()).getBean(
				"linkmanManager");
		file_pathManager = (File_pathManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"file_pathManager");
		flowManager = (FlowManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
				"flowManager");
		operationManager=(OperationManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
				"operationManager");
	}
}
