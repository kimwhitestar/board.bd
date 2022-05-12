package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.database.BoardDAO;
import board.database.BoardVO;

public class BoardUpdateCommandOk implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
		int pageNo = Integer.parseInt(request.getParameter("pageNo"));
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		String title = request.getParameter("title");
		String email = request.getParameter("email");
		String homepage = request.getParameter("homepage");
		String content = request.getParameter("content");
		String hostIp = request.getParameter("hostIp");
		
		BoardDAO dao = new BoardDAO();
		BoardVO vo = new BoardVO();
		vo.setIdx(idx);
		vo.setTitle(title);
		vo.setEmail(email);
		vo.setHomepage(homepage);
		vo.setContent(content);
		vo.setHostIp(hostIp);
		int res = dao.update(vo);
		if (1 == res) {
			request.setAttribute("msg", "boardUpdateOk");
			request.setAttribute("url", request.getContextPath()+"/boardList.bd");
		} else {
			request.setAttribute("msg", "boardUpdateNo");
			request.setAttribute("url", request.getContextPath()+"/boardUpdate.bd");
		}
		request.setAttribute("pageNo", pageNo);
		request.setAttribute("pageSize", pageSize);
	}
}