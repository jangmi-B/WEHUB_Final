package com.kh.wehub.approval.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.wehub.member.model.vo.Member;

@Controller
@RequestMapping("/approval")
@SessionAttributes("loginMember")
public class ApprovalController {
	
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
	@RequestMapping(value = "/leaveApplication", method = { RequestMethod.GET })
	public String leaveApplication(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/leaveApplication";
	}
}