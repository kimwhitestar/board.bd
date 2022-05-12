<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<c:set var="newLine" value="\n" scope="page"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>boardDetail.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
    <script>
    	'use strict';
    	function checkReply() {
    		let content = $("#content").val();
    		if("" == content.trim()) {
    			alert("댓글을 입력하세요");
    			$("#content").focus();
    			return false;
    		}
    		
    		let param = {	boardIdx : ${vo.idx}, 
							mid : ${sMid},
							nickName : ${sNickName},
							hostIp : ${pageContext.request.remoteAddr}	};
    		
    		$.ajax({
    			type:		"post",
    			url:		"${ctxPath}/boardReplyInput.bd",
    			data:		param,
    			success:	function(res) {
    				if("1"==res) location.reload();//전체화면 reload 많이 쓰면 화면깜박 생기므로 많이 쓰지않도록!
    				else alert('댓글이 등록되지 않았습니다');
    			},
    			error:		function() {
    				alert('요청 오류~~');
    			}
    		});
    		//ajaxSubmit();
    	}
    	function checkRecommend() {
    		$.ajax({
    			type: 		"post",
    			url: 		"${ctxPath}/boardRecommend.bd",
    			data: 		{idx : ${vo.idx}}, //form parameters
    			success:	function(res) {
    				if("1"==res) {
    					location.reload();//전체화면 reload 많이 쓰면 화면깜박 생기므로 많이 쓰지않도록!
    				} else {
    					alert('추천되지 않았습니다');
    				}
    			},
    			error:		function() {
    				alert('요청 오류~~');
    			}
    		});
    		//ajax로 window open가능하다고 하는데... 찾아보자...
    	}
    	function checkBoardUpdate() {
    		boardForm.action = '${ctxPath}/boardUpdate.bd';
    		boardForm.submit();
    	}
    	function checkBoardDelete(){
    		boardForm.action = '${ctxPath}/boardDelete.bd';
    		boardForm.submit();
    	}
    	function goBoardList() {
    		boardForm.action = '${ctxPath}/boardList.bd';
    		boardForm.submit();
    	}
    	function goPrevBoardDetail() {
    		prevForm.submit();
    	}
    	function goNextBoardDetail() {
    		nextForm.submit();
    	}
    </script>
    <style>
    	th {
    		background-color: #ddd;
    		text-align: center;
    	}
    </style>
</head>
<body>
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
	<h2 class="text-center">글 내 용 보 기</h2>
	<br>
	<form name="boardForm">
	<table class="table table-bordered">
		<tr>
			<td colspan="4" class="text-right bt-0">IP : ${vo.hostIp}</td>
		</tr>
		<tr>
			<th>글쓴이</th>
			<td><c:out value="${vo.nickName}"/></td>
			<th>작성일</th>
			<td><c:out value="${fn:substring(vo.wDate, 0, 20)}"/> / <c:out value="${vo.intWDate}"/></td><!-- 2022.05.10 10:13:25 -->
		</tr>
		<tr>
			<th>이메일</th>
			<td><c:out value="${vo.email}"/></td>
			<th>조회수</th>
			<td><c:out value="${vo.readNum}"/></td>
		</tr>
		<tr>
			<th>홈페이지</th>
			<td><c:out value="${vo.homepage}"/></td>
			<th>좋아요</th>
			<td>
				<a href="javascript:checkRecommend();">❤</a>(<c:out value="${vo.recommendNum}"/>) 
				/ 👍 
				/ 👎 
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="3" height="200px"><c:out value="${fn:replace(vo.content, 'newLine', '<br>')}"/></td>
		</tr>
		<tr>
			<td colspan="4" class="text-center">
				<input type="button" value="목록" onclick="goBoardList()" class="btn btn-secondary"/>
<c:if test="${sMid==vo.mid}">
				<input type="button" value="수정" onclick="checkBoardUpdate()" class="btn btn-secondary"/>
				<input type="button" value="삭제" onclick="checkBoardDelete()" class="btn btn-secondary"/>
</c:if>
			</td>
		</tr>
	</table>
	    <input type="hidden" name="searchCondition" value="${searchCondition}" />
	    <input type="hidden" name="searchString" value="${searchString}" />
	    <input type="hidden" name="pageNo" value="${pageNo}" />
	    <input type="hidden" name="pageSize" value="${pageSize}" />
	</form>
	
	<!-- 이전글/다음글 소개 시작 -->
	<form name="prevForm" action="${ctxPath}/boardDetail.bd">
		<table>
			<tr>
				<td>
					<a href="goPrevBoardDetail()">다음글 : ${preVO.title}</a><br>
				</td>
				<td>
					<a href="goNextBoardDetail()">이전글 : ${nextVO.title}</a><br>
				</td>
			</tr>
		</table>
	    <input type="hidden" name="searchCondition" value="${searchCondition}" />
	    <input type="hidden" name="searchString" value="${searchString}" />
	    <input type="hidden" name="idx" value="${preVO.idx}" />
	    <!-- @ㅗ@ -->
	    <input type="hidden" name="pageNo" value="${pageNo}" />
	    <input type="hidden" name="pageSize" value="${pageSize}" />
    </form>
	<form name="nextForm" action="${ctxPath}/boardDetail.bd">
		<table>
			<tr>
				<td>
					<a href="goPrevBoardDetail()">다음글 : ${preVO.title}</a><br>
				</td>
				<td>
					<a href="goNextBoardDetail()">이전글 : ${nextVO.title}</a><br>
				</td>
			</tr>
		</table>
	    <input type="hidden" name="searchCondition" value="${searchCondition}" />
	    <input type="hidden" name="searchString" value="${searchString}" />
	    <input type="hidden" name="idx" value="${nextVO.idx}" />
	    <!-- @ㅗ@ -->
	    <input type="hidden" name="pageNo" value="${pageNo}" />
	    <input type="hidden" name="pageSize" value="${pageSize}" />
    </form>
	<!-- 이전글/다음글 소개 끝 -->
	
	<!-- 댓글(출력/입력) 시작 -->
	<!-- 댓글 출력 -->
	<table class="table table-hover text-center">
		<tr>
			<th>작성자</th>
			<th>내용</th>
			<th>작성일</th>
			<th>접속IP</th>
		</tr>
<c:forEach var="replyVO" items="${replyVOS}">
		<tr>
			<td class="text-left">${replyVO.nickName}</td>
			<td class="text-left">${fn:replace(replyVO.content, 'newLine', '<br>')}</td>
			<td>${replyVO.wDate}</td>
			<td>${replyVO.hostIp}</td>
		</tr>
</c:forEach>		
	</table>
	<hr>
	
	<!-- 댓글 입력(전체화면을 이동하지않고 비동기식 Ajax로 댓글form만 reload처리함-->
	<table class="table table-center">
		<tr>
			<td style="width:85%">
				<textarea rows="3" name="content" class="form-control"></textarea>
			</td>
			<td style="width:15%">
				<p><input type="button" value="댓글" onclick="checkReply()" class="btn btn-info btn-sm"/></p>
				<p>작성자 : ${sNickName}</p>
				<br>
			</td>
		</tr>
	</table>
	<!-- 댓글(출력/입력) 끝 -->
</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>