package com.zzqa.service.interfaces.linkman;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.linkman.Linkman;

public interface LinkmanManager {
	//添加一条联系人记录
	public void insertLinkman(Linkman linkman);
	//更新联系人
	public void updateLinkman(Linkman linkman);
	//删除联系人
	public void delLinkmanByID(int id);
	/**
	 * 根据条件查询联系人
	 * @param type 区分表
	 * @param foreign_id 外表主键
	 * @param linkman_case 0表示不区分
	 * @param state -1 表示不区分
	 * @return
	 */
	public List<Linkman> getLinkmanListLimit(int type,int foreign_id,int linkman_case,int state);
	/**
	 * 根据条件查询联系人个数
	 * @param type 区分表
	 * @param foreign_id 外表主键
	 * @param linkman_case 0表示不区分
	 * @param state -1 表示不区分
	 * @return
	 */
	public int getLinkmanCountLimit(int type,int foreign_id,int linkman_case,int state);
	/**
	 * 根据条件删除联系人
	 * @param type 区分表
	 * @param foreign_id 外表主键
	 * @param linkman_case 0表示不区分
	 * @param state -1 表示不区分
	 * @return
	 */
	public void deleteLinkmanLimit(int type,int foreign_id,int linkman_case,int state);
	/***
	 * 根据id查询
	 * @param id
	 * @return
	 */
	public Linkman getLinkmanByID(int id);
}
