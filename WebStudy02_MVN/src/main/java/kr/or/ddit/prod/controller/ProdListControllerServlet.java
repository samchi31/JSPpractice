package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.mvc.view.InternalResourceViewResolver;
import kr.or.ddit.prod.service.ProdService;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ProdVO;
import kr.or.ddit.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebServlet("/prod/prodList.do")
public class ProdListControllerServlet extends HttpServlet{
	
	ProdService service = new ProdServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String pageParam = req.getParameter("page");
		String searchType = req.getParameter("searchType");
		String searchWord = req.getParameter("searchWord");
		
		SearchVO simpleCondition = new SearchVO(searchType, searchWord);
		
		int currentPage = 1;
		if(StringUtils.isNumeric(pageParam)) {	// int 로 parse 가능한지
			currentPage = Integer.parseInt(pageParam);
		}
		
		PagingVO<ProdVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		
		service.retrieveProdList(pagingVO);
		req.setAttribute("pagingVO", pagingVO);
		log.info("paging data : {}", pagingVO);
		
		String viewName = "prod/prodList";
		
		// 5
		new InternalResourceViewResolver("/WEB-INF/views/", ".jsp").resolveView(viewName, req, resp);
	}
	
}
