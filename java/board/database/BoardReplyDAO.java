package board.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conn.MysqlConn;

public class BoardReplyDAO {
	private final MysqlConn instance = MysqlConn.getInstance();
	private final Connection conn = instance.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private BoardReplyVO vo = null;
	private String sql = new String("");
	
	//페이징 총 레코드(게시판목록)건수
	public int totRecCnt() {
		int totRecCnt = 0;
		try {
			sql = "select count(*) as totRecCnt from boardreply";
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
	public List<BoardReplyVO> searchBoardReplyList(int boardIdx) {
		List<BoardReplyVO> vos = new ArrayList<>();
		try {
			sql = "select * from boardreply order by boardIdx = ? desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo = new BoardReplyVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setContent(rs.getString("content"));
				vo.setwDate(rs.getString("wDate"));
				vo.setHostIp(rs.getString("hostIp"));
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
	
	public BoardReplyVO search(int boardIdx) {
		try {
			sql = "SELECT "
					+ "		IDX, "
					+ "		NICKNAME, "
					+ "		CONTENT, "
					+ "		WDATE, "
					+ "		HOSTIP "
					+ "FROM "
					+ "		BOARDREPLY "
					+ "WHERE"
					+ "		BOARDIDX = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new BoardReplyVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setContent(rs.getString("content"));
				vo.setwDate(rs.getString("wDate"));
				vo.setHostIp(rs.getString("hostIp"));
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
	public int insert(BoardReplyVO vo) {
		int res = 0;
		try {
			sql = "insert into boardreply values ( default, ?, ?, ?, default, ?, ? )";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getBoardIdx());
			pstmt.setString(2, vo.getMid());
			pstmt.setString(3, vo.getNickName());
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

	//게시글 수정
	public int update(BoardReplyVO vo) {
		int res = 0;
		try {
			sql = "update into boardreply set content = ?, hostIp = ? where idx = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getContent());
			pstmt.setString(2, vo.getHostIp());
			pstmt.setInt(3, vo.getIdx());
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
			sql = "delete from boardreply where idx =  ? ";
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