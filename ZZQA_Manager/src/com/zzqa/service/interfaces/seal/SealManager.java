package com.zzqa.service.interfaces.seal;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.seal.Seal;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.user.User;

public interface SealManager {
	public int insertSeal(Seal seal);
	//修改
	public void updateSeal(Seal seal);
	//通过id查询
	public Seal getSealByID(int id);
	public Seal getSealByID2(int id);
	//待办事项
	public List<Seal> getSealByUID(User user);
	public Map<String, String> getSealFlowForDraw(Seal seal,Flow flow);
	public boolean canApproveSeal(User user,Seal seal);
}
