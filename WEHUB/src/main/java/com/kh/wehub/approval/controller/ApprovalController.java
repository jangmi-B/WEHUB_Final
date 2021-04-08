package com.kh.wehub.approval.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wehub.approval.model.service.ApprovalService;
import com.kh.wehub.approval.model.vo.App_Leave;
import com.kh.wehub.approval.model.vo.Approval;
import com.kh.wehub.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/approval")
@SessionAttributes("approval")
public class ApprovalController {
	
	@Autowired
	private ApprovalService service;
	
	//결재 메인
	@RequestMapping(value = "/approvalMain", method = { RequestMethod.GET })
	public String approvalMain(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/approvalMain";
	}
		
	//결재 리스트
	@RequestMapping(value = "/approvalList", method = { RequestMethod.GET })
	public String approvalList(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/approvalList";
	}
	
	// 품의서
	@RequestMapping(value = "/letterOfApproval", method = { RequestMethod.GET })
	public String letterOfApproval(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/letterOfApproval";
	}
	
	// 지출결의서
	@RequestMapping(value = "/expenseReport", method = { RequestMethod.GET })
	public String expenseReport(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/expenseReport";
	}
	
	// 휴가신청서
	@RequestMapping("/leaveApplication")
	public String leaveApplication(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/leaveApplication";
	}
	
	@RequestMapping(value="/update/leave", method= {RequestMethod.POST})
	public ModelAndView insertLeave(ModelAndView model, HttpServletRequest request,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember,
			@SessionAttribute(name = "Approval", required = false) Approval approval,
			@SessionAttribute(name = "App_Leave", required = false) App_Leave appLeave
			) {
		
		log.info("휴가 신청서 작성 페이지 요청");
		int result = 0;
		int result2 = 0;
		
		approval.setAppWriterNo(loginMember.getUser_no());
		
		System.out.println(approval);
		System.out.println(appLeave);
		
		if(loginMember.getUser_no() == approval.getAppWriterNo()) {
			
			result = service.insertApproval(approval);
			result2 = service.insertLeave(appLeave);
			
			if(result > 0 && result2 > 0) {
				model.addObject("msg", "휴가신청서가 정상적으로 등록되었습니다.");
				model.addObject("location", "/approval/approvalList");
			} else {
				model.addObject("msg", "결재서류 등록을 실패하였습니다.");
				model.addObject("location", "/approval/approvalList");
			}
		}
		
		model.addObject("Approval", appLeave); // <- ?
		
		return model;
	}
	
	@RequestMapping("approval/searchMember")
	@ResponseBody
	public Object idCheck(@RequestParam("searchText")String searchText) {
		
		Map<String, Object> map = new HashMap<>();
		
//		map.put("validate", service.validate(searchText));
		
		System.out.println(map);
		
		return map;
	}
}