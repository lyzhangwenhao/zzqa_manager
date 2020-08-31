package com.zzqa.service.impl.departmentPuchase;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zzqa.dao.interfaces.departePuchase_content.IDepartPuchaseContentDao;
import com.zzqa.dao.interfaces.departmentPuchase.IDepartPuchaseDao;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.departePuchase_content.DepartePuchase_content;
import com.zzqa.pojo.departmentPuchase.DepartmentPuchase;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.departmentPuchase.DepartPuchaseManager;
import com.zzqa.util.DataUtil;

@Service("departPuchaseManager")
public class DepartPuchaseImpl implements DepartPuchaseManager {

	@Autowired
	private IDepartPuchaseDao departPuchaseDao;
	@Autowired
	private IDepartPuchaseContentDao departPuchaseContentDao;
	@Autowired
	private IUserDAO userDAO;
	@Autowired
	private IPermissionsDAO permissionsDAO;
	
	@Override
	public void insertDepartPuchase(DepartmentPuchase departmentPuchase) {
		// TODO Auto-generated method stub
		departPuchaseDao.insertDepartPuchase(departmentPuchase);
	}

	@Override
	public void updateDepartPuchase(DepartmentPuchase departmentPuchase) {
		// TODO Auto-generated method stub
		departPuchaseDao.updateDepartPuchase(departmentPuchase);
	}

	@Override
	public void delDepartPuchaseContent(int departPuchaseContent_id) {
		// TODO Auto-generated method stub
		departPuchaseContentDao.delDepartPuchaseContent(departPuchaseContent_id);
	}

	@Override
	public void updateDepartPuchaseContent(
			DepartePuchase_content departePuchase_content) {
		// TODO Auto-generated method stub
		departPuchaseContentDao.updateDepartPuchaseContent(departePuchase_content);
	}

	@Override
	public void insertDepartPuchaseContent(
			DepartePuchase_content departePuchase_content) {
		// TODO Auto-generated method stub
		departPuchaseContentDao.insertDepartPuchaseContent(departePuchase_content);
	}

	@Override
	public DepartmentPuchase getDepartPuchaseByID(int departPuchase_id) {
		// TODO Auto-generated method stub
		return departPuchaseDao.getDepartPuchaseByID(departPuchase_id);
	}

	/**
	 * 通过user_id查询最后创建的其他项目采购单
	 *
	 * @param uid
	 * @return
	 */
	@Override
	public DepartmentPuchase getLastDepartPuchaseByUid(int uid) {
		return departPuchaseDao.getLastDepartPuchaseByUid(uid);
	}

	@Override
	public List<DepartePuchase_content> getItemsByDid(int departPuchase_id) {
		// TODO Auto-generated method stub
		List<DepartePuchase_content> itemsByDid = departPuchaseContentDao.getItemsByDid(departPuchase_id);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		if(itemsByDid!=null && itemsByDid.size()>0){
			for(DepartePuchase_content departePuchase_content : itemsByDid){
				long predict_time=departePuchase_content.getPredict_time();
				departePuchase_content.setPredict_date(predict_time==0?"":sdf.format(predict_time));
				long aog_time=departePuchase_content.getAog_time();
				departePuchase_content.setAog_date(aog_time==0?"":sdf.format(aog_time));
			}
		}
		return itemsByDid;
	}

	@Override
	public int getCountByTime(String cur_time) {
		// TODO Auto-generated method stub
		return departPuchaseDao.getCountByTime(cur_time);
	}
	
	@Override
	public List<DepartmentPuchase> getDepartPuchaseListByUID(User user) {
		List<DepartmentPuchase> departPuchases=departPuchaseDao.getRunningDepartPuchase();//查询所有未完成申购的流程
		SimpleDateFormat sdf=DataUtil.getSdf("yyyy.MM.dd");
		String[] flowArray22=DataUtil.getFlowArray(22);
		List<DepartmentPuchase> list=new ArrayList<DepartmentPuchase>();
		for(DepartmentPuchase departPuchase:departPuchases){
			int opera=departPuchase.getOperation();
			if(checkMyOperation(opera,user,departPuchase)){
				departPuchase.setProcess(sdf.format(departPuchase.getCreate_time())+flowArray22[opera]);
				list.add(departPuchase);
			}
		}
		return list;
	}
	
	private boolean checkMyOperation(int opera, User mUser, DepartmentPuchase departPuchase) {
		// TODO Auto-generated method stub
		switch (opera) {
			case 1:
				List<User> list=userDAO.getParentListByChildUid(departPuchase.getCreate_id());
				return list!=null&&list.size()>0&&list.get(0).getId()==mUser.getId();
			case 2:return mUser.getId()==departPuchase.getCreate_id();
			case 3:
				return permissionsDAO.checkPermission(mUser.getPosition_id(), 17);
			case 4:return mUser.getId()==departPuchase.getCreate_id();
			case 5:
			case 10:
//				return permissionsDAO.checkPermission(mUser.getPosition_id(), 21);
				return permissionsDAO.checkPermission(mUser.getPosition_id(), 181);
			case 8:return mUser.getId()==departPuchase.getCreate_id();
			case 9:return permissionsDAO.checkPermission(mUser.getPosition_id(), 22);
			default:
				break;
		}
		return false;
	}

	@Override
	public void updateDepartPuchaseContentTime(
			DepartePuchase_content departePuchase_content) {
		// TODO Auto-generated method stub
		departPuchaseContentDao.updateDepartPuchaseContentTime(departePuchase_content);
	}
}
