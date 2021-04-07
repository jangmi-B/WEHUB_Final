package com.kh.wehub.approval.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
		
		log.info("휴가 신청서 작성");
		int result = 0;
				
		result = service.insertApproval(approval);
		
		model.addObject("Approval", appLeave);
		
		return model;
	}
}