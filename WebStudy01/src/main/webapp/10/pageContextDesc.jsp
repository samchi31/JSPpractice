<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%--!
	public String sample = "SAMPLE";
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>10/pageContextDesc.jsp</title>
</head>
<body>
	<h4>pageContext(PageContext)</h4>
	<pre>
		: 하나의 JSP 페이지와 관련된 모든 정보(기본 객체)를 가진 객체
		
		1. EL 에서 주로 기본 객체를 확보할 때 사용
			ex) <%=request.getContextPath() %>, 
				<%=((HttpServletRequest)pageContext.getRequest()).getContextPath() %>,
				${pageContext.request.contextPath }
		
		2. 에러 데이터 확보
		
		3. 흐름 제어(요청 분기 request Dispatch방식) : forward / include
			<%--
				pageContext.forward(relativeUrlPath);	// 서블릿에서는 pageContext가 존재하지 않아 request에서 dispatch 수행
			--%>
		4. 영역 제어*****
			<%--
				pageContext.setAttribute("", "", PageContext.)
			--%>
	</pre>
	
	<h4>Scope</h4>
	<pre>
		Servlet[JSP] Container : 서블릿 객체나 JSP 객체의 모든 관리 권한을 가진 주체(IoC-Inversion of Control)
		Scope : 웹 어플리케이션에서 데이터를 공유하기 위해 사용되는 저장 공간(Map&lt;String,Object&gt;)
		Attribute : scope 를 통해 공유되는 데이터(String name / Object value)
		
		: Scope라는 저장 공간을 소유한 기본 객체의 생명주기와 동일함
		
		page scope : pageContext 의 소유 공간, 현재 페이지에서만 공유 가능 영역
		request scope : 해당 영역의 소유 요청 객체가 소멸될 때 함꼐 소멸됨
		session scope : 해당 영역을 소유한 세션 객체와 생명주기 동일 (json 기반의 토큰 인증 구조)
		application scope : ServletContext와 동일한 생명주기를 가짐 
		
		setAttribute(name, value), getAttribute(name), removeAttribute(name)***
		
		<%
			pageContext.setAttribute("pageAttr", "페이지 속성");
			request.setAttribute("requestAttr", "요청 속성");
			session.setAttribute("sessionAttr", "세션 속성");
			application.setAttribute("applicationAttr", "어플리케이션 속성");
			
			pageContext.setAttribute("sample", "페이지 샘플");
			pageContext.setAttribute("sample", "요청 샘플", PageContext.REQUEST_SCOPE);
			
			// 1. forward
			String viewName = "/09/attrView.jsp";
// 			request.getRequestDispatcher(viewName).forward(request, response);
			// 2. include
// 			request.getRequestDispatcher(viewName).include(request, response);
			// 3. redirect
			String location = request.getContextPath() + viewName;
// 			response.sendRedirect(location);
		%> 
	</pre>
	
	<h4> 공유된 속성 데이터들 </h4>
	<pre>
		sample : ${sample }	(EL은 scope가 작은 범위 부터 속성명을 탐색)
		sample : ${requestScope.sample }
		
		page scope : <%=pageContext.getAttribute("pageAttr") %>, ${pageAttr }
		request scope : <%=request.getAttribute("requestAttr") %>, ${requestAttr }
		session scope : <%=session.getAttribute("sessionAttr") %>, ${sessionAttr }
		<%
			// flash attribute
			session.removeAttribute("sessionAttr");
		%>
		application scope : <%=application.getAttribute("applicationAttr") %>, ${applicationAttr }
	</pre>
</body>
</html>