package board.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conn.MysqlConn;

public class BoardDAO {
	private final MysqlConn instance = MysqlConn.getInstance();
	private final Connection conn = instance.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private BoardVO vo = null;
	private String sql = new String("");
	
	//페이징 총 레코드(게시판목록)건수
	public int totRecCnt() {
		int totRecCnt = 0;
		try {
			sql = "select count(*) as totRecCnt from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next(); //ResultSet레코드움직이기(count함수는 무조건 0값조차 가져옴)
			totRecCnt = rs.getInt("totRecCnt");
		} catch (SQLException e) {
			e.getMessage();
		} finally {
			instance.rsClose();
			instance.pstmtClose();
		}
		return totRecCnt;
	}
	
	//게시판 목록 조회
	public List<BoardVO> searchBoardList(int startIndexNo, int pageSize) {
		List<BoardVO> vos = new ArrayList<>();
		try {
			sql = "select * from board order by idx desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo = new BoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setHomepage(rs.getString("homepage"));
				vo.setContent(rs.getString("content"));
				vo.setStrWdate(rs.getString("wDate"));
				vo.setIntWDate(new TimeDiff().timeDiff(vo.getStrWdate()));//오늘날짜와 글쓴날짜의 시간차이
				vo.setwDate(rs.getString("wDate"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setRecommendNum(rs.getInt("recommendNum"));
				vo.setMid(rs.getString("mid"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
			instance.rsClose();
		}
		return vos;
	}

	//게시판 목록 조회-검색조건
	public List<BoardVO> searchBoardListForCondition(String searchCondition, String searchString) {
		List<BoardVO> vos = new ArrayList<>();
		try {
			sql = "select * from board where "+ searchCondition + " like ? order by idx desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+searchString+"%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo = new BoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setHomepage(rs.getString("homepage"));
				vo.setContent(rs.getString("content"));
				vo.setStrWdate(rs.getString("wDate"));
				vo.setIntWDate(new TimeDiff().timeDiff(vo.getStrWdate()));//오늘날짜와 글쓴날짜의 시간차이
				vo.setwDate(rs.getString("wDate"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setRecommendNum(rs.getInt("recommendNum"));
				vo.setMid(rs.getString("mid"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
			instance.rsClose();
		}
		return vos;
	}
	
	/**
	 * 게시글 조회
	 * @param idx 게시글 번호
	 * @return BoardVO
	 * 
	 * -document작업 API형상화를 위한 주석-
	 */
	public BoardVO search(int idx) {
		vo = null;//vo를 request에 들고 다닐 때(jsp:useBean입력등) null초기화 필요
		try {
			sql = "SELECT "
					+ "		IDX, "
					+ "		NICKNAME, "
					+ "		TITLE, "
					+ "		EMAIL, "
					+ "		HOMEPAGE, "
					+ "		CONTENT, "
					+ "		WDATE, "
					+ "		READNUM, "
					+ "		HOSTIP, "
					+ "		RECOMMENDNUM, "
					+ "		MID "
					+ "FROM "
					+ "		BOARD "
					+ "WHERE"
					+ "		IDX = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new BoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setHomepage(rs.getString("homepage"));
				vo.setContent(rs.getString("content"));
				vo.setStrWdate(rs.getString("wDate"));
				vo.setIntWDate(new TimeDiff().timeDiff(vo.getStrWdate()));//오늘날짜와 글쓴날짜의 시간차이
				vo.setwDate(rs.getString("wDate"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setRecommendNum(rs.getInt("recommendNum"));
				vo.setMid(rs.getString("mid"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
			instance.rsClose();
		}
		return vo;
	}

	//게시글 등록
	public int insert(BoardVO vo) {
		int res = 0;
		try {
			sql = "insert into board values ( default, ?, ?, ?, ?, ?, default, default, ?, default, ? )";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getNickName());
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getEmail());
			pstmt.setString(4, vo.getHomepage());
			pstmt.setString(5, vo.getContent());
			pstmt.setString(6, vo.getHostIp());
			pstmt.setString(7, vo.getMid());
			res = pstmt.executeUpdate();
		} catch(SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
		}
		return res;
	}

	//게시글 조회수 1회 증가
	public int updateReadNum(int idx) {
		int res = 0;
		try {
			sql = "update into board set readNum = readNum + 1 where idx = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
		} catch(SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
		}
		return res;
	}

	//게시글 좋아요수 1회 증가
	public int updateRecommendNum(int idx) {
		int res = 0;
		try {
			sql = "update into board set recommendNum = recommendNum + 1 where idx = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
		} catch(SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
		}
		return res;
	}

	//게시글 수정
	public int update(BoardVO vo) {
		int res = 0;
		try {
			sql = "update into board set title = ?, email = ?, homepage = ?, content = ?, hostIp = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getEmail());
			pstmt.setString(3, vo.getHomepage());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getHostIp());
			res = pstmt.executeUpdate();
		} catch(SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
		}
		return res;	
	}

	//게시글 삭제
	public int delete(int idx) {
		int res = 0;
		try {
			sql = "delete from board where idx =  ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
		} catch(SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
		}
		return res;	
	}
}
