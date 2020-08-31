package com.zzqa.dao.interfaces.resumption;

import java.util.List;
import com.zzqa.pojo.resumption.Resumption;

/****
 * 销假单
 * @author louph
 *
 */
public interface IResumptionDAO {
	public void updateResumption(Resumption resumption);
	public void insertResumption(Resumption resumption);
	public void delResumptionByID(int id);
	public Resumption getResumptionByID(int id);
	public Resumption getNewResumptionByCreateID(int create_id);
	public List getAllResumptionlList();
	/****
	 * 查询未完成的流程
	 * @return
	 */
	public List getAllRunningResumption();
	/****
	 * 查询是否有销假，并返回
	 * @param type
	 * @param foreign_id
	 * @return
	 */
	public Resumption getFinishedResumption(int type,int foreign_id);
	public List getAllList();
}
