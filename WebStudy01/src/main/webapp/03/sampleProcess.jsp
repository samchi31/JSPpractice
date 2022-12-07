<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//데이터 읽기전에 입력방식에 맞게 적용
	request.setCharacterEncoding("EUC-KR");	// body의 내용만 적용
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<pre>
	request line : <%=request.getRequestURL() %>
	request line->query String : <%=request.getQueryString() %>
	request body : <%=request.getInputStream().available() %>	// 서버보다 먼저 body 데이터를 꺼냄 (post 쓸 때 조심)
	
	***표준 입력 양식(form)을 통해 입력된 파라미터 확보
	String getParameter(name)
	String[] getParameterValues(name)	// 같은 name으로 여러 값
	Enumeration&lt;String&gt; getParameterNames()
	Map&lt;String, String[]&gt; getParameterMap()
</pre>

<table>
<thead><tr><th>파라미터명</th><th>파라미터값(들)</th></tr></thead>
<tbody>
	<%
		Enumeration<String> names = request.getParameterNames();
		while(names.hasMoreElements()){
			String parameterName = names.nextElement();
			String[] values = request.getParameterValues(parameterName);
			%>
			<tr>
				<td><%=parameterName %></td>
				<td><%=Arrays.toString(values) %></td>
			</tr>
			<%
		}
	%>
</tbody>
</table>

<table>
<thead><tr><th>파라미터명</th><th>파라미터값(들)</th></tr></thead>
<tbody>
	<%
		Map<String, String[]> parameterMap = request.getParameterMap();
		for(Entry<String, String[]> entry: parameterMap.entrySet()){
			String parameterName = entry.getKey();
			String[] values = entry.getValue();
			%>
			<tr>
				<td><%=parameterName %></td>
				<td><%=Arrays.toString(values) %></td>
			</tr>
			<%
		}
	%>
</tbody>
</table>

</body>
</html>