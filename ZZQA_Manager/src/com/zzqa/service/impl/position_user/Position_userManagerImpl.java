package com.zzqa.service.impl.position_user;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.position_user.IPosition_userDAO;
import com.zzqa.pojo.position_user.Position_user;
import com.zzqa.service.interfaces.position_user.Position_userManager;
@Component("position_userManager")
public class Position_userManagerImpl implements Position_userManager {
	@Autowired
	private IPosition_userDAO position_userDAO;

	public int insertPosition(Position_user position_user) {
		// TODO Auto-generated method stub
		position_userDAO.insertPosition(position_user);
		return position_userDAO.getNewPosition_id();
	}

	@Override
	public Position_user getPositionByPositionName(String position_name) {
		// TODO Auto-generated method stub
		return position_userDAO.getPositionByPositionName(position_name);
	}

	@Override
	public List getPositionOrderByparent() {
		// TODO Auto-generated method stub
		return position_userDAO.getPositionOrderByparent();
	}

	@Override
	public Position_user getPositionByID(int id) {
		// TODO Auto-generated method stub
		return position_userDAO.getPositionByID(id);
	}

	@Override
	public void updatePosition(Position_user position_user) {
		// TODO Auto-generated method stub
		position_userDAO.updatePosition(position_user);
	}

	@Override
	public int getChildrenNumByParent(int parent) {
		// TODO Auto-generated method stub
		return position_userDAO.getChildrenNumByParent(parent);
	}

	@Override
	public void delPositionByID(int id) {
		// TODO Auto-generated method stub
		position_userDAO.delPositionByID(id);
	}
	@Override
	public List getSonPosition(int position_id) {
		// TODO Auto-generated method stub
		return position_userDAO.getSonPosition(position_id);
	}

	@Override
	public int getBossParentID() {
		// TODO Auto-generated method stub
		return position_userDAO.getBossParentID();
	}
}
