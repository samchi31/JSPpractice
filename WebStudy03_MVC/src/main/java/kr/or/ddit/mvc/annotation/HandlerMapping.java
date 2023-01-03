package kr.or.ddit.mvc.annotation;

import javax.servlet.http.HttpServletRequest;

public interface HandlerMapping {
	/**
	 * 현재 요청의 조건(RequestMappingCondition)에 맞는 핸들러 정보(핸들러객체 + 핸들러 메소드 : RequestMapppingInfo)를 검색
	 * @param request
	 * @return
	 */
	public RequestMappingInfo findCommandHandler(HttpServletRequest request);
}
