package com.zzqa.dao.interfaces.file_path;

import java.util.List;
import java.util.Map;

import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.zzqa.pojo.file_path.File_path;

public interface IFile_pathDAO {
	//检查文件是否被删除
	public boolean checkNowFileExists(File_path file_path);
	//通过id查询文件
	public File_path getFileByID(int id);
	public List getAllFileByCondition(Map map);
	public void delAllFileByCondition(Map map);
	public void delAllFileByCondition2(Map map);
	public void delFileByID(int id);
	public void insertFile(File_path file_path);
	public void updateState(File_path file_path);
	//查询最新的附件
	public File_path getNewFileByFID(int foreign_id);
	public List<File_path> getAllFileGroupByState(Map map);
	public int getMaxStateByCondition(Map map);
}
