package com.zzqa.service.interfaces.deliver;

import java.util.List;

import com.zzqa.pojo.deliver.Deliver;
import com.zzqa.pojo.deliver_content.Deliver_content;
import com.zzqa.pojo.user.User;

public interface DeliverManager {

	Deliver getDeliverByID(int deliver_id);

	List<Deliver_content> getItemsByDid(int deliver_id);

	void insertDeliver(Deliver deliver);

	void updateDeliver(Deliver deliver);

	void insertDeliverContent(Deliver_content deliver_content);

	void updateDeliverContent(Deliver_content deliver_content);

	void delDeliverContent(int id);
	List<Deliver> getDeliverListByUID(User mUser);

}
