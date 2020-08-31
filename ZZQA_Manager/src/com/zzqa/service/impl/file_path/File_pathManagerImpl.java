package com.zzqa.service.impl.file_path;

import java.io.File;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.file_path.IFile_pathDAO;
import com.zzqa.pojo.file_path.File_path;
import com.zzqa.service.interfaces.file_path.File_pathManager;
import com.zzqa.servlet.HandelTempFileServlet;
import com.zzqa.util.FileUploadUtil;
@Component("file_pathManager")
public class File_pathManagerImpl implements File_pathManager {
	private Map<String, Map<String, File_path>> fileMap = new ConcurrentHashMap<String, Map<String, File_path>>();
	@Autowired
	private IFile_pathDAO file_pathDAO;

	public boolean checkNowFileExists(String path_name, int state) {
		// TODO Auto-generated method stub
		File_path file_path=new File_path();
		file_path.setPath_name(path_name);
		file_path.setState(state);
		return file_pathDAO.checkNowFileExists(file_path);
	}

	public void delAllFileByCondition(int type,int foreign_id,int file_type,int state){
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("type", type);
		map.put("foreign_id", foreign_id);
		map.put("file_type", file_type);
		map.put("state", state);
		file_pathDAO.delAllFileByCondition(map);
	}
	public void delAllFileByCondition2(int type,int foreign_id,int file_type,int state){
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("type", type);
		map.put("foreign_id", foreign_id);
		map.put("file_type", file_type);
		map.put("state", state);
		file_pathDAO.delAllFileByCondition2(map);
	}

	public void delFileByID(int id) {
		// TODO Auto-generated method stub
		file_pathDAO.delFileByID(id);
	}

	public List<File_path> getAllFileByCondition(int type,int foreign_id,int file_type,int state){
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("type", type);
		map.put("foreign_id", foreign_id);
		map.put("file_type", file_type);
		map.put("state", state);
		return file_pathDAO.getAllFileByCondition(map);
	}
	public List<File_path> getAllFileGroupByState(int type,int foreign_id,int file_type){
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("type", type);
		map.put("foreign_id", foreign_id);
		map.put("file_type", file_type);
		return file_pathDAO.getAllFileGroupByState(map);
	}
	public File_path getFileByID(int id) {
		// TODO Auto-generated method stub
		return file_pathDAO.getFileByID(id);
	}

	public void insertFile(File_path file_path) {
		// TODO Auto-generated method stub
		file_pathDAO.insertFile(file_path);
	}

	public void updateState(File_path file_path) {
		// TODO Auto-generated method stub
		file_pathDAO.updateState(file_path);
	}
	public String getTempPath(String sessionID,int file_type,String file_name){
		Map<String, File_path> map = fileMap.get(String
				.valueOf(file_type));
		if (map == null) {
			return null;
		}
		String key = file_name + 'い' + sessionID;
		File_path file_path = map.get(key);
		if(file_path==null){
			return null;
		}
		return FileUploadUtil.getFilePath()+ file_path.getPath_name();
	}
	public void saveFile(int uid, String sessionID, int type, int foreign_id,
			int file_type, int state, long save_time) {
		long time = System.currentTimeMillis();
		Map<String, File_path> map = fileMap.get(String
				.valueOf(file_type));
		try {
			if (map == null) {
				return;
			}
			Iterator<Map.Entry<String, File_path>> iter = map.entrySet().iterator();
			String key = "";
			File_path file_path = null;
			while (iter.hasNext()) {
				Map.Entry<String, File_path> entry=iter.next();
				key =  entry.getKey();
				file_path = entry.getValue();
				if (file_path == null) {
					return;
				}
				if (time - file_path.getCreate_time() > 30 * 60000) {// 过期的数据
					File file = new File(FileUploadUtil.getFilePath()
							+ file_path.getPath_name());
					if (file.exists() && file.isFile()) {
						file.delete();
					}
					iter.remove();
					continue;
				}
				if (key.contains(sessionID)) {
					if (save_time > file_path.getCreate_time()) {// 用户之前上传的文件（如：刷新）
						File file = new File(FileUploadUtil.getFilePath()
								+ file_path.getPath_name());
						if (file.exists() && file.isFile()) {
							file.delete();
						}
					} else {
						file_path.setForeign_id(foreign_id);
						file_path.setType(type);
						file_path.setState(state);
						insertFile(file_path);
					}
					iter.remove();
				} else {
					// 不同用户上传
					if (uid == file_path.getUid()) {
						// 用户使用不同session上传
						File file = new File(FileUploadUtil.getFilePath()
								+ file_path.getPath_name());
						if (file.exists() && file.isFile()) {
							file.delete();
						}
						iter.remove();
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public Map<String, Map<String, File_path>> getFileMap() {
		return fileMap;
	}
	public void addFileMap(String file_type,Map<String, File_path> map) {
		fileMap.put(file_type, map);
	}
	@Override
	public Map<String, File_path> getFileMapByKey(String file_type) {
		// TODO Auto-generated method stub
		return fileMap.get(file_type);
	}

	@Override
	public int getMaxStateByCondition(int type, int foreign_id, int file_type) {
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("type", type);
		map.put("foreign_id", foreign_id);
		map.put("file_type", file_type);
		return file_pathDAO.getMaxStateByCondition(map);
	}

}
