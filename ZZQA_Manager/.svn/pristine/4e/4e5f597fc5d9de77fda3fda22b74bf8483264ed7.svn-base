package com.zzqa.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.zip.Deflater;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.support.WebApplicationContextUtils;

import com.zzqa.pojo.file_path.File_path;
import com.zzqa.pojo.position_user.Position_user;
import com.zzqa.service.interfaces.file_path.File_pathManager;
import com.zzqa.service.interfaces.position_user.Position_userManager;
import com.zzqa.util.DataUtil;
import com.zzqa.util.FileUploadUtil;
import com.zzqa.util.ant.ZipEntry;
import com.zzqa.util.ant.ZipOutputStream;

public class FileDownServlet extends HttpServlet{
	private File_pathManager file_pathManager;
	private Position_userManager position_userManager;
	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		file_pathManager = (File_pathManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext())
				.getBean("file_pathManager");
		position_userManager = (Position_userManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext())
				.getBean("position_userManager");
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String type=request.getParameter("type");
		response.reset();//可以加也可以不加  
		response.setContentType("application/x-download");
		String filedownload="";
		String filename="";
		FileInputStream in =null;
		if("loadfile".equals(type)){
			String id = request.getParameter("id");
			File_path file_path = file_pathManager.getFileByID(Integer
					.parseInt(id));
			filedownload = FileUploadUtil.getFilePath()
					+ file_path.getPath_name();
			 filename = URLEncoder.encode(file_path.getFile_name(),
						"UTF-8");//文件名称
			 in = new FileInputStream(filedownload);
		}else if("loadTempFile".equals(type)){
			int file_type=Integer.parseInt(request.getParameter("file_type"));
			filename=request.getParameter("file_name");
			filedownload=file_pathManager.getTempPath(request.getSession().getId(), file_type, filename);
			filename =  URLEncoder.encode(filename,"UTF-8");//文件名称
			in = new FileInputStream(filedownload);
		}else if("loadexcel".equals(type)){
			String filePath= request.getParameter("filePath");
			filedownload = FileUploadUtil.getExcelFilePath()+filePath;
			SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
			filename = URLEncoder.encode(DataUtil.getFlowNameArray()[Integer.parseInt(request.getParameter("flowType"))]
					+sdf.format(System.currentTimeMillis())+filePath.substring(filePath.lastIndexOf(".")),"UTF-8");//文件名称
			in = new FileInputStream(filedownload);
		}else if("loadreport".equals(type)){
			String filePath= request.getParameter("filePath");
			String year= request.getParameter("year");
			String month= request.getParameter("month");
			String flowType= request.getParameter("flowType");
			filedownload = FileUploadUtil.getExcelFilePath()+filePath;
			filename = URLEncoder.encode(year+"年"+month+"月"+(("1").equals(flowType)?"出差月报表":"请假月报表")
					+filePath.substring(filePath.lastIndexOf(".")),"UTF-8");//文件名称
			in = new FileInputStream(filedownload);
		}else if("loadtrackexcel".equals(type)){
			String filePath= request.getParameter("filePath");
			filedownload = FileUploadUtil.getExcelFilePath()+filePath;
			String work_filename=request.getParameter("filename");
			if(work_filename==null){
				filename = URLEncoder.encode("现场人员状态跟踪表"+filePath.substring(filePath.lastIndexOf(".")),"UTF-8");//文件名称
			}else{
				//工时报表
				//get方式提交的参数编码，只支持iso8859-1编码
				/*System.out.println(work_filename);
				work_filename=new String(work_filename.getBytes("iso8859-1"),"utf-8"); 
				System.out.println(work_filename);
				filename = URLEncoder.encode(work_filename+filePath.substring(filePath.lastIndexOf(".")),"UTF-8");//文件名称
				 */			
				String str=request.getQueryString();
				//使用URLDecoder解码字符串
				String str1=java.net.URLDecoder.decode(str,"utf-8");
				String[] paraStrings=str1.split("&");
				//paraStrings[0]就是第一个参数，依次类推...
				work_filename=paraStrings[2].split("=")[1];
				filename = URLEncoder.encode(work_filename+filePath.substring(filePath.lastIndexOf(".")),"UTF-8");//文件名称
			}
			in = new FileInputStream(filedownload);
		}else if("loadmaterials".equals(type)){
			String filePath= request.getParameter("filePath");
			filedownload = FileUploadUtil.getExcelFilePath()+filePath;
			filename = URLEncoder.encode("物料信息表"+filePath.substring(filePath.lastIndexOf(".")),"UTF-8");//文件名称
			in = new FileInputStream(filedownload);
		}else if("loadcustomer".equals(type)){
			String filePath= request.getParameter("filePath");
			filedownload = FileUploadUtil.getExcelFilePath()+filePath;
			filename = URLEncoder.encode(("1".equals(request.getParameter("customer_type"))?"客户资料库":"供应商资料库")+filePath.substring(filePath.lastIndexOf(".")),"UTF-8");//文件名称
			in = new FileInputStream(filedownload);
		}else if("loadfileList".equals(type)){
			String id = request.getParameter("id");
			String file_name = request.getParameter("file_name");
			String [] stringArr= id.split(",");
			response.setContentType("application/x-msdownload");
			response.setHeader("Content-Disposition", "attachment;filename="
						+ file_name+".zip");
			ZipOutputStream zos = new ZipOutputStream(response.getOutputStream());
			zos.setLevel(Deflater.NO_COMPRESSION);
			zos.setMethod(ZipOutputStream.DEFLATED);
			zos.setEncoding("GBK");
			for(String ids :stringArr){
				File_path file_path = file_pathManager.getFileByID(Integer
						.parseInt(ids));
				filedownload = FileUploadUtil.getFilePath()
						+ file_path.getPath_name();
				 filename = file_path.getFile_name();//文件名称
				File file = new File(filedownload);
				zos.putNextEntry(new ZipEntry(filename));
				FileInputStream input = new FileInputStream(file);
				byte b[]=new byte[1024];
				int a=0 ;
				while((a=input.read(b))!=-1){
				zos.write(b, 0, a);
				}
				zos.flush();
				input.close();
			}
			zos.close();
			return;
		}
		response.setContentType("application/x-download");
		response.setHeader("Content-Disposition", "attachment;filename="
				+ filename);
		response.setHeader("Content-Length", URLEncoder.encode(String.valueOf(in.available()),"UTF-8"));
		OutputStream outp = null;
		try {
			outp = response.getOutputStream();
			byte[] b = new byte[1024];
			int i = 0;
			while ((i = in.read(b))!=-1) {
				outp.write(b, 0, i);
			}
			outp.flush();
		} catch (Exception e) {
			System.out.println("FileDownServlet文件读取：Error!--可忽略");
			//e.printStackTrace();
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
