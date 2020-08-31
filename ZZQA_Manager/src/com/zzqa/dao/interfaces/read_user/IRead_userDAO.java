package com.zzqa.dao.interfaces.read_user;

import java.util.List;

import com.zzqa.pojo.read_user.Read_user;

public interface IRead_userDAO {
	public Read_user getRead_userByID(int id);
	public void insertRead_user(Read_user read_user);
	public void delRead_userByID(int id);
	public  void updateRead_userByCondition(Read_user read_user);
	public void updateRead_user(Read_user read_user);
	public void delRead_userByCondition(int type,int foreign_id,int uid);
	public int getRead_userIDByCondition(int type,int foreign_id,int uid,long update_time);
	public long getRead_userTimeByCondition(int type,int foreign_id,int uid);
}
