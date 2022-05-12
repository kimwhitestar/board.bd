package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.database.BoardReplyDAO;
import board.database.BoardReplyVO;

@WebServlet("/boardReplyInput")
public class BoardReplyInput extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (null == request.getParameter("boardIdx")) {
			return;
		}
		int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		String mid = request.getParameter("mid");
		String nickName = request.getParameter("nickName");
		String hostIp = request.getParameter("hostIp");
		
		BoardReplyVO replyVO = new BoardReplyVO();
		replyVO.setBoardIdx(boardIdx);
		replyVO.setMid(mid);
		replyVO.setNickName(nickName);
		replyVO.setHostIp(hostIp);
		
		BoardReplyDAO dao = new BoardReplyDAO();
		int res = dao.insert(replyVO);
		response.getWriter().write(res);
	}
}
