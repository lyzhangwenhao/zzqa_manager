package com.zzqa.dao.impl.manufacture;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.manufacture.IManufactureDAO;
import com.zzqa.pojo.device.Device;
import com.zzqa.pojo.manufacture.Manufacture;
import com.zzqa.pojo.task.Task;
@Component("manufactureDAO")
public class ManufactureDAOImpl implements IManufactureDAO{
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}
	public void delManufactureByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("manufacture.delManufactureByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public Manufacture getManufactureByID(int id) {
		// TODO Auto-generated method stub
		Manufacture manufacture=null;
		try {
			Object object=sqlMapclient.queryForObject("manufacture.getManufactureByID", id);
			if(object!=null){
				manufacture=(Manufacture)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return manufacture;
	}
	
	public void insertManufacture(Manufacture manufacture) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("manufacture.insertManufacture",manufacture);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void updateManufacture(Manufacture manufacture) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("manufacture.updateManufacture", manufacture);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public int getNewManufactureByUID(int create_id) {
		// TODO Auto-generated method stub
		int num=0;
		try {
			Object obj=sqlMapclient.queryForObject("manufacture.getNewManufactureByUID", create_id);
			if(obj!=null){
				num=(Integer)obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}

	public List getManufactureList(Map map) {
		// TODO Auto-generated method stub
		List<Manufacture> list=null;
		try {
			list=sqlMapclient.queryForList("manufacture.getManufactureList", map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	public List getRunningManufacture() {
		// TODO Auto-generated method stub
		List<Manufacture> list=null;
		try {
			list=sqlMapclient.queryForList("manufacture.getRunningManufacture");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public List getAllList(){
		List list = null;
		try {
            list = sqlMapclient.queryForList("manufacture.getAllList");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
}
