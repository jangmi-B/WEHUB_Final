//package com.kh.wehub.common.interceptor;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.springframework.web.servlet.ModelAndView;
//import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
//
//import com.kh.mvc.member.model.vo.Member;

//public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
//	// art + shift + s => override/implement Method. 누르고 HandlerInterceptorAdapter 전체선택 후 OK
//
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws Exception {
//		// 컨트롤러가 실행되기 전에 필요한 작업을 할 수 있는 메소드
//		// 반환형이 boolean. false일 경우 컨트롤러를 실행하지 않는다.(요청이 넘어가지 않는다.)
//		System.out.println("preHandle() call .......");
//		
//		Member loginMember = (Member)request.getSession().getAttribute("loginMember"); // 세션에 로그인멤버가 있으면 들어가고, 없으면 null
//		
//		if(loginMember == null) {
//			request.setAttribute("msg", "로그인 후 이용이 가능합니다.");
//			request.setAttribute("location", "/");
//			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);; //model이나 ModelAndView로 viewResolver를 타는게 아니라 전체경로를 지정해야한다.
//			
//			return false;
//		}
//		
//		return super.preHandle(request, response, handler);
//	}
//
//	@Override
//	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
//			ModelAndView modelAndView) throws Exception {
//		// 컨트롤러가 실행된 후에 필요한 작업을 할 수 있는 메소드이다.
//		System.out.println("postHandle() call .......");
//		
//		super.postHandle(request, response, handler, modelAndView);
//	}
//
//	@Override
//	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
//			throws Exception {
//		// 컨트롤러에 처리가 끝나고 화면처리(View에 대한 렌더링)까지 모두 끝나면 실행되는 메소드이다.
//		System.out.println("afterCompletion() call .......");
//		
//		super.afterCompletion(request, response, handler, ex);
//	}
//
//	@Override
//	public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws Exception {
//		// 비동기 요청 시 실행되는 메소드이다. (비동기 요청이기때문에 postHandle() afterCompletion() 가 수행되지 않고 afterConcurrentHandlingStarted() 메소드가 실행된다.)
//		System.out.println("afterConcurrentHandlingStarted() call .......");
//		
//		super.afterConcurrentHandlingStarted(request, response, handler);
//	}
//	
	

//}
