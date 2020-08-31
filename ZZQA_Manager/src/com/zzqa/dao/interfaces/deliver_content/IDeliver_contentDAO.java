package com.zzqa.dao.interfaces.deliver_content;

import java.util.List;

import com.zzqa.pojo.deliver_content.Deliver_content;

public interface IDeliver_contentDAO {
	List<Deliver_content> getItemsByDid(int deliver_id);

	void insertDeliverContent(Deliver_content deliver_content);

	void updateDeliverContent(Deliver_content deliver_content);

	void delDeliverContent(int id);
}
