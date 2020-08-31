package com.zzqa.dao.impl.procurement;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.procurement.IProcurementDAO;
import com.zzqa.pojo.procurement.Procurement;
@Component("procurementDAO")
public class ProcurementDAOImpl implements IProcurementDAO {
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	public void delProcurementByID(int id) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.delete("procurement.delProcurementByID", id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}
	
	public Procurement getProcurementByID(int id) {
		// TODO Auto-generated method stub
		Procurement procurement = null;
        try {
        	procurement = (Procurement)sqlMapclient.queryForObject("procurement.getProcurementByID", id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return procurement;
	}

	public void deleteProcurementLimit(int type, int foreign_id) {
		// TODO Auto-generated method stub
		Procurement procurement=new Procurement();
		procurement.setType(type);
		procurement.setForeign_id(foreign_id);
		try {
            sqlMapclient.delete("procurement.deleteProcurementLimit", procurement);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public int getProcurementCountLimit(int type, int foreign_id) {
		// TODO Auto-generated method stub
		Procurement procurement=new Procurement();
		procurement.setType(type);
		procurement.setForeign_id(foreign_id);
		int num = 0;
		try {
			Object obj = sqlMapclient.queryForObject("procurement.getProcurementCountLimit", procurement);
			if (obj != null) {
				num = (Integer) obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}

	public List getProcurementListLimit(int type, int foreign_id) {
		// TODO Auto-generated method stub
		Procurement procurement=new Procurement();
		procurement.setType(type);
		procurement.setForeign_id(foreign_id);
		List<Procurement> list = null;
        try {
            list = sqlMapclient.queryForList("procurement.getProcurementListLimit",procurement);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}

	public void insertProcurement(Procurement procurement) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.insert("procurement.insertProcurement", procurement);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public void updateProcurement(Procurement procurement) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.update("procurement.updateProcurement", procurement);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public List getProcurementName() {
		List<String> list=null ;
		try {
			list=sqlMapclient.queryForList("procurement.getProcurementName");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public List getProcurementAgent() {
		List<String> list=null ;
		try {
			list=sqlMapclient.queryForList("procurement.getProcurementAgent");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public List getProcurementModel() {
		List<String> list=null ;
		try {
			list=sqlMapclient.queryForList("procurement.getProcurementModel");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public List getProcurementUnit() {
		List<String> list=null ;
		try {
			list=sqlMapclient.queryForList("procurement.getProcurementUnit");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
}
