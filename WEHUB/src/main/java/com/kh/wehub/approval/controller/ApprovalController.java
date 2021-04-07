package com.kh.wehub.approval.controller;

import java.util.List;

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
import com.kh.wehub.approval.model.vo.Approval;
import com.kh.wehub.member.model.service.MemberService;
import com.kh.wehub.member.model.vo.Member;

@Controller
@RequestMapping("/approval")
@SessionAttributes("loginMember")
public class ApprovalController {
	@Autowired
	private ApprovalService service;
	
	@Autowired
	private MemberService service2;
	
	@RequestMapping(value="/approvalMain", method={RequestMethod.GET})
	public ModelAndView approvalMain(@SessionAttribute(name = "loginMember", required = false)
															Member loginMember, ModelAndView model) {
		
		int approvalCount_YET = service.approvalCount_YET(loginMember);
		int approvalCount_UNDER = service.approvalCount_UNDER(loginMember);
		int approvalCount_DONE = service.approvalCount_DONE(loginMember);
		
		List<Approval> mainList = null;
		
		System.out.println(approvalCount_YET);
		System.out.println(approvalCount_UNDER);
		System.out.println(approvalCount_DONE);
		
		mainList = service.getRecentList(loginMember);
		
		System.out.println("mainList : " + mainList);
		
		model.addObject("mainList", mainList);
		model.addObject("countYet", approvalCount_YET);
		model.addObject("countUnder", approvalCount_UNDER);
		model.addObject("countDone", approvalCount_DONE);
		model.setViewName("approval/approvalMain");
		
		return model;
	}
	
	@RequestMapping(value="/approvalList", method={RequestMethod.GET})
	public ModelAndView approvalList(@SessionAttribute(name = "loginMember", required = false)
															Member loginMember, ModelAndView model) {
	
		List<Approval> mainList2 = null;
		
		mainList2 = service.getApprovalList(loginMember);
		
		model.addObject("mainList", mainList2);
		model.setViewName("approval/approvalList");
		
		return model;
	}
	
	@RequestMapping(value = "/letterOfApproval", method = { RequestMethod.GET })
	public ModelAndView letterOfApproval(@SessionAttribute(name = "loginMember", required = false) 
												Member loginMember, ModelAndView model, Member member) {
		
		List<Member> memberList = null;
		
		memberList = service2.selectMemberAll(loginMember.getUser_id());
		
		model.addObject("memberList", memberList);
		model.setViewName("approval/letterOfApproval");
		
		return model;
	}
	
	@ResponseBody
	@RequestMapping(value = "/searchMemberInModal", method = { RequestMethod.GET })
	public List<Member> searchMemberInModal(@SessionAttribute(name = "loginMember", required = false) 
												Member loginMember, Member member,
												@RequestParam(value="searchData") String searchData) {
		
		System.out.println("searchData : " + searchData);
		
		List<Member> memberList = null;

		System.out.println("loginMember.getUser_id() : " + loginMember.getUser_id());
		
		memberList = service2.selectSearchedMember(searchData, loginMember.getUser_id());
		
		
		return memberList;
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
