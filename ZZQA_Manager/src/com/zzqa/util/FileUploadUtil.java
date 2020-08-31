package com.zzqa.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.zzqa.pojo.file_path.File_path;
import com.zzqa.servlet.HandelTempFileServlet;
import com.zzqa.util.ant.ZipEntry;
import com.zzqa.util.ant.ZipOutputStream;

/*******************************************************************************
 * 文件上传，下载，查看，删除
 * 
 * @author louph
 * 
 */
public class FileUploadUtil {
	//保存存储位置
	private static String filePath = "D:/ZZQA_manager_File/";
	// 压缩文件
	private static String filePath3 = "D:/ZZQA_manager_File/zipFile/";
	//Excel存储位置
	private static String filePath4 = "D:/ZZQA_manager_File/excel/";

	/***************************************************************************
	 * 文件上传初始化
	 * 
	 * @return
	 */
	public static ServletFileUpload initFileUpload() {
		File uploadPath = new File(filePath);
		if (!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		File tmp = new File(filePath + "tmp/");// 大文件缓存目录
		if (!tmp.exists()) {
			tmp.mkdirs();
		}
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(tmp);
		factory.setSizeThreshold(10 * 1024);
		ServletFileUpload sfu = new ServletFileUpload(factory);
		sfu.setHeaderEncoding("UTF-8");
		sfu.setSizeMax(200 * 1024 * 1024);// 最大文件
		return sfu;
	}
	/***************************************************************************
	 * 文件上传初始化，实时上传的文件保存在临时文件夹中
	 * 
	 * @return
	 */
	public static ServletFileUpload initFileUpload2() {
		File uploadPath = new File(filePath);
		if (!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		File tmp = new File(filePath+ "tmp/");// 大文件缓存目录
		if (!tmp.exists()) {
			tmp.mkdirs();
		}
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(tmp);
		factory.setSizeThreshold(10 * 1024);
		ServletFileUpload sfu = new ServletFileUpload(factory);
		sfu.setHeaderEncoding("UTF-8");
		sfu.setSizeMax(200 * 1024 * 1024);// 最大文件
		return sfu;
	}
	/***************************************************************************
	 * 文件上传初始化，实时上传的Excel文件保存在临时文件夹中
	 * 
	 * @return
	 */
	public static ServletFileUpload initFileUpload4() {
		File uploadPath = new File(filePath4);
		if (!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		File tmp = new File(filePath4 + "tmp/");// 大文件缓存目录
		if (!tmp.exists()) {
			tmp.mkdirs();
		}
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(tmp);
		factory.setSizeThreshold(10 * 1024);
		ServletFileUpload sfu = new ServletFileUpload(factory);
		sfu.setHeaderEncoding("UTF-8");
		sfu.setSizeMax(200 * 1024 * 1024);// 最大文件
		return sfu;
	}

	public static String getFilePath() {
		return filePath;
	}
	
	public static String getZipFilePath() {
		return filePath3;
	}
	
	public static String getExcelFilePath() {
		return filePath4;
	}
	
	public static void initZipFilePath() {
		File uploadPath = new File(filePath3);
		if (!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		deleteFolder();
	}
	public static void deleteFolder() {
		File delfolder3 = new File(filePath3);
		File oldFile3[] = delfolder3.listFiles();
		try {
			if (oldFile3 != null) {
				for (int i = 0; i < oldFile3.length; i++) {
					oldFile3[i].delete();
				}
			}
		} catch (Exception e) {
			System.out.println("FileUploadUtil清空文件夹操作出错!");
			e.printStackTrace();
		}
	}
	//防止文件名重复，第二个文件加后缀（1） 如：123(1).png
	public static String getFileName(String name,String suffix,Map<String,String> map,int index){
		String filename="";
		if(index==0){
			filename=new StringBuilder().append(name).append(suffix).toString();
		}else{
			filename=new StringBuilder().append(name).append("(").append(index).append(")").append(suffix).toString();
		}
		if(map.containsKey(filename)){
			index++;
			return getFileName(name,suffix,map,index);
		}else{
			return filename;
		}
		
	}
	//压缩文件
	public static void zip(List<File_path> fiList,String zippath){
		HandelTempFileServlet.lock.writeLock().lock();
		ZipOutputStream zipout=null;
		Map<String,String> map=new HashMap<String, String>();
		try {
			zipout=new ZipOutputStream(new FileOutputStream(zippath));
			zipout.setEncoding("UTF-8");
			for(File_path file_path:fiList){
				String fileName=file_path.getFile_name();
				String name=fileName.substring(0,fileName.lastIndexOf("."));
				String suffix=fileName.substring(fileName.lastIndexOf("."));
				fileName=getFileName(name,suffix,map,0);
				map.put(fileName,null);
				
				File file=new File(getFilePath()+file_path.getPath_name());
				if(file.isFile()){
					zipout.putNextEntry(new ZipEntry(fileName));
					FileInputStream in = new FileInputStream(file);
		            try {
		                int c;
		                byte[] by = new byte[1024];
		                while ((c = in.read(by)) != -1) {
		                	zipout.write(by, 0, c);
		                }
		            } catch (IOException e) {
		            	e.printStackTrace();
		            	System.out.println("ZipOutputStream 异常！");
		            } finally {
		            	zipout.closeEntry(); 
		                in.close();
		            }
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}finally{
			HandelTempFileServlet.lock.writeLock().unlock();
			if(zipout!=null){
				try {
					zipout.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					System.out.println("ZipOutputStream close()异常！");
				}
			}
		}
	}
}
