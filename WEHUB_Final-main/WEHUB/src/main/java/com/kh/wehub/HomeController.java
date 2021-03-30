package com.kh.wehub;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/*
 * Handles requests for the application home page.
 */
@Controller //안에 component 있고 이건 bean 만들어주는거 
			// web-inf 아래 security-context에서 bean 객체로 컨트롤러 빈 만들어주는 수고를 덜어줌.
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	// RM 어노테이션으로 인해 security-context에서 bean mapping 등록(url-처리할 컨트롤러)을 덜어줌
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		

		System.out.println("홈 콘트롤러 보내는척");

		return "/member/login";
	}
	
}
