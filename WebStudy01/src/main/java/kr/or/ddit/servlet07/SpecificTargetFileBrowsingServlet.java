package kr.or.ddit.servlet07;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/browsing/getFileList")
public class SpecificTargetFileBrowsingServlet extends HttpServlet{
	
	private ServletContext application;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		application = config.getServletContext();
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//1
		String target = req.getParameter("target");
		if(target == null || target.isEmpty()) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		
		String targetPath = application.getRealPath(target);
		File targetFolder = new File(targetPath);
		if(!targetFolder.exists()) {
			resp.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		if(targetFolder.isFile()) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
		}
		
		//2
		File[] fileList = targetFolder.listFiles();
		List<FileWrapper> wrapperList = Arrays.stream(fileList)
				.map(file -> new FileWrapper(file, application))
				.collect(Collectors.toList());
		
		//3
		req.setAttribute("files", wrapperList);
		
		//4
		String viewName = "/jsonView.do";
		
		//5
		req.getRequestDispatcher(viewName).forward(req, resp);
	}
}
