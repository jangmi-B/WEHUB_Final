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

@Controller
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
<<<<<<< HEAD:WEHUB/src/main/java/com/kh/wehub/HomeController.java
=======
		model.addAttribute("serverTime", formattedDate );
		
>>>>>>> 8081bda3306c1dc0ed22e8a90996c6c95caad06f:WEHUB_Final-main/WEHUB/src/main/java/com/kh/wehub/HomeController.java
		return "/member/login";
	}
	
}

