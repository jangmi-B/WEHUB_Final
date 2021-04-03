package com.kh.wehub.approval.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wehub.approval.model.service.ApprovalService;
import com.kh.wehub.member.model.service.MemberService;
import com.kh.wehub.member.model.vo.Member;

@Controller
@RequestMapping("/approval")
@SessionAttributes("loginMember")
public class ApprovalController {
   /* @Autowired */
   private ApprovalService service;
   
   @Autowired
   private MemberService service2;

   @RequestMapping(value = "/approval", method = { RequestMethod.GET })
   public String approvalView(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
      
      return "/approval/approval";
   }
}