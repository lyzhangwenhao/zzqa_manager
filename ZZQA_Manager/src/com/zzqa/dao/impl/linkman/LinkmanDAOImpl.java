package com.zzqa.dao.impl.linkman;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.linkman.ILinkmanDAO;
import com.zzqa.pojo.linkman.Linkman;
@Component("linkmanDAO")
public class LinkmanDAOImpl implements ILinkmanDAO {
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	public void delLinkmanByID(int id) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.delete("linkman.delLinkmanByID", id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public void deleteLinkmanLimit(Map map) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.delete("linkman.deleteLinkmanLimit", map);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public int getLinkmanCountLimit(Map map) {
		// TODO Auto-generated method stub
		int num = 0;
		try {
			Object obj = sqlMapclient.queryForObject("linkman.getLinkmanCountLimit", map);
			if (obj != null) {
				num = (Integer) obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}

	public List getLinkmanListLimit(Map map) {
		// TODO Auto-generated method stub
		List<Linkman> list = null;
        try {
            list = sqlMapclient.queryForList("linkman.getLinkmanListLimit",map);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}

	public void insertLinkman(Linkman linkman) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.insert("linkman.insertLinkman", linkman);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public void updateLinkman(Linkman linkman) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.update("linkman.updateLinkman", linkman);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}
	@Override
	public Linkman getLinkmanByID(int id) {
		// TODO Auto-generated method stub
		Linkman linkman=null;
		try {
			Object obj=sqlMapclient.queryForObject("linkman.getLinkmanByID", id);
			if(obj!=null){
				linkman=(Linkman)obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return linkman;
	}
	
	@Override
	public List<Linkman> getLinkmanByCondition(int type,int foreign_id,long starttime,long endtime) {
		// TODO Auto-generated method stub
		List<Linkman> list=null;
		Map map=new HashMap();
		map.put("type", type);
		map.put("foreign_id", foreign_id);
		map.put("starttime", starttime);
		map.put("endtime", endtime);
		try {
			list=sqlMapclient.queryForList("linkman.getLinkmanByCondition", map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
