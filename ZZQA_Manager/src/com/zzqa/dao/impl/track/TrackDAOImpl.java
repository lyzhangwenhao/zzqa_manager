package com.zzqa.dao.impl.track;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.track.ITrackDAO;
import com.zzqa.pojo.track.Track;
@Component("trackDAO")
public class TrackDAOImpl implements ITrackDAO {
	SqlMapClient sqlMapclient = null;
	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")  
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	@Override
	public void insertTrack(Track track) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("track.insertTrack",track);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void updateTrack(Track track) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("track.updateTrack", track);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public int getNewTrackByCreateID(int create_id) {
		// TODO Auto-generated method stub
		int id=0;
		try {
			Object obj=sqlMapclient.queryForObject("track.getNewTrackByCreateID", create_id);
			if(obj!=null){
				id=(Integer)obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return id;
	}
	@Override
	public Track getSaveTrackByMonth(Track track) {
		// TODO Auto-generated method stub
		Track track2=null;
		try {
			Object obj=sqlMapclient.queryForObject("track.getSaveTrackByMonth", track);
			if(obj!=null){
				track2=(Track)obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return track2;
	}
	@Override
	public Track getTrackByID(int id) {
		// TODO Auto-generated method stub
		Track track=null;
		try {
			Object obj=sqlMapclient.queryForObject("track.getTrackByID", id);
			if(obj!=null){
				track=(Track)obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return track;
	}

	public List getRunningTrack() {
		List<Track> list = null;
		try {
            list = sqlMapclient.queryForList("track.getRunningTrack");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	public List getFinishTrackByCreateID(int create_id){
		List<Track> list = null;
		Map map=new HashMap();
		map.put("create_id", create_id);
		try {
            list = sqlMapclient.queryForList("track.getFinishTrackByCreateID",map);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	@Override
	public List getAllList(){
		List list = null;
		try {
            list = sqlMapclient.queryForList("track.getAllList");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
}
