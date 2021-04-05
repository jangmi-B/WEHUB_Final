package com.kh.wehub.approval.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wehub.approval.model.service.ApprovalService;
import com.kh.wehub.approval.model.vo.Approval;
import com.kh.wehub.member.model.vo.Member;

@Controller
@RequestMapping("/approval")
@SessionAttributes("loginMember")
public class ApprovalController {
	@Autowired
	private ApprovalService service;
	
	@RequestMapping(value="/approvalMain", method={RequestMethod.GET})
	public ModelAndView approvalMain(ModelAndView model) {
		
		int approvalMainCount = service.getApprovalMainCount();
		
		List<Approval> mainList = null;
		
		System.out.println(approvalMainCount);
		
		mainList = service.getApprovalMainList();
		
		model.addObject("mainList", mainList);
		model.addObject("mainCount", approvalMainCount);
		model.setViewName("approval/approvalMain");
		
		return model;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(value = "/approvalList", method = { RequestMethod.GET })
	public String approvalList(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/approvalList";
	}
	
	@RequestMapping(value = "/letterOfApproval", method = { RequestMethod.GET })
	public String letterOfApproval(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/letterOfApproval";
	}
	
	@RequestMapping(value = "/expenseReport", method = { RequestMethod.GET })
	public String expenseReport(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/expenseReport";
	}
	
	@RequestMapping(value = "/leaveApplication", method = { RequestMethod.GET })
	public String leaveApplication(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/leaveApplication";
	}
}
