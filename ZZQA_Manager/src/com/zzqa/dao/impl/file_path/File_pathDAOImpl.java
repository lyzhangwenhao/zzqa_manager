package com.zzqa.dao.impl.file_path;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.file_path.IFile_pathDAO;
import com.zzqa.pojo.file_path.File_path;
import com.zzqa.pojo.user.User;
@Component("file_pathDAO")
public class File_pathDAOImpl implements IFile_pathDAO {
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	public boolean checkNowFileExists(File_path file_path) {
		// TODO Auto-generated method stub
		List<File_path> list = null;
        try {
            list = sqlMapclient.queryForList("file_path.checkNowFileExists", file_path);
            if (list.size() < 1) {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
	}

	public void delAllFileByCondition(Map map) {
		// TODO Auto-generated method stub
		try {
			int delete = sqlMapclient.delete("file_path.delAllFileByCondition", map);
			System.out.println(map);
			System.out.println(delete);
		} catch (SQLException e) {
            e.printStackTrace();
        }
	}
	public void delAllFileByCondition2(Map map) {
		// TODO Auto-generated method stub
		try {
			int delete = sqlMapclient.delete("file_path.delAllFileByCondition2", map);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}


	public void delFileByID(int id) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.delete("file_path.delFileByID", id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public List getAllFileByCondition(Map map) {
		// TODO Auto-generated method stub
		List<File_path> list = null;
        try {
            list = sqlMapclient.queryForList("file_path.getAllFileByCondition",map);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}

	public File_path getNewFileByFID(int foreign_id){
		File_path file_path=null;
		try {
			Object object=sqlMapclient.queryForObject("file_path.getNewFileByFID", foreign_id);
			if(object!=null){
				file_path=(File_path)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return file_path;
	}

	public File_path getFileByID(int id) {
		// TODO Auto-generated method stub
		File_path file_path = null;
        try {
        	file_path = (File_path)sqlMapclient.queryForObject("file_path.getFileByID", id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return file_path;
	}

	public void insertFile(File_path file_path) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.insert("file_path.insertFile", file_path);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public void updateState(File_path file_path) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.update("file_path.updateState", file_path);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}
	@Override
	public List<File_path> getAllFileGroupByState(Map map) {
		// TODO Auto-generated method stub
		List<File_path> list = null;
        try {
            list = sqlMapclient.queryForList("file_path.getAllFileGroupByState",map);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	
	public int getMaxStateByCondition(Map map){
		int state=0;
		try {
			Object object=sqlMapclient.queryForObject("file_path.getMaxStateByCondition", map);
			if(object!=null){
				state=(Integer)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return state;
	}
}