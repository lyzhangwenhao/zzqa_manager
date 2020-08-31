package com.zzqa.dao.impl.circuit_card;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.circuit_card.ICircuit_cardDAO;
import com.zzqa.pojo.circuit_card.Circuit_card;
@Component("circuit_cardDAO")
public class Circuit_cardDAOImpl implements ICircuit_cardDAO {
	@Resource(name="sqlMapClient")
	SqlMapClient sqlMapclient = null;
	@Override
	public void insertCircuit_card(Circuit_card circuit_card) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("circuit_card.insertCircuit_card", circuit_card);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delCircuit_cardByDeviceID(int device_id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("circuit_card.delCircuit_cardByDeviceID", device_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delCircuit_cardByTempID(int device_id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("circuit_card.delCircuit_cardByTempID", device_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public List getCircuit_cardListFromDevice(int device_id) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("circuit_card.getCircuit_cardListFromDevice", device_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public List getCircuit_cardListFromTemp(int device_id) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("circuit_card.getCircuit_cardListFromTemp", device_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

}
