package board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BoardListCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String sMid = (String)session.getAttribute("sMid");
		
		BoardDAO dao = new BoardDAO();
		
		
		
		List<BoardVO> vos = dao.searchBoardList(sMid);
		
		
		request.setAttribute("vos", vos);
	}
}