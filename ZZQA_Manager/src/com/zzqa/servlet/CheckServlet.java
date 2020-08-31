package com.zzqa.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.support.WebApplicationContextUtils;

import com.zzqa.dao.interfaces.file_path.IFile_pathDAO;
import com.zzqa.pojo.device.Device;
import com.zzqa.pojo.file_path.File_path;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.operation.Operation;
import com.zzqa.pojo.position_user.Position_user;
import com.zzqa.pojo.task.Task;
import com.zzqa.service.interfaces.device.DeviceManager;
import com.zzqa.service.interfaces.file_path.File_pathManager;
import com.zzqa.service.interfaces.flow.FlowManager;
import com.zzqa.service.interfaces.material.MaterialManager;
import com.zzqa.service.interfaces.operation.OperationManager;
import com.zzqa.service.interfaces.position_user.Position_userManager;
import com.zzqa.service.interfaces.task.TaskManager;
import com.zzqa.util.FileUploadUtil;
/***
 * 老版本设备接口，任务单修改备注
 * @author Administrator
 *
 */
public class CheckServlet extends HttpServlet{
	private DeviceManager deviceManager;
	private MaterialManager materialManager;
	private File_pathManager file_pathManager;
	private TaskManager taskManager;
	private OperationManager operationManager;
	private Position_userManager position_userManager;
	private FlowManager flowManager;
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		resp.setCharacterEncoding("utf-8");
		String type = req.getParameter("type");//获得ajax传的值
		if("checkDID".equals(type)){
			int flag=0;//不存在
			int ID = Integer.parseInt(req.getParameter("ID"));
			if(deviceManager.getDeviceByID(ID)!=null){
				flag=1;//ID已存在
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println(flag);
			out.flush();
		}else if("delDevice".equals(type)){
			//删除设备
			int flag=0;//删除成功
			String str=req.getParameter("ID");
			int ID = Integer.parseInt(req.getParameter("ID"));
			int uid=(Integer)req.getSession().getAttribute("uid");
			List<File_path> fList=file_pathManager.getAllFileByCondition(5, ID, 1, 0);
			for(File_path file_path:fList){
				File file = new File(FileUploadUtil.getFilePath()+file_path.getPath_name());
				if (file.isFile() && file.exists()) {
					file.delete();
				}
			}
			
			Device device=deviceManager.getDeviceByID(ID);
			materialManager.delMaterialByDeviceID(ID);
			if(device!=null){
				deviceManager.delDeviceByID(ID);
				file_pathManager.delAllFileByCondition(5,ID , 1, 0);
				Operation op=new Operation();
				op.setUid(uid);
				op.setContent("删除设备，ID:"+ID);
				op.setCreate_time(System.currentTimeMillis());
				operationManager.insertOperation(op);
			}else{
				flag=1;//已被删除
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println(flag);
			out.flush();
		}else  if("alertRemarks".equals(type)){
			int task_id = (Integer)req.getSession().getAttribute("task_id");
			Task task1 = taskManager.getTaskByID(task_id);
			int operation = flowManager.getNewFlowByFID(1, task_id)
					.getOperation();
			String remarks = req.getParameter("remarks");
			int uid=(Integer)req.getSession().getAttribute("uid");
			Task task = new Task();
			task.setId(task_id);
			task.setRemarks(remarks);
			task.setUpdate_time(System.currentTimeMillis());
			taskManager.updateRemarks(task);
			Operation op=new Operation();
			op.setUid(uid);
			op.setPosition_index(1);
			op.setContent("修改任务单id:"+task_id+"的备注");
			op.setCreate_time(System.currentTimeMillis());
			operationManager.insertOperation(op);
			if(operation==23){
				flowManager.alertRemarksSendEmail(uid,task_id,task1.getProject_name());
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma","no-cache");
			resp.setHeader("cache-control","no-cache");
			PrintWriter out = resp.getWriter();
			out.println();
			out.flush();
		}
	}
	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		super.init();
		deviceManager=(DeviceManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
				"deviceManager");
		materialManager=(MaterialManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
				"materialManager");
		file_pathManager=(File_pathManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
				"file_pathManager");
		taskManager=(TaskManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
				"taskManager");
		operationManager=(OperationManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
				"operationManager");
		position_userManager=(Position_userManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
				"position_userManager");
		flowManager = (FlowManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"flowManager");
	}
}
