package com.zzqa.service.interfaces.track;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.linkman.Linkman;
import com.zzqa.pojo.track.Track;
import com.zzqa.pojo.user.User;

public interface TrackManager {
	public void insertTrack(Track track);
	public void updateTrack(Track track);
	public int getNewTrackByCreateID(int create_id);
	public Track getTrackByID(int id);
	//返回当前月添加的状态
	public Track getSaveTrackByMonth(int create_id,long state_time);
	public List<Track> getTrackListByUID(User user);
	/******
	 * 描绘
	 * @param leave_id
	 * @return
	 */
	public Map<String, String>getTrackFlowForDraw(Track track,Flow flow);
	public Track getTrackByID2(int id);
	/*****
	 * user==null 搜全部，user！=null搜本人
	 * @param users
	 * @param user
	 * @param starttime
	 * @param endtime
	 * @param keywords
	 * @return
	 */
	public  Map<Integer,List<Linkman>> getTrackReport(User user,long starttime,long endtime,String keywords);
}
