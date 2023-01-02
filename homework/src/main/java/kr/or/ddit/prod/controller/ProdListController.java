package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.mvc.AbstractController;
import kr.or.ddit.mvc.view.InternalResourceViewResolver;
import kr.or.ddit.prod.dao.OthersDAO;
import kr.or.ddit.prod.dao.OthersDAOImpl;
import kr.or.ddit.prod.service.ProdService;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ProdVO;
import kr.or.ddit.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
//@WebServlet("/prod/prodList.do")
public class ProdListController implements AbstractController{
	
	private ProdService service = new ProdServiceImpl();
	private OthersDAO othersDAO = new OthersDAOImpl();
	
	private void addAttribute(HttpServletRequest req) {
		req.setAttribute("lprodList", othersDAO.selectLprodList());
		req.setAttribute("buyerList", othersDAO.selectBuyerList(null));
	}
	
	private String listUI(HttpServletRequest req, HttpServletResponse resp) {
		addAttribute(req);
		return "prod/prodList";	
	}
	
	private String listData(HttpServletRequest req, HttpServletResponse resp) throws ServletException {
		String pageParam = req.getParameter("page");
		ProdVO detailCondition = new ProdVO();
//		detailCondition.setProdLgu(req.getParameter("prodLgu"));
//		detailCondition.setProdBuyer(req.getParameter("prodBuyer"));
//		detailCondition.setProdName(req.getParameter("prodName"));
		try {
			BeanUtils.populate(detailCondition, req.getParameterMap());
		} catch (IllegalAccessException | InvocationTargetException e) {
			throw new ServletException(e);
		}
		
		int currentPage = 1;
		if(StringUtils.isNumeric(pageParam)) {	// int 로 parse 가능한지
			currentPage = Integer.parseInt(pageParam);
		}
		
		PagingVO<ProdVO> pagingVO = new PagingVO<>(5,2);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDetailCondition(detailCondition);
		
		service.retrieveProdList(pagingVO);
		req.setAttribute("pagingVO", pagingVO);
		req.setAttribute("detailCondition",detailCondition);
		log.info("paging data : {}", pagingVO);
		
		return "forward:/jsonView.do";
	}
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		req.setCharacterEncoding("UTF-8");
		String header = req.getHeader("Accept");	
		
		String viewName = null;
		if(header.contains("html")) {
			viewName = listUI(req, resp);
		} else if(header.contains("json")) {
			viewName = listData(req, resp);
		}		
		
		return viewName;
		// 5
//		new InternalResourceViewResolver("/WEB-INF/views/", ".jsp").resolveView(viewName, req, resp);
	}
	
}
