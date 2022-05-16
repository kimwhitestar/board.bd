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
    	function checkBoardUpdate() {
    		boardForm.action = '${ctxPath}/boardUpdate.bd';
    		boardForm.submit();
    	}
    	function checkBoardDelete(){
    		boardForm.action = '${ctxPath}/boardDeleteOk.bd';
    		boardForm.submit();
    	}
    	function viewReply(replyContent) {
    		$("#replyContent").val(replyContent);
    	}
    	function checkReplyUpdate(replyIdx) {
    		if (!confirm('댓글을 수정하겠습니까?')) return;

    		let replyContent = $("#replyContent").val();
    		if("" == replyContent.trim()) {
    			alert("댓글을 입력하세요");
    			$("#replyContent").focus();
    			return false;
    		}
    		
    		let param = {	idx : replyIdx, 
							content : replyContent,
							hostIp : '${pageContext.request.remoteAddr}'	};
    		
    		$.ajax({
    			type:		"post",
    			url:		"${ctxPath}/boardReplyUpdate",//간단히 URL패턴으로 했음
    			data:		param,
    			success:	function(res) {
    				if("1"==res) location.reload();//수정성공시 화면reload
    				else alert('댓글이 수정되지 않았습니다');
    			},
    			error:		function() {
    				alert('요청 오류~~');
    			}
    		});
    	}
    	function checkReplyInput() {
    		let replyContent = $("#replyContent").val();
    		if("" == replyContent.trim()) {
    			alert("댓글을 입력하세요");
    			$("#replyContent").focus();
    			return false;
    		}
    		let param = {	boardIdx : '${vo.idx}', 
    						content : replyContent,
							hostIp : '${pageContext.request.remoteAddr}'	};
    		
    		$.ajax({
    			type:		"post",
    			url:		"${ctxPath}/boardReplyInput",//간단히 URL패턴으로 했음
    			data:		param,
    			success:	function(res) {
    				if('1'==res) location.reload();//등록성공시 화면reload
    				else  alert('댓글이 등록되지 않았습니다');
    			},
    			error:		function() {
    				alert('요청 오류~~');
    			}
    		});
    	}
    	function checkReplyDelete(replyIdx) {
    		if (!confirm('댓글을 삭제하겠습니까?')) return;
    		
    		$.ajax({
    			type:		"post",
    			url:		"${ctxPath}/boardReplyDelete",//간단히 URL패턴으로 했음
    			data:		{idx : replyIdx},
    			success:	function(res) {
    				if("1"==res) location.reload();//삭제성공시 화면reload//전체화면 reload 많이 쓰면 화면깜박 생김
    				else alert('댓글이 삭제되지 않았습니다');
    			},
    			error:		function() {
    				alert('요청 오류~~');
    			}
    		});
    	}    
    	function checkRecommend() {
			$.ajax({
				type: 		"post",
				url: 		"${ctxPath}/boardRecommend",//간단히 URL패턴으로 했음
				data: 		{idx : '${vo.idx}'}, 
				success:	function(recmmdNum) {
					if ("-1" == recmmdNum) {
						alert('좋아요가 처리되지 않았습니다');
					} else {
						$("#recmmdNum").val(recmmdNum);
						location.reload();//'좋아요' 1회 증가 DB저장 성공시 화면 reload
					} 
				},
				error:		function() {
					alert('요청 오류~~');
				}
			});
		}
    	function checkNoRecommend() {
    		$.ajax({
    			type: 		"post",
    			url: 		"${ctxPath}/boardNoRecommend",//간단히 URL패턴으로 했음
    			data: 		{ idx : '${vo.idx}' }, 
    			success:	function(recmmdNum) {
    				if ("-1" == recmmdNum) {
    					alert('싫어요가 처리되지 않았습니다');
    				} else {
    					$("#recmmdNum").val(recmmdNum);
    					location.reload();////'싫어요' 1회 증가 DB저장 성공시 화면 reload
    				} 
    			},
    			error:		function() {
    				alert('요청 오류~~');
    			}
    		});
    	}    </script>
    <style>
    	th {
    		background-color: #ddd;
    		text-align: center;
    	}
    </style>
</head>
<body>
<c:if test="${0 < sLevel}" >
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
</c:if>
<p><br></p>
<div class="container">
	<h2 class="text-center">글 내 용 보 기</h2>
	<br>
	<form name="boardForm" method="post">
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
					❤ ( <c:set var="recmmdNum" value="${vo.recommendNum}" scope="page"/><c:out value="${recmmdNum}"/> )
					/ <a href="javascript:checkRecommend()"> 👍 </a>
					/ <a href="javascript:checkNoRecommend()"> 👎 </a>
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
	    <input type="hidden" name="idx" value="${vo.idx}" />
	    <input type="hidden" name="searchCondition" value="${searchCondition}" />
	    <input type="hidden" name="searchString" value="${searchString}" />
	</form>
	
	<!-- 이전글/다음글 소개 시작 -->
	<form name="prevForm" method="post" action="${ctxPath}/boardDetail.bd">
		<table>
			<tr>
				<td>
					<a href="javascript:goPrevBoardDetail()">이전글 : ${preVO.title}</a><br>
				</td>
			</tr>
		</table>
	    <input type="hidden" name="idx" value="${preVO.idx}" />
	    <input type="hidden" name="searchCondition" value="${searchCondition}" />
	    <input type="hidden" name="searchString" value="${searchString}" />
    </form>
    <br>
	<form name="nextForm" method="post" action="${ctxPath}/boardDetail.bd">
		<table>
			<tr>
				<td>
					<a href="javascript:goNextBoardDetail()">다음글 : ${nextVO.title}</a><br>
				</td>
			</tr>
		</table>
	    <input type="hidden" name="idx" value="${nextVO.idx}" />
	    <input type="hidden" name="searchCondition" value="${searchCondition}" />
	    <input type="hidden" name="searchString" value="${searchString}" />
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
			<td class="text-left">
				${replyVO.nickName}
				<c:if test="${sMid == replyVO.mid}">
					<a href="javascript:checkReplyUpdate('${replyVO.idx}')" class="btn btn-info btn-sm" ><font color="blue">✂</font></a>
				</c:if>
				<c:if test="${sMid == replyVO.mid || 0 == sLevel}">
					<a href="javascript:checkReplyDelete('${replyVO.idx}')" class="btn btn-info btn-sm" ><font color="red">❌</font></a>
				</c:if>
			</td>
			<td class="text-left">
				<a href="javascript:viewReply('${fn:replace(replyVO.content, 'newLine', '<br>')}')">${fn:replace(replyVO.content, 'newLine', '<br>')}</a>
				<c:if test="${replyVO.intWDate <= 24}"><font color="red"> new </font></c:if>
			</td>
			<td>
				<c:if test="${replyVO.intWDate <= 24}"><c:out value="${fn:substring(replyVO.wDate, 11, 19)}"/></c:if>
				<c:if test="${replyVO.intWDate > 24}"><c:out value="${fn:substring(replyVO.wDate, 0, 10)}"/></c:if>
			</td>
			<td>${replyVO.hostIp}</td>
		</tr>
		</c:forEach>		
	</table>
	
	<!-- 댓글 입력(전체화면을 이동하지않고 비동기식 Ajax로 댓글form만 reload처리함-->
	<table class="table table-center">
		<tr>
			<td style="width:85%">
				<textarea rows="3" id="replyContent" name="replyContent" class="form-control"></textarea>
			</td>
			<td style="width:15%">
				<p><input type="button" value="댓글등록" onclick="checkReplyInput()" class="btn btn-info btn-sm"/></p>
				<p>작성자 : ${sNickName}</p>
				<br>
			</td>
		</tr>
	</table>
	<!-- 댓글(출력/입력) 끝 -->
</div>
<c:if test="${0 < sLevel}" >
    <%@ include file="/include/footer.jsp" %>
</c:if>
</body>
</html>