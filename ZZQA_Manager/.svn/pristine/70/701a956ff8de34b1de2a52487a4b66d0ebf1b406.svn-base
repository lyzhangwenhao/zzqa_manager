package com.zzqa.service.interfaces.position_user;

import java.util.List;

import com.zzqa.pojo.position_user.Position_user;

public interface Position_userManager {
	//通过position_name查询
	public Position_user getPositionByPositionName(String position_name);
	//添加一条用户职位关系
	public int  insertPosition(Position_user position_user);
	//查询所有组织
	public List getPositionOrderByparent();
	//根据id查询
	public Position_user getPositionByID(int id);
	//修改用户职位
	public void updatePosition(Position_user position_user);
	//根据parent查询子节点个数
	public int getChildrenNumByParent(int parent);
	//根据id删除职位
	public void delPositionByID(int id);
	//查询下级组织id
	public List getSonPosition(int position_id);
	//查看bossId
	public int getBossParentID();
}