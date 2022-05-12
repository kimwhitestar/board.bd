package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.database.MemberDAO;
import member.database.MemberVO;

public class BoardInputCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String sMid = (String)session.getAttribute("sMid");
		
		//회원가입된 회원정보 취득
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.search(sMid);
		
		//회원정보의 email과 homepage를 Board입력폼에 default입력값 설정
		request.setAttribute("email", vo.getEmail());
		request.setAttribute("homepage", vo.getHomepage());
	}
}