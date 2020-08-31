package com.zzqa.dao.interfaces.linkman;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.linkman.Linkman;

public interface ILinkmanDAO {
	//添加一条联系人记录
	public void insertLinkman(Linkman linkman);
	//更新联系人
	public void updateLinkman(Linkman linkman);
	//删除联系人
	public void delLinkmanByID(int id);
	//根据条件查询联系人
	public List getLinkmanListLimit(Map map);
	//根据条件查询联系人个数
	public int getLinkmanCountLimit(Map map);
	//根据条件删除联系人
	public void deleteLinkmanLimit(Map map);
	//根据id查询
	public Linkman getLinkmanByID(int id);
	
	public List<Linkman> getLinkmanByCondition(int type,int foreign_id,long starttime,long endtime);
}
