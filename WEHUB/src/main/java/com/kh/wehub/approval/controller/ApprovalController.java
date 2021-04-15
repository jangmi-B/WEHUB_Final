package com.kh.wehub.approval.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.kh.wehub.approval.model.service.ApprovalService;
import com.kh.wehub.approval.model.vo.Approval;
import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.service.MemberService;
import com.kh.wehub.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/approval")
@SessionAttributes("loginMember")
public class ApprovalController {
	@Autowired
	private ApprovalService service;
	
	@Autowired
	private MemberService service2;
	
	/** 메인화면 */
	
	@RequestMapping(value="/approvalMain", method={RequestMethod.GET})
	public ModelAndView approvalMain(@SessionAttribute(name = "loginMember", required = false)
															Member loginMember, ModelAndView model) {
		
		int approvalCount_YET = service.approvalCount_YET(loginMember);
		int approvalCount_UNDER = service.approvalCount_UNDER(loginMember);
		int approvalCount_DONE = service.approvalCount_DONE(loginMember);
		
		List<Approval> mainList = null;
		
		List<Approval> mainList1 = null;
		
		System.out.println(approvalCount_YET);
		System.out.println(approvalCount_UNDER);
		System.out.println(approvalCount_DONE);
		
		mainList = service.getRecentList(loginMember);
		
		mainList1 = service.getRecentList1(loginMember);
		
		System.out.println("mainList : " + mainList);
		
		model.addObject("mainList", mainList);
		model.addObject("mainList1", mainList1);
		model.addObject("countYet", approvalCount_YET);
		model.addObject("countUnder", approvalCount_UNDER);
		model.addObject("countDone", approvalCount_DONE);
		model.setViewName("approval/approvalMain");
		
		return model;
	}
	
	/** 결재리스트 */
	
	@RequestMapping(value="/approvalList", method={RequestMethod.GET})
	public ModelAndView approvalList(ModelAndView model,
						@RequestParam(value = "page", required = false, defaultValue = "1") int page,
						@RequestParam(value = "listLimit", required = false, defaultValue = "10") int listLimit,
						@RequestParam(value = "notice_search", required=false)String searchText) {
	
		List<Approval> mainList2 = null;
		
		int listCount = service.getListCount(searchText);
		
		PageInfo pageInfo = new PageInfo(page, 10, listCount, listLimit);
		
		mainList2 = service.getApprovalList(pageInfo, searchText);
		
		System.out.println("mainList2 : " + mainList2);
		
		if(searchText != null) {
			model.addObject("notice_search",searchText);
		}
		
		model.addObject("mainList", mainList2);
		model.addObject("pageInfo", pageInfo);
		
		model.setViewName("approval/approvalList");
		
		return model;
	}
	
	/** 수신참조자 모달 내 멤버 리스트 불러오기 (leaveApplication) */
	
	/*
	 * @RequestMapping(value = "/leaveApplication", method = { RequestMethod.GET })
	 * public ModelAndView leaveApplication(@SessionAttribute(name = "loginMember",
	 * required = false) Member loginMember, ModelAndView model, Member member) {
	 * 
	 * List<Member> memberList = null;
	 * 
	 * memberList = service2.selectMemberAll(loginMember.getUser_id());
	 * 
	 * model.addObject("memberList", memberList);
	 * model.setViewName("approval/leaveApplication");
	 * 
	 * return model; }
	 */
	
	/** 수신참조자 모달 내 멤버 리스트 불러오기 (letterOfApproval) */
	
	@RequestMapping(value = "/letterOfApproval", method = { RequestMethod.GET })
	public ModelAndView letterOfApproval(@SessionAttribute(name = "loginMember", required = false) 
												Member loginMember, ModelAndView model, Member member) {
		
		System.out.println("loginMember : " + loginMember);
		
		Date date = new Date();
		//DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT, locale);

		//String formattedDate = dateFormat.format(date);

		SimpleDateFormat format = new SimpleDateFormat("yyyy 년 MM 월 dd 일");
		
		String today =  format.format(date);

		model.addObject("serverTime", today);
		
		List<Member> memberList = null;
		
		memberList = service2.selectMemberAllForApproval(loginMember.getUser_id());
		
		System.out.println("memberList : " + memberList);
		
		model.addObject("memberList", memberList);
		model.setViewName("approval/letterOfApproval");
		
		return model;
	}
	
	@RequestMapping(value = "/letterOfApproval", method = { RequestMethod.POST })
	public ModelAndView letterOfApprovalWrite(@SessionAttribute(name = "loginMember", required = false) Member loginMember,
											Approval approval, ModelAndView model
											/*HttpServletRequest request, @RequestParam("") MultipartFile upfile*/) {
		int result = 0;
		int result2 = 0;
		int result3 = 0;
		
//		System.out.println(upfile.getOriginalFilename());
//		
//		if(upfile != null && !upfile.isEmpty()) {
//			String renameFileName = saveFile(upfile, request);
//			
//			System.out.println(renameFileName);
//			
//			if(renameFileName != null) {
//				member.setUser_imgOriname(upfile.getOriginalFilename());
//				member.setUser_imgRename(renameFileName);
//				
//				System.out.println(", imgOriname : " + member.getUser_imgOriname() + " / imgRename : " + member.getUser_imgRename());
//			}
//		}
		
		approval.setAppWriterNo(loginMember.getUser_no());

		result = service.saveLetterOfApproval(approval);
		
		approval.setLoaAppNo(approval.getAppNo());
		
		result2 = service.saveLetterOfApproval2(approval);
		
		approval.setReceiveRefAppNo(approval.getAppNo());
		
		result3 = service.saveLetterOfApproval3(approval);
		
		if (result > 0 && result2 > 0 && result3 > 0) {
			model.addObject("msg", "품의서가 정상적으로 등록되었습니다.");
			model.addObject("location", "/approval/approvalList");
		} else {
			model.addObject("msg", "품의서 등록에 실패하였습니다.");
			model.addObject("location", "/");
		}

		model.setViewName("common/msg");

		return model;
	}
	
	@RequestMapping(value="/letterOfApprovalView", method={RequestMethod.GET})
	public ModelAndView letterOfApprovalView(@RequestParam("appNo") int appNo, ModelAndView model) {
		Approval approval = service.findListByNo(appNo);
		
		System.out.println(approval);
		
		model.addObject("approval", approval);
		model.setViewName("/approval/letterOfApprovalView");
		
		return model;
	}
	
	
	/** 수신참조자 모달 내 검색 */
	
	@ResponseBody
	@RequestMapping(value = "/searchMemberInModal", method = { RequestMethod.GET })
	public List<Member> searchMemberInModal(@SessionAttribute(name = "loginMember", required = false) 
												Member loginMember, Member member,
												@RequestParam(value="searchData") String searchData) {
		
		System.out.println("searchData : " + searchData);
		
		List<Member> memberList = null;

		System.out.println("loginMember.getUser_id() : " + loginMember.getUser_id());
		
		memberList = service2.selectSearchedMemberForApproval(searchData, loginMember.getUser_id());
		
		
		return memberList;
	}
	
	@ResponseBody
	@RequestMapping(value = "/letterOfApprovalUpdate", method = { RequestMethod.POST })
	public int letterOfApprovalUpdate(@SessionAttribute(name = "loginMember", required = false) 
												Member loginMember, Approval approval,
												@RequestParam(value="rejectReasonText") String rejectReasonText,
												@RequestParam(value="appNo") int appNo) {
		int result = 0;
		
		approval.setAppNo(appNo);
		approval.setAppReason(rejectReasonText);
		
		System.out.println("appNo : " + appNo);
		System.out.println("rejectReasonText : " + rejectReasonText);
		System.out.println("approval.getAppNo() : " + approval.getAppNo());
		System.out.println("approval.getAppReason() : " + approval.getAppReason());
		
		
		if(rejectReasonText != null) {
			if(approval.getAppNo() != 0) {
				result = service.rejectUpdate(approval);
				System.out.println("result: " + result);
			}
		} else {
			
		}
		
		return result;
	}
	
	// 자동완성
	@ResponseBody
	@RequestMapping(value="/search/json", method = {RequestMethod.GET})
	public String searchJson(@RequestParam(value="userName") String userName) {
		System.out.println(userName);
		List<Member> memSearch = service2.getSearchMember(userName);
		
		JsonArray array = new JsonArray();
		for(int i=0; i < memSearch.size(); i++) {
			array.add(memSearch.get(i).getUser_name() + "_" + memSearch.get(i).getRank() + "_" +memSearch.get(i).getDept_code());
		}
		
		System.out.println(array);
		
		Gson gson = new Gson();
	
		return gson.toJson(array);	
	}
	
	@ResponseBody
	@RequestMapping(value = "/loaApproved1", method = { RequestMethod.POST })
	public int loaApproved1(@SessionAttribute(name = "loginMember", required = false) 
												Member loginMember, @RequestParam(value="appNo") int appNo) {
		int result = 0;
		result = service.approved1(appNo);

		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/loaApproved2", method = { RequestMethod.POST })
	public int loaApproved2(@SessionAttribute(name = "loginMember", required = false) 
												Member loginMember, @RequestParam(value="appNo") int appNo) {
		int result = 0;
		result = service.approved2(appNo);

		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/loaApproved3", method = { RequestMethod.POST })
	public int loaApproved3(@SessionAttribute(name = "loginMember", required = false) 
												Member loginMember, @RequestParam(value="appNo") int appNo) {
		int result = 0;
		result = service.approved3(appNo);

		return result;
	}
	
	
	// 휴가신청서
	@RequestMapping("/leaveApplication")
	public String leaveApplication(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/leaveApplication";
	}
	
	@RequestMapping(value="/updateLeave", method= {RequestMethod.POST})
	public ModelAndView insertLeave(ModelAndView model, HttpServletRequest request,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember,
			Approval approval) {
		
		log.info("휴가 신청서 작성 컨트롤러 : " + approval);
		int result = 0;
		int result2 = 0;
		int result3 = 0;
		
		approval.setAppWriterNo(loginMember.getUser_no());
		
		System.out.println(approval.getAppWriterNo() + "\n" + approval + "\n" + approval);
		if(loginMember.getUser_no() == approval.getAppWriterNo()) {
			System.out.println(loginMember.getUser_no() + " ,\n" + approval.getAppWriterNo());
			result = service.insertApproval(approval);
			
			approval.setLeaveAppNo(approval.getAppNo());
			approval.setReceiveRefAppNo(approval.getAppNo());
			
			System.out.println("approval.getReceiveRefAppNo() : " + approval.getReceiveRefAppNo());

			result2 = service.insertLeave(approval);
			result3 = service.insertReceive(approval);
			
//			System.out.println("97번줄 : " + appLeave.getLeaveAppNo());
//			System.out.println("101 result : " + result + "\nresult2 : " + result2);
			
			if (result > 0 && result2 > 0 && result3 > 0) {
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
	
	/** 수신참조자 모달 내 멤버 리스트 불러오기 (leaveApplication) */
	
	@RequestMapping(value = "/leaveApplication", method = { RequestMethod.GET })
	public ModelAndView leaveApplication(@SessionAttribute(name = "loginMember", required = false) 
												Member loginMember, ModelAndView model, Member member) {
		
		System.out.println("loginMember : " + loginMember);
		
		List<Member> memberList = null;
		
		memberList = service2.selectMemberAllForApproval(loginMember.getUser_id());
		
		System.out.println("memberList : " + memberList);
		
		model.addObject("memberList", memberList);
		model.setViewName("approval/leaveApplication");
		
		return model;
	}
	
	/** 수신참조자 모달 내 멤버 리스트 불러오기 (expenseReport) */
	
	@RequestMapping(value = "/expenseReport", method = { RequestMethod.GET })
	public ModelAndView expenseReport(@SessionAttribute(name = "loginMember", required = false) 
												Member loginMember, ModelAndView model, Member member) {
		
		System.out.println("loginMember : " + loginMember);
		
		List<Member> memberList = null;
		
		memberList = service2.selectMemberAllForApproval(loginMember.getUser_id());
		
		System.out.println("memberList : " + memberList);
		
		model.addObject("memberList", memberList);
		model.setViewName("approval/expenseReport");
		
		return model;
	}
	
	@RequestMapping(value = "/expenseReport", method = { RequestMethod.POST })
	public ModelAndView expenseReportWrite(@SessionAttribute(name = "loginMember", required = false) Member loginMember,
											Approval approval, ModelAndView model) {
		int result = 0;
		int result2 = 0;
		int result3 = 0;
		
		approval.setAppWriterNo(loginMember.getUser_no());

		result = service.saveExpenseReport(approval);
		
		approval.setErAppNo(approval.getAppNo());
		
		result2 = service.saveExpenseReport2(approval);
		
		approval.setReceiveRefAppNo(approval.getAppNo());
		
		result3 = service.saveExpenseReport3(approval);
		
		if (result > 0 && result2 > 0 && result3 > 0) {
			model.addObject("msg", "지출결의서가 정상적으로 등록되었습니다.");
			model.addObject("location", "/approval/approvalList");
		} else {
			model.addObject("msg", "지출결의서 등록에 실패하였습니다.");
			model.addObject("location", "/");
		}

		model.setViewName("common/msg");

		return model;
	}
	
	@RequestMapping(value="/expenseReportView", method={RequestMethod.GET})
	public ModelAndView expenseReportView(@RequestParam("appNo") int appNo, ModelAndView model) {
		
		Approval approval = service.findExpenseReportListByNo(appNo);
		System.out.println("expenseReportView : " + approval);
		
		
		/*
		 * String erDetailStr = approval.getErDetail();
		 * System.out.println("erDetailStr : " + erDetailStr);
		 * 
		 * String erReferenceStr = approval.getErReference();
		 * System.out.println("erReferenceStr : " + erReferenceStr);
		 * 
		 * String erAmountStr = approval.getErAmount();
		 * System.out.println("erAmountStr : " + erAmountStr);
		 * 
		 * List<Map> erList = new ArrayList<Map>(); erList.clear();
		 * 
		 * HashMap<String, Object> map = new HashMap<String, Object>();
		 * 
		 * map.put("approval", approval);
		 * 
		 * erList.add(map);
		 * 
		 * model.addObject("erList",erList);
		 */
		

		model.addObject("approval", approval);	
		model.setViewName("/approval/expenseReportView");
		
		return model;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(value = "/leaveApplicationView", method = { RequestMethod.GET })
	public String leaveApplicationView(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/leaveApplicationView";
	}
	
}