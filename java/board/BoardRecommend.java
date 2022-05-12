package board;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.database.BoardDAO;

@WebServlet("/boardRecommend")
public class BoardRecommend extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardDAO dao = new BoardDAO();
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		//Shift+Alt+R (같은 글자 바꾸기)
		//글 조회수 1회 증가 (조회수 중복방지처리 - 세션사용 : 'recommend+고유번호'를 객체배열에 추가
		HttpSession session = request.getSession();
		List<String> sRecommendIdx = (List<String>) session.getAttribute("sRecommendIdx");  
		if (null == sRecommendIdx) {
			sRecommendIdx = new ArrayList<>();
//			session.setAttribute("sRecommendIdx", sRecommendIdx);
		}
		String tmpRecommendIdx = "recommend" + idx;
		if ( ! sRecommendIdx.contains(tmpRecommendIdx)) {
			int res = dao.updateReadNum(idx);
			sRecommendIdx.add(tmpRecommendIdx);
		}
		session.setAttribute("sRecommendIdx", sRecommendIdx);

		
		int res = dao.updateRecommendNum(idx);
	}
}