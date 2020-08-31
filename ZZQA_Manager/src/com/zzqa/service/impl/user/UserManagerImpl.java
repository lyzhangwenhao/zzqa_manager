package com.zzqa.service.impl.user;

import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.position_user.IPosition_userDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.position_user.Position_user;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.user.UserManager;
@Component("userManager")
public class UserManagerImpl implements UserManager {
	@Value("${mass_email}")
	private boolean mass_email;
	@Value("${public_email}")
	private String public_email;
	@Autowired
	private IUserDAO userDAO;
	@Autowired
	private IPosition_userDAO position_userDAO;
	public String getPublic_email(){
		return public_email;
	}
	public boolean getMass_email(){
		return mass_email;
	}
	public boolean checkName(String name) {
		// TODO Auto-generated method stub
		return userDAO.checkName(name);
	}

	public void delUserByID(int id) {
		// TODO Auto-generated method stub
		userDAO.delUserByID(id);
	}

	public List<User> getAllUserOrderByLevel() {
		return userDAO.getAllUserOrderByLevel();
	}
	public List<User> getAllUserNoLeave(){
		List<User> userList=userDAO.getAllUserOrderByLevel();
		Iterator<User> iterator=userList.iterator();
		List<User> userList2=userDAO.getUserListByPermissionsID(111);
		while (iterator.hasNext()) {
			User user = (User) iterator.next();
			for(User user2:userList2){
				if(user.getId()==user2.getId()){
					iterator.remove();
				}
			}
		}
		userList2.clear();
		return userList;
	}
	public User getUserByID(int id) {
		// TODO Auto-generated method stub
		User user=userDAO.getUserByID(id);
		if(user!=null){
			Position_user position_user=position_userDAO.getPositionByID(user.getPosition_id());
			user.setPosition_name(position_user==null?"无":position_user.getPosition_name());
		}
		return user;
	}

	public User getUserByName(String name) {
		// TODO Auto-generated method stub
		return userDAO.getUserByName(name);
	}

	public List<User> getUserListByLevel(int level) {
		// TODO Auto-generated method stub
		return userDAO.getUserListByLevel(level);
	}

	public List<User> getUserListByPositionID(int position_id) {
		// TODO Auto-generated method stub
		return userDAO.getUserListByPositionID(position_id);
	}

	public void insertUser(User user) {
		// TODO Auto-generated method stub
		userDAO.insertUser(user);
	}

	public User log(User user) {
		// TODO Auto-generated method stub
		return userDAO.log(user);
	}

	public void updateUser(User user) {
		// TODO Auto-generated method stub
		userDAO.updateUser(user);
	}

	public List<User> getUserListByKeywords(String keywords) {
		return userDAO.getUserListByKeywords(keywords);
	}

	@Override
	public List<User> getUserListByPermissionsID(int permissions_id) {
		// TODO Auto-generated method stub
		return userDAO.getUserListByPermissionsID(permissions_id);
	}

	@Override
	public List<User> getParentListByChildUid(int uid) {
		// TODO Auto-generated method stub
		return userDAO.getParentListByChildUid(uid);
	}
	@Override
	public List<User> getSonListByParentUid(int uid) {
		// TODO Auto-generated method stub
		return userDAO.getSonListByParentUid(uid);
	}
	
	@Override
	public List<User> getParentUserByChildPosition(int position_id) {
		// TODO Auto-generated method stub
		return userDAO.getParentUserByChildPosition(position_id);
	}
	@Override
	public User getUserByEmail(String email) {
		// TODO Auto-generated method stub
		return userDAO.getUserByEmail(email);
	}
	@Override
	public User getTopUser() {
		// TODO Auto-generated method stub
		return userDAO.getTopUser();
	}
}
