package kr.or.ddit.commons;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.mvc.annotation.stereotype.Controller;
import kr.or.ddit.mvc.annotation.stereotype.RequestMapping;
@Controller
public class IndexController {
	@RequestMapping("/index.do")
	public String process(HttpServletRequest req) throws ServletException, IOException {
		req.setAttribute("contentPage", "/WEB-INF/views/index.jsp");
		return "layout";
	}
}
