package com.kh.wehub.schedule.controller;


import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.schedule.model.service.ScheduleService;
import com.kh.wehub.schedule.model.vo.DeptData;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@SessionAttributes("loginMember")
public class DeptCalendarController {

	@Autowired
	private ScheduleService service;

	@RequestMapping(value = "dept/view", method = { RequestMethod.GET })
	public String DeptCaledndar(HttpServletRequest request, @SessionAttribute("loginMember") Member loginMember) {
		
		return "schedule/DeptCalendar";

	}

	@RequestMapping(value = "/dept/listview", method = { RequestMethod.GET })
	@ResponseBody
	public Object listview(@SessionAttribute("loginMember") Member loginMember, DeptData deptdata, Model model,
			HttpServletRequest request)

	{
		log.info("listview");
		Map<String, Object> map = new HashMap<>();
		map.put("deptcalendar", service.selectDeptCalendar(loginMember));
		map.put("app",service.selectAppCalendar(loginMember));
		
		System.out.println("controller 찍어보기 : "+service.selectDeptCalendar(loginMember));
	    log.info("controller selectAppCalendar 찍어보기 : "+service.selectAppCalendar(loginMember));
		System.out.println(map);

		return map;
	}

}
