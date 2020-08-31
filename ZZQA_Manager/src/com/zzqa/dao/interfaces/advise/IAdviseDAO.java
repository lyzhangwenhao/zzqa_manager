package com.zzqa.dao.interfaces.advise;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.advise.Advise;


public interface IAdviseDAO {
	public Advise getAdviseByID(int id);
	public void insertAdvise(Advise advise);
	public void delAdviseByID(int id);
	public  void updateAdvise(Advise advise);
	public int getAdviseCountByCondition(int type,int create_id);
	/*****
	 * 
	 * @param map key->type 0:我发布的建议
	 * 						 					  1: 公开的建议
	 * 											   2:别人发我的未读私信 
	 * 										create_id 大于0 生效
	 * 										starttime、endtime 大于0 生效
	 * 										
	 * @return
	 */
	public List getAdviseListByCondition(Map map);
	public int getNewAdviseIDByCreateID(int create_id);
	/****
	 * map-key:create_id
	 * 				   
	 * @param map
	 * @return
	 */
	public List getNotReadReplyAdviseList(Map map);
}
