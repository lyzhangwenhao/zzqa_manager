package com.zzqa.dao.interfaces.departmentPuchase;

import java.util.List;

import com.zzqa.pojo.departmentPuchase.DepartmentPuchase;

public interface IDepartPuchaseDao {

	void insertDepartPuchase(DepartmentPuchase departmentPuchase);

	void updateDepartPuchase(DepartmentPuchase departmentPuchase);

	DepartmentPuchase getDepartPuchaseByID(int departPuchase_id);

	/**
	 * 通过user_id查询最后创建的其他项目采购单
	 *
	 * @param uid
	 * @return
	 */
	DepartmentPuchase getLastDepartPuchaseByUid(int uid);

	int getCountByTime(String cur_time);

	List<DepartmentPuchase> getRunningDepartPuchase();

	List<DepartmentPuchase> getAllList();
}
