package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.database.BoardDAO;

public class BoardDeleteCommandOk implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
		int pageNo = Integer.parseInt(request.getParameter("pageNo"));
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		
		BoardDAO dao = new BoardDAO();
		int res = dao.delete(idx);
		if (1 == res) {
			request.setAttribute("msg", "boardDeleteOk");
			request.setAttribute("url", request.getContextPath()+"/boardList.bd");
		} else {
			request.setAttribute("msg", "boardDeleteNo");
			request.setAttribute("url", request.getContextPath()+"/boardDetail.bd");
		}
		request.setAttribute("pageNo", pageNo);
		request.setAttribute("pageSize", pageSize);
	}
}
