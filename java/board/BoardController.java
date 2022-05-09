package board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("*.bd")
public class BoardController extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardInterface command = null;
		String viewPage = "/WEB-INF";
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
		
		//세션이 끊겼으면, 회원레벨을 비회원으로 바꿔서 작업의 진행을 로그인창으로 보낸다.
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
		
//		if (4 < level) {
//			request.getRequestDispatcher("/").forward(request, response);
//		}
//		//게시판목록
//		else 
			if (com.equals("boardList")) {
			command = new BoardListCommand();
			command.execute(request, response);
			viewPage += "/board/boardList.jsp";
		}
		//글쓰기
		else if (com.equals("boardInput")) {
//			command = new BoardInputCommand();
//			command.execute(request, response);
			viewPage += "/board/boardInput.jsp";
		}
		//글쓰기OK
		else if (com.equals("boardInputOk")) {
			command = new BoardInputOkCommand();
			command.execute(request, response);
			viewPage = "/message/message.jsp";
		}

		request.getRequestDispatcher(viewPage).forward(request, response);
	}
}
