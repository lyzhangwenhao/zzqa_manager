package com.zzqa.service.impl.deliver;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zzqa.dao.interfaces.deliver.IDeliverDAO;
import com.zzqa.dao.interfaces.deliver_content.IDeliver_contentDAO;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.deliver.Deliver;
import com.zzqa.pojo.deliver_content.Deliver_content;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.deliver.DeliverManager;
import com.zzqa.util.DataUtil;

@Service("deliverManager")
public class DeliverManagerImpl implements DeliverManager {
	@Autowired
	private IUserDAO userDAO;
	@Autowired
	private IDeliver_contentDAO deliver_contentDAO;
	@Autowired
	private IDeliverDAO deliverDAO;
	@Autowired
	private IPermissionsDAO permissionsDAO;
	@Override
	public Deliver getDeliverByID(int deliver_id) {
		// TODO Auto-generated method stub
		return deliverDAO.getDeliverByID(deliver_id);
	}
	@Override
	public List<Deliver_content> getItemsByDid(int deliver_id) {
		// TODO Auto-generated method stub
		return deliver_contentDAO.getItemsByDid(deliver_id);
	}
	@Override
	public void insertDeliver(Deliver deliver) {
		// TODO Auto-generated method stub
		deliverDAO.insertDeliver(deliver);
	}
	@Override
	public void updateDeliver(Deliver deliver) {
		// TODO Auto-generated method stub
		deliverDAO.updateDeliver(deliver);
	}
	@Override
	public void insertDeliverContent(Deliver_content deliver_content) {
		// TODO Auto-generated method stub
		deliver_contentDAO.insertDeliverContent(deliver_content);
	}
	@Override
	public void updateDeliverContent(Deliver_content deliver_content) {
		// TODO Auto-generated method stub
		deliver_contentDAO.updateDeliverContent(deliver_content);
	}
	@Override
	public void delDeliverContent(int id) {
		// TODO Auto-generated method stub
		deliver_contentDAO.delDeliverContent(id);
	}
	@Override
	public List<Deliver> getDeliverListByUID(User mUser) {
		// TODO Auto-generated method stub
		List<Deliver> delivers=deliverDAO.getRunningDeliver();//查询所有未完成的考核
		SimpleDateFormat sdf=DataUtil.getSdf("yyyy.MM.dd");
		String[] flowArray20=DataUtil.getFlowArray(20);
		List<Deliver> list=new ArrayList<Deliver>();
		for(Deliver deliver:delivers){
			int opera=deliver.getOperation();
			if(checkMyOperation(opera,mUser,deliver)){
				deliver.setProcess(sdf.format(deliver.getCreate_time())+flowArray20[opera]);
				list.add(deliver);
			}
		}
		return list;
	}
	private boolean checkMyOperation(int opera, User mUser, Deliver deliver) {
		// TODO Auto-generated method stub
		switch (opera) {
			case 1:
				List<User> list=userDAO.getParentListByChildUid(deliver.getCreate_id());
				return list!=null&&list.size()>0&&list.get(0).getId()==mUser.getId();
			case 2:
				return permissionsDAO.checkPermission(mUser.getPosition_id(), 149);
			case 3:
			case 5:
				return mUser.getId()==deliver.getCreate_id();
			default:
				break;
		}
		return false;
	}
}
