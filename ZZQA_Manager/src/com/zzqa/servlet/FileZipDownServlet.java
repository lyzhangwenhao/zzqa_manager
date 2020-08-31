package com.zzqa.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.context.support.WebApplicationContextUtils;
import com.zzqa.pojo.file_path.File_path;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.file_path.File_pathManager;
import com.zzqa.service.interfaces.flow.FlowManager;
import com.zzqa.service.interfaces.user.UserManager;
import com.zzqa.util.FileUploadUtil;

public class FileZipDownServlet extends HttpServlet{
	private FlowManager flowManager;
	private File_pathManager file_pathManager;
	private UserManager userManager;
	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		flowManager = (FlowManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext())
				.getBean("flowManager");
		file_pathManager = (File_pathManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext())
				.getBean("file_pathManager");
		userManager = (UserManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext())
				.getBean("userManager");
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		FileUploadUtil.initZipFilePath();
		String type=request.getParameter("type");
		int id=(Integer)request.getSession().getAttribute("task_id");
		Object uidStr=request.getSession().getAttribute("uid");
		if(uidStr==null){
			request.getRequestDispatcher("/login.jsp").forward(request,
					response);
			return;
		}
		int uid=(Integer)uidStr;
		String zippath="";
		String fileName="";
		if("1".equals(type)){
			fileName="项目任务单文件打包.zip";
			zippath=FileUploadUtil.getZipFilePath()+fileName;
			List<File_path> fileList=file_pathManager.getAllFileByCondition(1, id, 0, 0);
			User user=userManager.getUserByID(uid);
			if(!"admin".equals(user.getName())){
				Iterator iterator=fileList.iterator();
				while (iterator.hasNext()) {
					File_path file_path= (File_path) iterator.next();
					if(flowManager.checkLoadFilePermission(file_path.getId(), uid)!=1){
						iterator.remove();
					}
				}
			}
			FileUploadUtil.zip(fileList,zippath);
		}else if("17".equals(type)){
			fileName="项目启动任务单文件打包.zip";
			zippath=FileUploadUtil.getZipFilePath()+fileName;
			List<File_path> fileList=file_pathManager.getAllFileByCondition(17, id, 0, 0);
			User user=userManager.getUserByID(uid);
			if(!"admin".equals(user.getName())){
				Iterator iterator=fileList.iterator();
				while (iterator.hasNext()) {
					File_path file_path= (File_path) iterator.next();
					if(flowManager.checkLoadFilePermission(file_path.getId(), uid)!=1){
						iterator.remove();
					}
				}
			}
			FileUploadUtil.zip(fileList,zippath);
		}
		response.reset();//可以加也可以不加  
		response.setContentType("application/x-download");
		response.setCharacterEncoding("UTF-8");
		File file=new File(zippath);
		long fileLength = file.length();
		response.setContentType("application/x-download");
		response.setHeader("Content-Disposition", "attachment;filename="
				+ URLEncoder.encode(fileName,"UTF-8"));
		response.setHeader("Content-Length", URLEncoder.encode(String.valueOf(fileLength),
				"UTF-8"));
		OutputStream outp = null;
		FileInputStream in = null;
		try {
			outp = response.getOutputStream();
			in = new FileInputStream(zippath);
			byte[] b = new byte[1024];
			int i = 0;
			while ((i = in.read(b))!=-1) {
				outp.write(b, 0, i);
			}
			outp.flush();
		} catch (Exception e) {
			System.out.println("FileZipDownServlet文件读取：Error!--可忽略");
			e.printStackTrace();
		} finally {
			if (in != null) {
				in.close();
				in = null;
			} 
			if(outp != null){  
				outp.close();  
				outp = null;  
			}
		}
	}

}
