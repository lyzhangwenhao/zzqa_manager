package com.zzqa.dao.impl.flow;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.pojo.flow.Flow;
@Component("flowDAO")
public class FlowDAOImpl implements IFlowDAO {
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	public List getFlowListByCondition(int type,int foreign_id) {
		// TODO Auto-generated method stub
		Flow flow=new Flow();
		flow.setType(type);
		flow.setForeign_id(foreign_id);
		List<Flow> list = null;
        try {
            list = sqlMapclient.queryForList("flow.getFlowListByCondition",flow);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	public void  deleteByCondition(int type,int foreign_id){
		Flow flow=new Flow();
		flow.setType(type);
		flow.setForeign_id(foreign_id);
		try {
			sqlMapclient.delete("flow.deleteByCondition", flow);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void  deleteRecentOperat(int type,int foreign_id,int operation){
		Flow flow=new Flow();
		flow.setType(type);
		flow.setForeign_id(foreign_id);
		flow.setOperation(operation);
		try {
			sqlMapclient.delete("flow.deleteRecentOperat", flow);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public List getReasonList(int type,int foreign_id) {
		// TODO Auto-generated method stub
		Flow flow=new Flow();
		flow.setType(type);
		flow.setForeign_id(foreign_id);
		if(type==11){
			flow.setOperation(1);//用于看文件记录
		}
		List<Flow> list = null;
        try {
            list = sqlMapclient.queryForList("flow.getReasonList",flow);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	
	public long getFlowTimeByFlow(Flow flow){
		long time=0l;
		try {
			Object obj=sqlMapclient.queryForObject("flow.getFlowTimeByFlow",flow);
			if(obj!=null){
				time=(Long)obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return time;
	}
	/***
	 * 查询所有最新的流程的foreign_id
	 */
	public List getAllFlowList() {
		// TODO Auto-generated method stub
		List<Flow> list = null;
        try {
            list = sqlMapclient.queryForList("flow.getAllFlowList");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	
	/***
	 * 查询所有最新的流程的position_id
	 */
	public List getParentAllFlowList(int position_id,int uid) {
		// TODO Auto-generated method stub
		List<Flow> list = null;
		Flow flow=new Flow();
		flow.setUid(uid);
		flow.setForeign_id(position_id);
		try {
			list = sqlMapclient.queryForList("flow.getParentAllFlowList",flow);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
////查看权限内全部记录和自己参与的流程记录
	public List<Flow> getJoinPermissionFlowList(List<Integer> flowTypes,List<Integer> fidList, List<Integer> foidList,long time) {
		// TODO Auto-generated method stub
		List<Flow> list = null;
		if(fidList==null || fidList.size()==0){
			fidList=new ArrayList<Integer>();
			fidList.add(-1);
		}
		if(foidList==null || foidList.size()==0){
			foidList=new ArrayList<Integer>();
			foidList.add(-1);
		}
		if(flowTypes==null || flowTypes.size()==0){
			flowTypes=new ArrayList<Integer>();
			flowTypes.add(-1);
		}
		Map map = new HashMap<String, Integer>();
		map.put("flowTypes", flowTypes);
		map.put("fidList", fidList);
		map.put("foidList", foidList);
		map.put("time", time);
		try {
			list = sqlMapclient.queryForList("flow.getJoinPermissionFlowList",map);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//查看自己参与过的流程记录
	public List getAllJoinableFlowList(List<Integer> fidList) {
		// TODO Auto-generated method stub
		List<Flow> list = null;
		try {
			list = sqlMapclient.queryForList("flow.getAllJoinableFlowList",fidList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	//查看权限记录和下属 但是自己没有参加过全部记录
	public List<Flow> getAllPermissionFlowList(List<Integer> flowTypes,List<Integer> foidList,int uid,long time) {
		// TODO Auto-generated method stub
		List<Flow> list = null;
		if(foidList.size()==0){
			foidList.add(-1);
		}
		if(flowTypes.size()==0){
			flowTypes.add(-1);
		}
		Map map = new HashMap<String, Integer>();
		map.put("flowTypes", flowTypes);
		map.put("foidList", foidList);
		map.put("uid", uid);
		map.put("time", time);
		try {
			list = sqlMapclient.queryForList("flow.getAllPermissionFlowList",map);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//没有查看权限只能看自己记录和所属人员考核记录
	public List<Flow> getJoinFlowwerFlowList(List<Integer> fidList, List<Integer> foidList,long time) {
		// TODO Auto-generated method stub
		List<Flow> list = null;
		if(fidList.size()==0){
			fidList.add(-1);
		}
		if(foidList.size()==0){
			foidList.add(-1);
		}
		Map map = new HashMap<String, Integer>();
		map.put("fidList", fidList);
		map.put("foidList", foidList);
		map.put("time", time);
		try {
			list = sqlMapclient.queryForList("flow.getJoinFlowwerFlowList",map);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public void insertFlow(Flow flow) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.insert("flow.insertFlow", flow);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public void updateFlow(Flow flow) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.update("flow.updateFlow", flow);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}
	public Flow getNewFlowByFID(int type,int foreign_id){
		Flow flow=new Flow();
		flow.setType(type);
		flow.setForeign_id(foreign_id);
        try {
        	Object obj=sqlMapclient.queryForObject("flow.getNewFlowByFID", flow);
        	if(obj!=null){
        		flow=(Flow)obj;
        	}else{
        		flow=null;
        	}
        } catch (SQLException e) {
            e.printStackTrace();
        }
		return flow;
	}
	
	public List<Flow> getFIDsByType(int type) {
		// TODO Auto-generated method stub
		List<Flow> list = null;
        try {
            list = sqlMapclient.queryForList("flow.getFIDsByType",type);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	public Flow getFlowByOperation(Flow flow){
		Flow flow2=null;
		try {
			Object object=sqlMapclient.queryForObject("flow.getFlowByOperation",flow);
			if(object!=null){
				flow2=(Flow)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flow2;
	}
	public boolean checkIsJoin(Flow flow){
		int num=0;
		try {
			Object object=sqlMapclient.queryForObject("flow.checkIsJoin",flow);
			if(object!=null){
				num=(Integer)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num!=0;
	}
	public boolean checkTravelDelay(int foreign_id){
		try {
			Object object=sqlMapclient.queryForObject("flow.checkTravelDelay",foreign_id);
			if(object!=null){
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	public void delSomeFlow(Map map){
		try {
			sqlMapclient.delete("flow.delSomeFlow",map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public List<Flow> getSomeFlow(Map map){
		List<Flow> list = null;
        try {
            list = sqlMapclient.queryForList("flow.getSomeFlow",map);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	@Override
	public List<Integer> getForeignIDByUid(int uid) {
		// TODO Auto-generated method stub
		List<Integer> list = null;
		try {
            list = sqlMapclient.queryForList("flow.getForeignIDByUid",uid);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	@Override
	public List<Integer> getFidByPositionID(int position_id) {
		// TODO Auto-generated method stub
		List<Integer> list = null;
		try {
            list = sqlMapclient.queryForList("flow.getFidByPositionID",position_id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	@Override
	public void deleteByPerformanceOP(int foreign_id) {
		// TODO Auto-generated method stub
		Flow flow=new Flow();
		flow.setForeign_id(foreign_id);
		try {
			sqlMapclient.delete("flow.deleteByPerformanceOP", flow);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public void updateFlowOperation(Flow flow) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.update("flow.updateFlowOperation", flow);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}
	@Override
	public void updateFlowOperationByFid(int id) {
		// TODO Auto-generated method stub
		Flow flow=new Flow();
		flow.setForeign_id(id);
		flow.setOperation(5);
		try {
            sqlMapclient.update("flow.updateFlowOperationByFid", flow);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	/**
	 * 通过foreign_id查询所有流程中相关的人
	 *
	 * @param foreign_id
	 * @return
	 */
	@Override
	public List<Integer> getUidByForeign(int foreign_id) {
		List<Integer> list = null;
		try {
			list = sqlMapclient.queryForList("flow.getUidByForeign",foreign_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
}
