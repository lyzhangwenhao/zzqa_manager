package com.zzqa.service.impl.track;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.linkman.ILinkmanDAO;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.track.ITrackDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.linkman.Linkman;
import com.zzqa.pojo.resumption.Resumption;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.track.Track;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.track.TrackManager;
import com.zzqa.util.DataUtil;
@Component("trackManager")
public class TrackManagerImpl implements TrackManager {
	@Autowired
	private ITrackDAO trackDAO;
	@Autowired
	private ILinkmanDAO linkmanDAO;
	@Autowired
	private IUserDAO userDAO;
	@Autowired
	private IPermissionsDAO permissionsDAO;
	@Autowired
	private IFlowDAO flowDAO;
	
	@Override
	public void insertTrack(Track track) {
		// TODO Auto-generated method stub
		trackDAO.insertTrack(track);
	}

	@Override
	public void updateTrack(Track track) {
		// TODO Auto-generated method stub
		trackDAO.updateTrack(track);
	}

	@Override
	public int getNewTrackByCreateID(int create_id) {
		// TODO Auto-generated method stub
		return trackDAO.getNewTrackByCreateID(create_id);
	}
	@Override
	public Track getTrackByID(int id) {
		// TODO Auto-generated method stub
		Track track=trackDAO.getTrackByID(id);
		track.setCreate_name(userDAO.getUserNameByID(track.getCreate_id()));
		track.setState_date(new SimpleDateFormat("yyyy年MM月").format(track.getState_time()));
		return track;
	}
	@Override
	public Track getSaveTrackByMonth(int create_id,long state_time) {
		// TODO Auto-generated method stub
		Track track1=new Track();
		track1.setCreate_id(create_id);
		track1.setState_time(state_time);
		Track track=trackDAO.getSaveTrackByMonth(track1);
		return track;
	}
	private boolean checkMyOperation(int operation,User user,Track track){
		boolean flag=false;
 		switch (operation) {
		case 1:
			List<User> parentList=userDAO.getParentListByChildUid(track.getCreate_id());
			if(parentList.size()>0){
				flag=parentList.get(0).getId()==user.getId();
			}
			break;
		case 3://审批未通过
			flag=user.getId()==track.getCreate_id();
			break;
		default:
			break;
 		}
 		return flag;
	}
	@Override
	public List<Track> getTrackListByUID(User user) {
		// TODO Auto-generated method stub
		List<Track> trackList=trackDAO.getRunningTrack();
		SimpleDateFormat format = new SimpleDateFormat( "yyyy.MM.dd" );
		String[] flowArray=DataUtil.getFlowArray(10);
		Iterator<Track> iterator=trackList.iterator();
		while (iterator.hasNext()) {
			Track track=(Track)iterator.next();
			User userByID = userDAO.getUserByID(track.getCreate_id());
			if(userByID==null || userByID.getPosition_id()==56){
				iterator.remove();
				continue;
			}
			Flow flow=flowDAO.getNewFlowByFID(10, track.getId());//查询最新流程
			if(flow!=null&&checkMyOperation(flow.getOperation(),user,track)){
				String process=format.format(flow.getCreate_time())+flowArray[flow.getOperation()];
				track.setProcess(process);
				track.setCreate_name(userByID.getTruename());
				track.setName(DataUtil.getNameByTime(10,
						track.getState_time()));
			}else{
				iterator.remove();
			}
		}
		return trackList;
	}
	public long lastFlowTime(int operation,List<Flow> flowList){
		int len=flowList.size();
		for (int i = 0; i < len; i++) {
			if(flowList.get(len-i-1).getOperation()==operation){
				return flowList.get(len-i-1).getCreate_time();
			}
		}
		return 0;//没有就返回0
	}
	@Override
	public Map<String, String> getTrackFlowForDraw(Track track, Flow flow) {
		// TODO Auto-generated method stub
		Map<String,String> map=new HashMap<String, String>();
		int operation=flow.getOperation();
		List<Flow> flowList=flowDAO.getFlowListByCondition(10,track.getId());
		SimpleDateFormat dft=new SimpleDateFormat("yyyy-MM-dd#HH:mm:ss");
		String class11=null;
		String class12=null;
		String class13=null;
		String img1=null;
		String img2=null;
		String img3=null;
		String time1=null;
		String time2=null;
		String time3=null;
		String class22=null;
		String class24=null;
		if(operation==1){
			class11="td2_div11_pass";
			class12="td2_div12_nodid";
			class13="td2_div13_nodid";
			img1="pass.png";
			img2="go.png";
			img3="notdid.png";
			time1=dft.format(track.getCreate_time()).replace("#", "<br/>");
			time2="";
			time3="";
			class22="td2_div2_agree";
			class24="td2_div2_nodid";
		}else if(operation==2){//结束
			class11="td2_div11_pass";
			class12="td2_div12_pass";
			class13="td2_div13_pass";
			 img1="pass.png";
			 img2="pass.png";
			 img3="pass.png";
			 time1=dft.format(track.getCreate_time()).replace("#", "<br/>");
			 time2=dft.format(lastFlowTime(2,flowList)).replace("#", "<br/>");
			 time3=time2;
			 class22="td2_div2_agree";
			 class24="td2_div2_agree";
		}else if(operation==3){
			class11="td2_div11_pass";
			class12="td2_div12_nopass";
			class13="td2_div13_nodid";
			img1="pass.png";
			img2="error.png";
			img3="notdid.png";
			time1=dft.format(track.getCreate_time()).replace("#", "<br/>");
			 time2="";
			 time3="";
			 class22="td2_div2_disagree";
			 class24="td2_div2_nodid";
		}
		map.put("class11", class11);
		map.put("class12", class12);
		map.put("class13", class13);
		map.put("img1", img1);
		map.put("img2", img2);
		map.put("img3", img3);
		map.put("time1", time1);
		map.put("time2", time2);
		map.put("time3", time3);
		map.put("class22", class22);
		map.put("class24", class24);
		return map;
	}
	@Override
	public Track getTrackByID2(int id) {
		// TODO Auto-generated method stub
		Track track = trackDAO.getTrackByID(id);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		Flow flow = flowDAO.getNewFlowByFID(10, id);// 查询最新流程
		String process = sdf.format(flow.getCreate_time())
				+ DataUtil.getFlowArray(10)[flow.getOperation()];
		int op=flow.getOperation();
		track.setName(DataUtil.getNameByTime(10,
				track.getState_time()));
		track.setProcess(process);
		track.setCreate_name(userDAO.getUserNameByID(track.getCreate_id()));
		return track;
	}
	@Override
	public Map<Integer,List<Linkman>> getTrackReport(User user, long starttime, long endtime,
			String keywords) {
		// TODO Auto-generated method stub
		Map<Integer,List<Linkman>> linkMap=new HashMap<Integer,List<Linkman>>();
		String[][] stateArray=DataUtil.getStateTrackArray();
		endtime+=86400000l;
		if(user!=null){//只搜自己
			int create_id=user.getId();
			List<Track> trackList=trackDAO.getFinishTrackByCreateID(create_id);
			List<Linkman> linkmans=new ArrayList<Linkman>();
			for (Track track : trackList) {
				linkmans.addAll(linkmanDAO.getLinkmanByCondition(10, track.getId(), starttime, endtime));
			}
			linkMap.put(create_id, linkmans);
		}else{
			//返回所有用户的信息
			List<Track> trackList=trackDAO.getFinishTrackByCreateID(0);
			for (Track track : trackList) {
				int create_id=track.getCreate_id();
				List<Linkman> linkmans=linkmanDAO.getLinkmanByCondition(10, track.getId(), starttime, endtime);
				if(linkmans.size()>0){
					if(linkMap.containsKey(create_id)){
						List<Linkman> linkmans2=linkMap.get(create_id);
						linkmans2.addAll(linkmans);
						linkmans.addAll(linkmans2);
						linkMap.put(create_id, linkmans);
					}else{
						linkMap.put(create_id, linkmans);
					}
				}
			}
		}
		return linkMap;
	}

}
