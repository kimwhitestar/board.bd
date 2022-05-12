package board;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.database.BoardDAO;
import board.database.BoardReplyDAO;
import board.database.BoardReplyVO;
import board.database.BoardVO;

public class BoardDetailCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardDAO dao = new BoardDAO();
		String searchCondition = request.getParameter("searchCondition");
		String searchString = request.getParameter("searchString");
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));//현재글idx
		int pageNo = request.getParameter("pageNo")==null ? 1 : Integer.parseInt(request.getParameter("pageNo"));
		int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		
		//글 조회수 1회 증가 (조회수 중복방지처리 - 세션사용 : 'board+고유번호'를 객체배열에 추가
		HttpSession session = request.getSession();
		List<String> sBoardIdx = (List<String>) session.getAttribute("sBoardIdx");  
		if (null == sBoardIdx) {
			sBoardIdx = new ArrayList<>();
		}
		String tmpBoardIdx = "board" + idx;
		if ( !sBoardIdx.contains(tmpBoardIdx) ) {
			int res = dao.updateReadNum(idx);
			sBoardIdx.add(tmpBoardIdx);
		}
		session.setAttribute("sBoardIdx", sBoardIdx);
		
		int totRecCnt = dao.totRecCnt();
		int preIdx = 0;//이전글idx
		int nextIdx = 0;//다음글idx
		if (0 < idx && 0 < totRecCnt && idx < totRecCnt) {
			if (1 >= idx) preIdx = 1;
			else preIdx = idx - 1;
			if (totRecCnt <= idx) nextIdx = totRecCnt;
			else nextIdx = idx + 1;
		}
		
		//게시글 가져오기
		BoardVO vo = dao.search(idx);
		//이전글 소개 가져오기
		BoardVO preVO = dao.search(preIdx);
		//다음글 소개 가져오기
		BoardVO nextVO = dao.search(nextIdx);

		//댓글 가져오기
		BoardReplyDAO replyDAO = new BoardReplyDAO();
		List<BoardReplyVO> replyVOS = replyDAO.searchBoardReplyList(idx);
		
		
		request.setAttribute("vo", vo);
		request.setAttribute("preVO", preVO);
		request.setAttribute("nextVO", nextVO);
		request.setAttribute("replyVOS", replyVOS);
		request.setAttribute("pageNo", pageNo);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("searchCondition", searchCondition);
		request.setAttribute("searchString", searchString);
	}
}