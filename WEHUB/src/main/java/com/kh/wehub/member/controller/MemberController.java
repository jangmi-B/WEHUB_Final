package com.kh.wehub.member.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import org.joda.time.DateTime;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wehub.approval.model.service.ApprovalService;
import com.kh.wehub.approval.model.vo.Approval;
import com.kh.wehub.board.model.service.BoardService;
import com.kh.wehub.board.model.vo.Notice;
import com.kh.wehub.community.model.service.CommunityService;
import com.kh.wehub.community.model.vo.Community;
import com.kh.wehub.member.model.service.MemberService;
import com.kh.wehub.member.model.service.UserMailSendService;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.memberInfo.model.vo.InsertNewMember;
import com.kh.wehub.memo.model.service.MemoService;
import com.kh.wehub.memo.model.vo.Memo;
import com.kh.wehub.message.model.service.MessageService;
import com.kh.wehub.message.model.vo.Message;
import com.kh.wehub.project.model.service.ProjectService;
import com.kh.wehub.project.model.vo.Project;
import com.kh.wehub.schedule.model.service.ScheduleService;
import com.kh.wehub.schedule.model.vo.DateData;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@SessionAttributes("loginMember")

public class MemberController {
		
	@Autowired
	private MemberService service;

	@Autowired
	private MemoService memoService;
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private ScheduleService ScheduleService;
	
	@Autowired
	private CommunityService communityService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private ApprovalService appSerivce;
	
	@RequestMapping(value="/login", method={RequestMethod.POST})
	public ModelAndView login(ModelAndView model, @RequestParam("userId") String userId, 
												  @RequestParam("userPwd") String userPwd) {
		
		Member loginMember = null;
		
		loginMember = service.login(userId, userPwd);
		log.info("loginmember in mcontroller :"+ loginMember);
		if(loginMember != null) {
			model.addObject("loginMember" , loginMember);

			model.setViewName("redirect:/main");

		}else {
			model.addObject("msg", "????????? ?????? ??????????????? ???????????? ????????????.");
			model.addObject("location", "/");
			model.setViewName("common/msg");
		}
		return model;
	}

	//?????? ?????? ?????????
	@RequestMapping(value="/main")
	public ModelAndView mainPage(ModelAndView model,
			@SessionAttribute("loginMember")Member loginMember) {
		
				// project????????? ????????????
				List<Project> projectList = null;
				
				projectList = projectService.homeProjectList(loginMember.getUser_no());
				
				for(int i = 0; i < projectList.size(); i++) {
					String[] arr = projectList.get(i).getParticipant().split("/ ");
					
					projectList.get(i).setProjectCount(arr.length);
				}

				
				//?????? ????????? ????????????
				List<Message> receiveList = null;
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("msgTo", loginMember.getUser_no());
				
				receiveList = messageService.getHomeReceiveList(loginMember.getUser_no());
				
				
				//?????? ????????? ??? ????????? ?????? ??????
				int unreadCheck = 0;
				unreadCheck = messageService.getUnreadCheck(loginMember.getUser_no());
				
				// memo????????? ????????????
				String[] array = null;
				String content = null;
				List<String> memoContent = new ArrayList<>();
				List<Memo> memoList = memoService.getMemoList(loginMember.getUser_no());
				
				if(!memoList.isEmpty()) {
					content = memoList.get(0).getMemoContent();
					
					array = content.split("_");
					
					for(int i=0; i<array.length; i++) {
						memoContent.add(array[i]);
					}
				} 
				//?????? ?????? Section
				DateTime dt = new DateTime();
				String today = dt.toString("yyyy M d");
				String[] arr = today.split(" ");
				
				List<DateData> todaySchedule = ScheduleService.todaySchedule(loginMember, arr);
				
				//???????????? Section
				List<Community> communityList = communityService.selectMainList();
				
				//???????????? Section
				List<Notice> NoticeList = boardService.selectList(); 
				
				// ?????? ???????????? ???????????? ????????? ??????
				List<Approval> mainAppList = null;
				mainAppList = appSerivce.getRecentList2(loginMember);
				
				model.addObject("mainAppList", mainAppList);
				model.addObject("todaySchedule",todaySchedule);
				model.addObject("communityList", communityList);
				model.addObject("NoticeList", NoticeList);
				model.addObject("projectList",projectList);
				model.addObject("receiveList",receiveList);
				model.addObject("unreadCheck",unreadCheck);
				model.addObject("memoContent",memoContent);
				model.addObject("loginMember",loginMember);
				model.setViewName("/main");
				
				return model;
		
	}
	
	@RequestMapping("/logout")
	public String logout(SessionStatus status) {
		
		// ?????? ?????????.
		log.info("status.isComplete() " +status.isComplete());
		status.setComplete();
		log.info("status.isComplete() " +status.isComplete());
		
		return "redirect:/";
	}
	
	@RequestMapping(value="member/findIDorPwd")
	public String findIdorPwd() {
		
		log.info("wanna go findIDorPwd");
		
		return "member/findIDorPwd";
	}
	
	@RequestMapping(value="member/findID")
	public String findID() {
		
		log.info("findID go!!");
		
		return "member/findID";
	}
	
	@RequestMapping(value="member/findID", method={RequestMethod.POST})
	public ModelAndView findID(ModelAndView model,@ModelAttribute Member member) {
		
		log.info("in controller email, user_id : "+member.getEmail()+" "+member.getPhone());
		String findID =service.findID(member);
		
		if(findID!=null) {
			model.addObject("userID" , findID);
			log.info("?????? ?????????");
			System.out.println("?????? ????????????"+findID);
			model.addObject("msg", "?????? ???????????? "+findID);
		}else {
			model.addObject("msg", "?????? ???????????? ???????????? ????????????");
		}
			model.setViewName("common/msg");
		//	model.setViewName("redirect:/");
		
		return model;
	}
	
	/* ???????????? ?????? */
	@RequestMapping(value="member/findPwd")
	public String findPWD() {
		log.info("findPwd go!!");
		
		return "member/findPwd";
	}

    @Autowired
    private UserMailSendService mailsender;
    
	 @RequestMapping(value = "member/findPwd", method = RequestMethod.POST)
	 @ResponseBody public String findPwd(@RequestParam(value="user_id",required=false)String user_id,
			 @RequestParam(value="email" ,required = false)String email,
			 HttpServletRequest request )
	 
	 { 	
		 log.info("wanna go findPwd");
		 log.info("in controller email, user_id : "+email+" "+user_id);
	    mailsender.mailSendWithPassword(user_id, email, request);
	     String alert="????????? ??????????????????. ????????? ???????????? ???????????? ??????????????? ?????? ???????????????";
		 // String alert="check for email plz";
		 
	 return alert; }
	 
    
    // ????????????
	@RequestMapping("member/BeforeSignUp")
	public String BeforeSignUp() {
		log.info("???????????? ?????? ????????? ??????");
		
		return "member/BeforeSignUp";
	}
	
	@RequestMapping("member/signUpForm")
	public String enrollView() {
		log.info("???????????? ?????? ????????? ??????");
		
		return "member/signUpForm";
	}
	
	@RequestMapping(value = "/member/signUpForm", method = {RequestMethod.GET})
	public void enrollViewUpfile() {
		log.info("???????????? ?????? ????????? ??????");
		
		//return "member/signUpForm";
	}
	
	@RequestMapping(value = "/member/signUpForm", method = {RequestMethod.POST})
	public ModelAndView signUpForm(
			@SessionAttribute(name = "loginMember", required = false) Member loginMember, 
			HttpServletRequest request,@ModelAttribute Member member, ModelAndView model,
			@RequestParam("user_img") MultipartFile upfile) {

		log.info(member.toString());
		
		System.out.println(upfile.getOriginalFilename());
		
		if(upfile != null && !upfile.isEmpty()) {
			String renameFileName = saveFile(upfile, request);
			
			System.out.println(renameFileName);
			
			if(renameFileName != null) {
				member.setUser_imgOriname(upfile.getOriginalFilename());
				member.setUser_imgRename(renameFileName);
				
				System.out.println(", imgOriname : " + member.getUser_imgOriname() + " / imgRename : " + member.getUser_imgRename());
			}
		}
		
		int result = service.saveMember(member);
		
		log.info(member.toString());
		
		model.setViewName("member/signUpForm");
		
		if(result > 0) {
			model.addObject("msg", "??????????????? ??????????????? ???????????????.");
			model.addObject("location", "/"); // ?????????????????? ??????????????? ????????????
		} else {
			model.addObject("msg", "??????????????? ?????????????????????. ????????? ????????? ???????????? ?????????.");
			model.addObject("location", "/member/signUpForm");
		}
		
		model.setViewName("common/msg");
		
		return model;
	}
	
	// ????????? ??????
	@RequestMapping("member/idCheck")
	@ResponseBody
	public Object idCheck(@RequestParam("user_id")String user_id) {
		
		log.info("??????????????? ?????????..User_id : {}", user_id);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("validate", service.validate(user_id));
		
		System.out.println(map);
		
		return map;
	}
	
	// ?????? ??????
	@RequestMapping(value="member/memModify", method = {RequestMethod.GET})
	public String memModify() {
		log.info("?????? ?????? ????????? ??????");
		
		return "member/memModify";
	}
	
	@RequestMapping(value="/member/update", method = {RequestMethod.POST})
	public ModelAndView update(@ModelAttribute Member member, ModelAndView model,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember,
			@RequestParam("user_img") MultipartFile reloadImgFile, HttpServletRequest request) {
		
		System.out.println();
		
		int result = 0;
		
		if(loginMember.getUser_id().equals(member.getUser_id())) {
			member.setUser_no(loginMember.getUser_no());
			
			if(reloadImgFile != null && !reloadImgFile.isEmpty()) {
				if(member.getUser_imgRename() != null) {
					deleteImgFile(member.getUser_imgRename(), request);
				}
				
				String renameFileName = saveFile(reloadImgFile, request);
				
				if(renameFileName != null) {
					member.setUser_imgOriname(reloadImgFile.getOriginalFilename());
					member.setUser_imgRename(renameFileName);
				}
			}
			
			result = service.saveMember(member);
//			log.info("result ??? ???????????????? " + result);
			
//			String memAdress = loginMember.getAddress();
//			System.out.println(memAdress);
//			String[] adressArr = memAdress.split(",");
//			System.out.println(adressArr[0]);
//			System.out.println(adressArr[1]);
			
			if(result > 0) {
				System.out.println(loginMember.getUser_id().equals(member.getUser_id()) + ",  result : " + result);
				model.addObject("loginMember", service.findMemberByUserId(loginMember.getUser_id()));
				model.addObject("msg", "???????????? ????????? ??????????????????.");
				model.addObject("location", "/member/memModify");				
			} else {
				model.addObject("msg", "???????????? ????????? ?????? ????????????.");
				model.addObject("location", "/member/memModify");
			}
		} else {
			model.addObject("msg", "????????? ???????????????.");
			model.addObject("location", "/");
		}
		
		model.setViewName("common/msg");
		
		return model;
	}
	
	/* ???????????? ?????? ????????? */
	@RequestMapping(value="member/DeactivateAccount", method = {RequestMethod.GET})
	public String DeactivateAccount_1() {
		log.info("?????? ?????? ???????????? new ????????? ??????");
		
		return "member/DeactivateAccount";
	}
	
	// ?????? ??????
	@RequestMapping("/member/delete")
	public ModelAndView delete(ModelAndView model,
			@SessionAttribute(name="loginMember", required = false) Member loginMember,
			@RequestParam("user_id")String userId) {
		
		int result = 0;
		
		if(loginMember.getUser_id().equals(userId)) {
			result = service.deleteMember(userId);
			
			if(result > 0) {
				model.addObject("msg", "??????????????? ?????????????????????.");
				model.addObject("location", "/logout");				
			} else {
				model.addObject("msg", "?????? ????????? ?????????????????????.");
				model.addObject("location", "/member/memModify");
			}
		} else {
			model.addObject("msg", "????????? ???????????????.");
			model.addObject("location", "/");
		}
		
		model.setViewName("common/msg");
		
		return model;
	}
	
	// ?????? ???????????? ?????? ?????????
	@RequestMapping("/member/updatePassword")
	public String memAdress() {
		log.info("?????? ???????????? ?????? ????????? ??????");
		
		return "/member/updatePassword";
	}
	
	@RequestMapping("/member/updatePass")
	public ModelAndView updateUserPass(@ModelAttribute Member member, ModelAndView model,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		log.info("?????? ???????????? ?????? ???????????? ??????");
		
		int result = 0;
		
		System.out.println(result);
		System.out.println("loginMember.getUser_id().equals(member.getUser_id()) : " + loginMember.getUser_id().equals(member.getUser_id()));
		System.out.println("loginMember.getUser_id() : " +  loginMember.getUser_id() + ",  member.getUser_id() : " +  member.getUser_id());
		System.out.println("loginMember.getUser_no() : " +  loginMember.getUser_no() + ",  member.getUser_no() : " +  member.getUser_no());
		
		/* ?????? */
		member.setUser_no(loginMember.getUser_no());
		member.setUser_id(loginMember.getUser_id());
		
		System.out.println("member.getUser_no() : " + member.getUser_no());
		System.out.println("member.getUser_ID() : " + member.getUser_id());
		
		result = service.updateUserPassword(member);
		
		System.out.println(result);
		
		if(loginMember.getUser_id().equals(member.getUser_id())) {
			member.setUser_no(loginMember.getUser_no());
			if(result > 0) {
				System.out.println(loginMember.getUser_id().equals(member.getUser_id()) + ",  result : " + result);
				model.addObject("loginMember", service.findMemberByUserId(loginMember.getUser_id()));
				model.addObject("msg", "???????????? ????????? ??????????????????.");
				model.addObject("location", "/member/memModify");				
			} else {
				model.addObject("msg", "???????????? ????????? ?????? ????????????.");
				model.addObject("location", "/member/newUpdatePassword");
			}
		} else {
			model.addObject("msg", "????????? ???????????????.");
			model.addObject("location", "/");
		}
		
		model.setViewName("common/msg");
		return model;
	}
	
	// ??????????????? ??? ???????????? ??????????????? ??????????????? ???????????????
	@RequestMapping("member/findNewMem")
	@ResponseBody
	public Object findNewMem(@RequestParam("value")String userNo) {
		
		InsertNewMember member = service.getNewMember(userNo);
		Member memberfind = service.checkNewMem(userNo);
		
		Map<String, Object> map = new HashMap<>();
		
		if(member != null && memberfind == null) {
			map.put("member", member);
		} else if(member == null && memberfind == null) {
			map.put("member", 0);
		}  else if(member != null && memberfind != null) {
			map.put("member", 1);
		}
		return map;
	}
	
	private String saveFile(MultipartFile file, HttpServletRequest request) {
		String renamePath = null; 
		String originalFileName = null;
		String renameFileName = null;
		String rootPath = request.getSession().getServletContext().getRealPath("resources");
		String savePath = rootPath + "/upload/userProfileImg";				
		
		log.info("Root Path : " + rootPath);
		log.info("Save Path : " + savePath);
		
		File folder = new File(savePath); // Save Path??? ????????? ???????????? ????????? ????????? ???????????? ??????
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		originalFileName = file.getOriginalFilename();
		renameFileName = 
				LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmssSSS")) + 
				originalFileName.substring(originalFileName.lastIndexOf("."));
		renamePath = savePath + "/" + renameFileName;
		
		try {
			file.transferTo(new File(renamePath)); // ????????? ??? ?????? ???????????? ????????? ????????? ????????????.
		}catch (IOException e) {
			System.out.println("?????? ?????? ?????? : " + e.getMessage());
			e.printStackTrace();
		}
		
		return renameFileName;
	}
	
	private void deleteImgFile(String fileName, HttpServletRequest request) {
		String rootPath = request.getSession().getServletContext().getRealPath("resources");
		String savePath = rootPath + "/upload/userProfileImg";				
		
		log.info("Root Path : " + rootPath);
		log.info("Save Path : " + savePath);
		
		File file =  new File(savePath + "/" + fileName);
		
		if(file.exists()) {
			file.delete();
		}	
	}

}
