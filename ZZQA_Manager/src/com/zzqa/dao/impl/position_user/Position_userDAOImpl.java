package com.zzqa.dao.impl.position_user;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.position_user.IPosition_userDAO;
import com.zzqa.pojo.position_user.Position_user;
import com.zzqa.pojo.user.User;
@Component("position_userDAO")
public class Position_userDAOImpl implements IPosition_userDAO {
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}
	
	public Position_user getPositionByPositionName(String position_name){
		Position_user position=null;
		Object obj;
		try {
			obj = sqlMapclient.queryForObject("position_user.getPositionByPositionName", position_name);
			if(obj!=null){
				position=(Position_user)obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return position;
	}
	
	public Position_user getPositionByID(int id){
		Position_user position=null;
		Object obj;
		try {
			obj = sqlMapclient.queryForObject("position_user.getPositionByID", id);
			if(obj!=null){
				position=(Position_user)obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return position;
	}
	
	public void delPosition(Position_user position_user) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.delete("position_user.delPosition", position_user);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public void delPositionByUID(int uid) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.delete("position_user.delPositionByUID", uid);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public Position_user getPositionByUID(int uid) {
		// TODO Auto-generated method stub
		Position_user position_user = null;
        try {
            Object object = sqlMapclient.queryForObject("position_user.getPositionByUID",uid);
            if(object!=null){
            	position_user=(Position_user)object;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return position_user;
	}
	public List getPositionOrderByparent(){
		List<Position_user> list = null;
        try {
            list = sqlMapclient.queryForList("position_user.getPositionOrderByparent");

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}

	public void insertPosition(Position_user position_user) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.insert("position_user.insertPosition", position_user);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}
	public void updatePosition(Position_user position_user){
		try {
			sqlMapclient.update("position_user.updatePosition", position_user);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	public int getNewPosition_id(){
		int position_id=0;
		try {
			Object obj=sqlMapclient.queryForObject("position_user.getNewPosition_id");
			position_id=(Integer)obj;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return position_id;
	}
	public int getChildrenNumByParent(int parent){
		int num=0;
		try {
			Object obj=sqlMapclient.queryForObject("position_user.getChildrenNumByParent", parent);
			num=(Integer)obj;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}
	public void delPositionByID(int id){
		try {
			sqlMapclient.delete("position_user.delPositionByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public List getSonPosition(int position_id) {
		// TODO Auto-generated method stub
		List<Integer> list = null;
        try {
            list = sqlMapclient.queryForList("position_user.getSonPosition",position_id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	
	@Override
	public boolean checkParentId(int position_id) {
		// TODO Auto-generated method stub
		boolean flag=false;
		try {
			Object obj=sqlMapclient.queryForObject("position_user.checkParentId", position_id);
			if(obj!=null&&(Integer)obj>0){
				flag=true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
	}
	@Override
	public boolean getParentByPositionId(int position_id) {
		boolean flag=false;
		try {
			Object obj=sqlMapclient.queryForObject("position_user.getParentByPositionId",position_id);
			if(obj!=null&&(Integer)obj==0){
				flag=true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
	}
	
	@Override
	public int getBossParentID() {
		int num=0;
		try {
			Object obj=sqlMapclient.queryForObject("position_user.getBossParentID");
			if(obj!=null){
				num=(Integer)obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}
}
