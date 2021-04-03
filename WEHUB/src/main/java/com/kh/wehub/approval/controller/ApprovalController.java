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

	@RequestMapping(value = "/letterOfApproval", method = { RequestMethod.GET })
	public String approvalView(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/letterOfApproval";
	}
}
