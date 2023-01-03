package kr.or.ddit.mvc.annotation;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface HandlerAdapter {
	/**
	 * mappingInfo에 포함된 핸들러 객체와 핸들러 메소드 정보를 기반으로 실제 핸들러 호출하는 역할
	 * @param mappingInfo 핸들러 객체, 핸들러 메소드에 대한 정보 
	 * @param req
	 * @param resp
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String invokeHandler(RequestMappingInfo mappingInfo, HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException;
}
