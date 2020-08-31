package com.zzqa.dao.impl.operation;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.operation.IOperationDAO;
import com.zzqa.pojo.operation.Operation;
@Component("operationDAO")
public class OperationDAOImpl implements IOperationDAO {
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	public int getOperationCount(Map map) {
		// TODO Auto-generated method stub
		int num = 0;
		try {
			Object obj = sqlMapclient.queryForObject("operation.getOperationCount", map);
			if (obj != null) {
				num = (Integer) obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
		return num;
	}

	public List getOperationList(Map map) {
		// TODO Auto-generated method stub
		List<Operation> list = null;
		try {
			list = sqlMapclient.queryForList("operation.getOperationList", map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public void insertOperation(Operation operation) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.insert("operation.insertOperation", operation);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public void delOperationByID(int id) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.delete("operation.delOperationByID", id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public void updateOperation(Operation operation) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.update("operation.updateOperation", operation);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}
}
