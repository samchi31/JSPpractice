package kr.or.ddit.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.member.service.MemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.mvc.annotation.stereotype.Controller;
import kr.or.ddit.mvc.annotation.stereotype.RequestMapping;
import kr.or.ddit.mvc.view.InternalResourceViewResolver;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.MemberVOWrapper;
@Controller
public class MypageControllerServlet{
	
	private MemberService service = new MemberServiceImpl();
	
	@RequestMapping("/mypage.do")
	public String doGet(HttpServletRequest req
			, MemberVOWrapper principal) throws ServletException, IOException {
//		MemberVOWrapper principal = (MemberVOWrapper)req.getUserPrincipal();
//		MemberVO authMember = (MemberVO)session.getAttribute("authMember");
		MemberVO authMember = principal.getRealMember();
		
		MemberVO member = service.retrieveMember(authMember.getMemId());
		
		req.setAttribute("member", member);
		String viewName = "member/memberView";	// logical view name
		
		return viewName;
	}
}
