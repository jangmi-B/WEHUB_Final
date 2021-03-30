package com.kh.wehub.schedule.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.schedule.model.dao.ScheduleDao;
import com.kh.wehub.schedule.model.vo.DateData;

@Service
public class ScheduleServiceImpl implements ScheduleService {
	
	@Autowired
	private ScheduleDao scheduleDao;

	@Override
	public List<DateData> selectCalendar(Member loginMember) {
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("userNo", loginMember.getUser_no());
		
		
		
		return scheduleDao.selectCalendar(map);
	}

}
