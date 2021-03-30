package com.kh.wehub.schedule.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.schedule.model.service.ScheduleService;
import com.kh.wehub.schedule.model.vo.DateData;

@Controller
@SessionAttributes("loginMember")
public class CalendarController {
	
	@Autowired
	private ScheduleService service;

	
	@RequestMapping(value = "calendar/view", method = {RequestMethod.GET})
	public String calendar(Model model, HttpServletRequest request, DateData dateData,
			@SessionAttribute("loginMember") Member loginMember){
		
		Calendar cal = Calendar.getInstance();
		DateData calendarData;
		//검색 날짜
		if(dateData.getDate().equals("")&&dateData.getMonth().equals("")){
//			dateData = new DateData(String.valueOf(cal.get(Calendar.YEAR)),String.valueOf(cal.get(Calendar.MONTH)),String.valueOf(cal.get(Calendar.DATE)),null);
			dateData = new DateData(0,0,String.valueOf(cal.get(Calendar.YEAR)),String.valueOf(cal.get(Calendar.MONTH)),String.valueOf(cal.get(Calendar.DATE)),null,"",null);
		}
		//검색 날짜 end

		Map<String, Integer> today_info =  dateData.today_info(dateData);
		List<DateData> dateList = new ArrayList<DateData>();
		
		//실질적인 달력 데이터 리스트에 데이터 삽입 시작.
		//일단 시작 인덱스까지 아무것도 없는 데이터 삽입
		for(int i=1; i<today_info.get("start"); i++){
			calendarData= new DateData(0,0,"", "", "", "", "", null);
			dateList.add(calendarData);
		}
		
		//날짜 삽입
		for (int i = today_info.get("startDay"); i <= today_info.get("endDay"); i++) {
			if(i==today_info.get("today")){
				calendarData= new DateData(0,0,String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "today", "", null);
			}else{
				calendarData= new DateData(0,0,String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "normal_date", "", null);
			}
			dateList.add(calendarData);
		}

		//달력 빈곳 빈 데이터로 삽입
		int index = 7-dateList.size()%7;
		
		if(dateList.size()%7!=0){
			
			for (int i = 0; i < index; i++) {
				calendarData= new DateData(0,0,"", "", "", "", "", null);
				dateList.add(calendarData);
			}
		}
		
		//여기서부터 건드림
		List<DateData> list = service.selectCalendar(loginMember);
		
//		System.out.println(today_info.get("today"));
//		System.out.println(today_info.get("search_year"));
//		System.out.println(today_info.get("search_month"));
//		System.out.println(today_info.get("start")); // 1일이 시작되는 첫번째 칸 번호
//		System.out.println(today_info.get("startDay")); // 1
//		System.out.println(today_info.get("endDay")); // 그 달의 마지막 일
//		
		
		for(int i = 0; i < dateList.size(); i++) {
			for(int j = 0; j < list.size(); j++) {
				if(dateList.get(i).getYear().equals(list.get(j).getYear())) {
					if(Integer.parseInt(dateList.get(i).getMonth()) == Integer.parseInt(list.get(j).getMonth())-1) {
						if(dateList.get(i).getDate().equals(list.get(j).getDate())) {
							dateList.get(i).setSchedule_content(list.get(j).getSchedule_content());
						}
					}
				}
			}
		}
		
		//배열에 담음
		model.addAttribute("dateList", dateList);		//날짜 데이터 배열
		model.addAttribute("today_info", today_info);
		
		return "/schedule/calendar";
	}
}
