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

@SuppressWarnings("serial")
@WebServlet("/boardNoRecommend")
public class BoardNoRecommend extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardDAO dao = new BoardDAO();
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		//Shift+Alt+R (같은 글자 바꾸기)
		//싫어요 1회 증가 (조회수 중복방지처리 - 세션사용 : 'recommend+고유번호'를 객체배열에 추가
		HttpSession session = request.getSession();
		List<String> sNoRecommendIdx = (List<String>) session.getAttribute("sNoRecommendIdx");  
		if (null == sNoRecommendIdx) {
			sNoRecommendIdx = new ArrayList<>();
		}
		String tmpNoRecommendIdx = "noRecommend" + idx;
		int res = 0;
		if ( ! sNoRecommendIdx.contains(tmpNoRecommendIdx)) {
			//'싫어요' 1회 증가와 동시에 '좋아요' 1회 감소 DB저장
			res = dao.updateNoRecommendNum(idx);//res 1:DB수정성공, 0:DB수정실패
			sNoRecommendIdx.add(tmpNoRecommendIdx);
		}
		session.setAttribute("sNoRecommendIdx", sNoRecommendIdx);

		int recmmdNum = -1;//좋아요 횟수 응답용
		if (1 == res) recmmdNum = dao.searchBoardRecommendNum(idx);//좋아요 총횟수 DB조회
		response.getWriter().write(String.valueOf(recmmdNum));//좋아요 총횟수 조회값 응답 전송
	}
}