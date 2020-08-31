package com.zzqa.dao.interfaces.deliver;

import java.util.List;

import com.zzqa.pojo.deliver.Deliver;

public interface IDeliverDAO {

	Deliver getDeliverByID(int deliver_id);

	void insertDeliver(Deliver deliver);
	void updateDeliver(Deliver deliver);

	List<Deliver> getRunningDeliver();

	List<Deliver> getAllList();

}
