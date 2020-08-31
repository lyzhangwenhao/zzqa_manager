package com.zzqa.dao.interfaces.position_user;

import java.util.List;

import com.zzqa.pojo.position_user.Position_user;

public interface IPosition_userDAO {
	//通过position_name查询
	public Position_user getPositionByPositionName(String position_name);
	//添加一条用户职位关系
	public void insertPosition(Position_user position_user);
	//查询用户参与的所有职位
	public Position_user getPositionByUID(int uid);
	//删除用户参与的所有职位
	public void delPositionByUID(int uid);
	//删除某一条职位
	public void delPosition(Position_user position_user);
	//修改用户职位关系
	public void updatePosition(Position_user position_user);
	//查询最新添加的职位id
	public int getNewPosition_id();
	//查询所有组织
	public List getPositionOrderByparent();
	//根据id查询
	public Position_user getPositionByID(int id);
	//根据position_name查询子节点个数
	public int getChildrenNumByParent(int parent);
	//根据id删除职位
	public void delPositionByID(int id);
	//查询下级组织id
	public List getSonPosition(int position_id);
	public boolean checkParentId(int position_id);
	//查看总经理父节点
	public boolean getParentByPositionId(int position_id);
	//查找boss positionID
	public int getBossParentID();
}
