package com.kh.wehub.schedule.model.service;

import java.util.List;

import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.schedule.model.vo.DateData;

public interface ScheduleService {

	List<DateData> selectCalendar(Member loginMember);

}
