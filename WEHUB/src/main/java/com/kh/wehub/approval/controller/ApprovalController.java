package com.kh.wehub.approval.controller;

import java.util.List;

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

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.kh.wehub.approval.model.service.ApprovalService;
import com.kh.wehub.approval.model.vo.App_Leave;
import com.kh.wehub.approval.model.vo.Approval;
import com.kh.wehub.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@SessionAttributes("loginMember")
public class ApprovalController {
	
	@Autowired
	private ApprovalService service;
	
	//결재 메인
	@RequestMapping(value = "/approval/approvalMain", method = { RequestMethod.GET })
	public String approvalMain(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/approvalMain";
	}
		
	//결재 리스트
	@RequestMapping(value = "/approval/approvalList", method = { RequestMethod.GET })
	public String approvalList(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/approvalList";
	}
	
	// 품의서
	@RequestMapping(value = "/approval/letterOfApproval", method = { RequestMethod.GET })
	public String letterOfApproval(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/letterOfApproval";
	}
	
	// 지출결의서
	@RequestMapping(value = "/approval/expenseReport", method = { RequestMethod.GET })
	public String expenseReport(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/expenseReport";
	}
	
	// 휴가신청서
	@RequestMapping("/approval/leaveApplication")
	public String leaveApplication(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/leaveApplication";
	}
	
	@RequestMapping(value="/approval/updateLeave", method= {RequestMethod.POST})
	public ModelAndView insertLeave(ModelAndView model, HttpServletRequest request,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember,
			Approval approval, App_Leave appLeave) {
		
		log.info("휴가 신청서 작성 컨트롤러 : " + approval);
		log.info("휴가 신청서 appLeave : " + appLeave);
		int result = 0;
		int result2 = 0;
		
		approval.setAppWriterNo(loginMember.getUser_no());
		
		System.out.println(approval.getAppWriterNo());
		
		System.out.println(approval + "\n" + appLeave);
		
		if(loginMember.getUser_no() == approval.getAppWriterNo()) {
			System.out.println(loginMember.getUser_no() + " ,\n" + approval.getAppWriterNo());
			result = service.insertApproval(approval);
			
			appLeave.setLeaveAppNo(approval.getAppNo());
						
			result2 = service.insertLeave(appLeave);
			
//			System.out.println("97번줄 : " + appLeave.getLeaveAppNo());
//			System.out.println("101 result : " + result + "\nresult2 : " + result2);
			
			if (result > 0 && result2 > 0) {
				model.addObject("msg", "휴가신청서가 정상적으로 등록되었습니다.");
				model.addObject("location", "/approval/approvalList");
			} else {
				model.addObject("msg", "결재서류 등록을 실패하였습니다.");
				model.addObject("location", "/approval/leaveApplication");
			}
		}
		
		model.setViewName("common/msg");
		
		return model;
	}
	
	@ResponseBody
	@RequestMapping(value="/approval/search/json", method = {RequestMethod.GET})
	public String searchJson(@RequestParam(value="userName") String userName) {
		System.out.println(userName);
		List<Member> memSearch = service.getSearchMember(userName);
		
		JsonArray array = new JsonArray();
		for(int i=0; i < memSearch.size(); i++) {
			array.add(memSearch.get(i).getUser_name() + "_" + memSearch.get(i).getRank() + "_" +memSearch.get(i).getDept_code());
		}
		
		System.out.println(array);
		
		Gson gson = new Gson();
	
		return gson.toJson(array);	
	}
}