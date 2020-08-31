package com.zzqa.dao.impl.departmentPuchase;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.departmentPuchase.IDepartPuchaseDao;
import com.zzqa.pojo.departmentPuchase.DepartmentPuchase;
import com.zzqa.pojo.task_updateflow.Task_updateflow;

@Component("departPuchaseDao")
public class DepartPuchaseDaoImpl implements IDepartPuchaseDao {
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}
	@Override
	public void insertDepartPuchase(DepartmentPuchase departmentPuchase) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("departPuchase.insertDepartPuchase",departmentPuchase);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void updateDepartPuchase(DepartmentPuchase departmentPuchase) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("departPuchase.updateDepartPuchase",departmentPuchase);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	@Override
	public DepartmentPuchase getDepartPuchaseByID(int id) {
		// TODO Auto-generated method stub
		DepartmentPuchase departmentPuchase=null;
		try {
			Object object=sqlMapclient.queryForObject("departPuchase.getDepartPuchaseByID",id);
			if(object!=null){
				departmentPuchase=(DepartmentPuchase)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return departmentPuchase;
	}

	/**
	 * 通过user_id查询最后创建的其他项目采购单
	 *
	 * @param uid
	 * @return
	 */
	@Override
	public DepartmentPuchase getLastDepartPuchaseByUid(int uid) {
		DepartmentPuchase departmentPuchase=null;
		try {
			Object object = sqlMapclient.queryForObject("departPuchase.getLastDepartPuchaseByUid", uid);
			if (object!=null){
				departmentPuchase=(DepartmentPuchase)object;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return departmentPuchase;
	}

	@Override
	public int getCountByTime(String cur_time) {
		// TODO Auto-generated method stub
		int num=1;
		try{
			Object object=sqlMapclient.queryForObject("departPuchase.getCountByTime", cur_time);
			if(object!=null){
				num=(Integer)object;
				num++;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DepartmentPuchase> getRunningDepartPuchase() {
		// TODO Auto-generated method stub
		List<DepartmentPuchase> list=null;
		try {
			list=sqlMapclient.queryForList("departPuchase.getRunningDepartPuchase");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			list=new ArrayList<DepartmentPuchase>();
		}
		return list;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DepartmentPuchase> getAllList() {
		// TODO Auto-generated method stub
		List<DepartmentPuchase> list = null;
		try {
            list = sqlMapclient.queryForList("departPuchase.getAllList");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}

}
