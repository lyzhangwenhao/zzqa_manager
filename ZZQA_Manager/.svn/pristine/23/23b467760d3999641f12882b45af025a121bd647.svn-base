package com.zzqa.dao.impl.user;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.user.User;
@Component("userDAO")
public class UserDAOImpl implements IUserDAO {
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	public boolean checkName(String name) {
		// TODO Auto-generated method stub
		List<User> list = null;
        try {
            list = sqlMapclient.queryForList("user.checkName", name);
            if (list.size() < 1) {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
	}

	public void delUserByID(int id) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.delete("user.delUserByID", id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public List<User> getAllUserOrderByLevel() {
		// TODO Auto-generated method stub
		List<User> list = null;
        try {
            list = sqlMapclient.queryForList("user.getAllUserOrderByLevel");

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}

	public User getUserByID(int id) {
		// TODO Auto-generated method stub
		User user = null;
        try {
        	Object obj=sqlMapclient.queryForObject("user.getUserByID", id);
        	if(obj!=null){
        		user = (User)obj;
        	}
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
	}
	
	public User getTopUser() {
		// TODO Auto-generated method stub
		User user = null;
        try {
        	Object obj=sqlMapclient.queryForObject("user.getTopUser");
        	if(obj!=null){
        		user = (User)obj;
        	}
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
	}

	public User getUserByName(String name) {
		// TODO Auto-generated method stub
		User user = null;
        try {
        	Object obj = sqlMapclient.queryForObject("user.getUserByName", name);
        	if(obj!=null){
        		user=(User)obj;
        	}
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
	}

	public void insertUser(User user) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.insert("user.insertUser", user);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public User log(User user) {
		// TODO Auto-generated method stub
		User user1 = null;
        try {
        	Object obj =  sqlMapclient.queryForObject("user.log", user);
        	if(obj!=null){
        		user1=(User)obj;
        	}
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return user1;
	}

	public void updateUser(User user) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.update("user.updateUser", user);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public List<User> getUserListByLevel(int level) {
		// TODO Auto-generated method stub
		List<User> list = null;
        try {
            list = sqlMapclient.queryForList("user.getUserListByLevel",level);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}

	public List<User> getUserListByPositionID(int position_id) {
		// TODO Auto-generated method stub
		List<User> list = null;
        try {
            list = sqlMapclient.queryForList("user.getUserListByPositionID",position_id);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	
	public List<User> getUserListByPermissionsID(int permissions_id) {
		// TODO Auto-generated method stub
		List<User> list = null;
        try {
            list = sqlMapclient.queryForList("user.getUserListByPermissionsID",permissions_id);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	public List<User> getParentListByChildUid(int uid) {
		// TODO Auto-generated method stub
		List<User> list = null;
        try {
            list = sqlMapclient.queryForList("user.getParentListByChildUid",uid);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	public List<User> getParentUserByChildPosition(int position_id) {
		// TODO Auto-generated method stub
		List<User> list = null;
        try {
            list = sqlMapclient.queryForList("user.getParentUserByChildPosition",position_id);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	public List<User> getSonListByParentUid(int uid){
		List<User> list = null;
        try {
            list = sqlMapclient.queryForList("user.getSonListByParentUid",uid);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	public List<Integer> getSonListByParentPosition(int position_id) {
		// TODO Auto-generated method stub
		List<Integer> list = null;
        try {
            list = sqlMapclient.queryForList("user.getSonListByParentPosition",position_id);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	@Override
	public List<User> getUserListByKeywords(String keywords) {
		// TODO Auto-generated method stub
		List<User> list = null;
        try {
            list = sqlMapclient.queryForList("user.getUserListByKeywords",keywords);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	@Override
	public User getUserByEmail(String email) {
		// TODO Auto-generated method stub
		User user = null;
        try {
        	Object obj = sqlMapclient.queryForObject("user.getUserByEmail", email);
        	if(obj!=null){
        		user=(User)obj;
        	}
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
	}
	@Override
	public String getUserNameByID(int id) {
		// TODO Auto-generated method stub
		if(id==0){
			return "";
		}
		User user=getUserByID(id);
		if(user!=null){
			return user.getTruename();
		}else{
			return "用户"+id;
		}
	}
}
