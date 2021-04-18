package com.kh.wehub.schedule.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.wehub.schedule.model.vo.DateData;
import com.kh.wehub.schedule.model.vo.DeptData;


@Mapper
public interface ScheduleDao {

	List<DateData> selectCalendar(Map<Object, Object> map);
	List<DeptData> selectDeptCalendar(Map<Object, Object> map);

	int insertCalendar(Map<Object, Object> map);
	int updateCalendar(Map<Object, Object> map);
	
	List<DeptData> selectAppCalendar(Map<Object, Object> map);

}
