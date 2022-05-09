<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<c:set var="sAdmin" value="${sAdmin}" scope="session" />
<c:set var="LF" value="\n" scope="page" />
<c:set var="BR" value="<br>" scope="page" />
<c:set var="First" value="<<" scope="page" />
<c:set var="Last" value=">>" scope="page" />
<c:set var="Prev" value="◁" scope="page" />
<c:set var="Next" value="▷" scope="page" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>boardList.jsp</title>
    <%@ include file="/include/bs4.jsp" %>
    <style></style>
    <script>
    	'use strict';
    	
    </script>
</head>
<body>
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
	<h2 class="text-center">게 시 판 리 스 트</h2>
	<br>
	<div class="m-2 row">
		<div class="col text-left">
			<a href="${ctxPath}/boardInput.bd" class="btn btn-secondary">글쓰기</a>
		</div>
	
		<!-- 페이징 처리 시작 -->
		<div class="col text-right">
<c:if test="${pageNo > 1}">
			<a href='boardList.bd?pageNo=1' title='first'>${First}</a>
				<a href='boardList.bd?pageNo=${pageNo - 1}' title='prev'>${Prev}</a>
</c:if>
				${pageNo}Page / ${totPage}Pages
<c:if test="${pageNo != totPage}">
				<a href='boardList.bd?pageNo=${pageNo + 1}' title='next'>${Next}</a>
</c:if>
			<a href='boardList.bd?pageNo=${totPage}' title='last'>${Last}</a>
		</div>
		<!-- 페이징 처리 끝 -->
	</div>

	<table class="table table-hover">
		<tr class="table-dark">
			<th>글번호</th>
			<th>글제목</th>
			<th>글쓴이</th>
			<th>글쓴날짜</th>
			<th>조회수</th>
			<th>추천수</th>
		</tr>
<c:forEach var="vo" items="${vos}" >
		<tr>
			<td><c:out value="${curScrStartNo}"/></td>
			<td><c:out value="${vo.title}"/></td>
			<td><c:out value="${vo.nickName}"/></td>
			<td><c:out value="${vo.wDate}"/></td>
			<td><c:out value="${vo.readNum}"/></td>
			<td><c:out value="${vo.recommendNum}"/></td>
		</tr>
	<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
</c:forEach>
	</table>
	
		<!-- 블럭페이징 처리 시작 -->
		<div class="text-center">
<c:if test="${pageNo > 1}">
			[<a href='boardList.bd?pageNo=1' title='first'>첫페이지</a>]
</c:if>
<c:if test="${curBlock > 0}">
				[<a href='boardList.bd?pageNo=${(curBlock-1)*blockSize+1}' title='prevBlock'>이전블록</a>]
</c:if>
<c:set var="isBreak" value="false"/>
				<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
			      <c:if test="${i <= totPage && i == pageNo}">
			        [<a href="boardList.bd?pageNo=${i}"><font color='red'><b>${i}</b></font></a>]
			      </c:if>
			      <c:if test="${i <= totPage && i != pageNo}">
			        [<a href="boardList.bd?pageNo=${i}">${i}</a>]
			      </c:if>
			    </c:forEach>
<c:if test="${curBlock < lastBlock}">
				[<a href='boardList.bd?pageNo=${(curBlock+1)*blockSize+1}' title='nextBlock'>다음블록</a>]
</c:if>
			[<a href='boardList.bd?pageNo=${totPage}' title='last'>마지막페이지</a>]
		</div>
		<!-- 블럭페이징 처리 끝 -->

</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>