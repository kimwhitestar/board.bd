package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.database.BoardDAO;
import board.database.BoardVO;

public class BoardInputOkCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String sMid = (String)session.getAttribute("sMid");
		String sNickName = (String)session.getAttribute("sNickName");
		String title = request.getParameter("title");
		String email = request.getParameter("email");
		String homepage = request.getParameter("homepage");
		String content = request.getParameter("content");
		String hostIp =  request.getParameter("hostIp");
System.out.println("sMid="+sMid);		
System.out.println("sNickName="+sNickName);		
System.out.println("hostIp="+hostIp);		
		if (null == sMid || null == sNickName || null == title || null == content || null == hostIp) {
			request.setAttribute("msg", "boardInputNo");
			request.setAttribute("url", request.getContextPath()+"/boardList.bd");
			return;
		}
		
		BoardVO vo = new BoardVO();
		vo.setNickName(sNickName);
		vo.setTitle(title);
		vo.setEmail(email);
		vo.setHomepage(homepage);
		vo.setContent(content);
		vo.setHostIp(hostIp);
		vo.setMid(sMid);
		
		BoardDAO dao = new BoardDAO();
		int res = dao.insert(vo);
		if (1 == res) {
			request.setAttribute("msg", "boardInputOk");
			request.setAttribute("url", request.getContextPath()+"/boardList.bd");
		} else {
			request.setAttribute("msg", "boardInputNo");
			request.setAttribute("url", request.getContextPath()+"/boardList.bd");
		}
	}
}