package com.zzqa.dao.impl.resumption;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.resumption.IResumptionDAO;
import com.zzqa.pojo.resumption.Resumption;
import com.zzqa.pojo.task.Task;
@Component("resumptionDAO")
public class ResumptionDAOImpl implements IResumptionDAO{
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}
	@Override
	public void updateResumption(Resumption resumption) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("resumption.updateResumption", resumption);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void delResumptionByID(int id){
		try {
			sqlMapclient.delete("resumption.delResumptionByID",id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public void insertResumption(Resumption resumption) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("resumption.insertResumption", resumption);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Resumption getResumptionByID(int id) {
		// TODO Auto-generated method stub
		Resumption resumption=null;
		try {
			Object obj = sqlMapclient.queryForObject("resumption.getResumptionByID", id);
			if(obj!=null){
				resumption=(Resumption)obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resumption;
	}

	@Override
	public Resumption getNewResumptionByCreateID(int create_id) {
		// TODO Auto-generated method stub
		Resumption resumption=null;
		try {
			Object obj = sqlMapclient.queryForObject("resumption.getNewResumptionByCreateID", create_id);
			if(obj!=null){
				resumption=(Resumption)obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resumption;
	}

	@Override
	public List getAllResumptionlList() {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("resumption.getAllResumptionl");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List getAllRunningResumption() {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("resumption.getAllRunningResumption");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public Resumption getFinishedResumption(int type,int foreign_id) {
		// TODO Auto-generated method stub
		Resumption resumption=null;
		Map map=new HashMap();
		map.put("type", type);
		map.put("foreign_id", foreign_id);
		try {
			Object obj = sqlMapclient.queryForObject("resumption.getFinishedResumption",map);
			if(obj!=null){
				resumption=(Resumption)obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resumption;
	}
	public List getAllList(){
		List list = null;
		try {
            list = sqlMapclient.queryForList("resumption.getAllList");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
}
