package com.kh.wehub.schedule.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.wehub.schedule.model.vo.DateData;

@Mapper
public interface ScheduleDao {

	List<DateData> selectCalendar(Map<Object, Object> map);

}
