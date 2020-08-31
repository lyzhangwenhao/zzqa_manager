package com.zzqa.service.impl.linkman;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.linkman.ILinkmanDAO;
import com.zzqa.pojo.linkman.Linkman;
import com.zzqa.service.interfaces.linkman.LinkmanManager;
@Component("linkmanManager")
public class LinkmanManagerImpl implements LinkmanManager {
	@Autowired
	private ILinkmanDAO linkmanDAO;
	
	public void delLinkmanByID(int id) {
		// TODO Auto-generated method stub
		linkmanDAO.delLinkmanByID(id);
	}

	public void deleteLinkmanLimit(int type,int foreign_id,int linkman_case,int state) {
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("type", type);
		map.put("foreign_id", foreign_id);
		map.put("linkman_case", linkman_case);
		map.put("state", state);
		linkmanDAO.deleteLinkmanLimit(map);
	}

	public int getLinkmanCountLimit(int type,int foreign_id,int linkman_case,int state) {
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("type", type);
		map.put("foreign_id", foreign_id);
		map.put("linkman_case", linkman_case);
		map.put("state", state);
		return linkmanDAO.getLinkmanCountLimit(map);
	}

	public List<Linkman> getLinkmanListLimit(int type,int foreign_id,int linkman_case,int state) {
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("type", type);
		map.put("foreign_id", foreign_id);
		map.put("linkman_case", linkman_case);
		map.put("state", state);
		return linkmanDAO.getLinkmanListLimit(map);
	}

	public void insertLinkman(Linkman linkman) {
		// TODO Auto-generated method stub
		linkmanDAO.insertLinkman(linkman);
	}

	public void updateLinkman(Linkman linkman) {
		// TODO Auto-generated method stub
		linkmanDAO.updateLinkman(linkman);
	}
	@Override
	public Linkman getLinkmanByID(int id) {
		// TODO Auto-generated method stub
		return linkmanDAO.getLinkmanByID(id);
	}
}
