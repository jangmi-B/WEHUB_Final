package com.kh.wehub.approval.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.kh.wehub.approval.model.service.ApprovalService;
import com.kh.wehub.approval.model.vo.Approval;
import com.kh.wehub.board.model.vo.Board;
import com.kh.wehub.common.util.PageInfo;
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
		
		Date date = new Date();
		//DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT, locale);

		//String formattedDate = dateFormat.format(date);

		SimpleDateFormat format = new SimpleDateFormat("yyyy 년 MM 월 dd 일");
		
		String today =  format.format(date);

		model.addObject("serverTime", today);
		
		List<Member> memberList = null;
		
		memberList = service2.selectMemberAll(loginMember.getUser_id());
		
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
		
		memberList = service2.selectSearchedMember(searchData, loginMember.getUser_id());
		
		
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
	
	@ResponseBody
	@RequestMapping(value="/search/json", method = {RequestMethod.GET})
	public String searchJson(@RequestParam(value="userName") String userName) {
		System.out.println(userName);
		
		List<Member> memSearch = service2.getSearchMember(userName);
		
		JsonArray array = new JsonArray();
		for(int i=0; i < memSearch.size(); i++) {
			array.add(memSearch.get(i).getUser_name() + "_" + memSearch.get(i).getRank() + "_" +memSearch.get(i).getDept_code());
		}
		
		System.out.println("JsonArray : " + array);
		
		Gson gson = new Gson();
	
		return gson.toJson(array);	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(value = "/expenseReport", method = { RequestMethod.GET })
	public String expenseReport(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/expenseReport";
	}
	
	@RequestMapping(value = "/expenseReportView", method = { RequestMethod.GET })
	public String expenseReportView(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/expenseReportView";
	}
	
	@RequestMapping(value = "/leaveApplicationView", method = { RequestMethod.GET })
	public String leaveApplicationView(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		return "/approval/leaveApplicationView";
	}
	
}
