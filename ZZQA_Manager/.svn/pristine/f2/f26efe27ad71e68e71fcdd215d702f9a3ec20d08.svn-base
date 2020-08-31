package com.zzqa.dao.interfaces.track;

import java.sql.SQLException;
import java.util.List;

import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.track.Track;

public interface ITrackDAO {
	public void insertTrack(Track track);
	public void updateTrack(Track track);
	public int getNewTrackByCreateID(int create_id);
	public Track getTrackByID(int id);
	//返回当前月添加的状态
	public Track getSaveTrackByMonth(Track track);
	public List getRunningTrack();
	/*****
	 * 
	 * @param create_id 0:全部
	 * @return
	 */
	public List getFinishTrackByCreateID(int create_id);
	public List getAllList();
}
