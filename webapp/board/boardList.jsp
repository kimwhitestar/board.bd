<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    	function checkPage() {
    		//let pageSize = ${"#pageSize"}.val();
    		//location.href="boardList.bd?pageNo=${pageNo}&pageSize="+pageSize;
    		location.href="${ctxPath}/boardList.bd?pageNo=${pageNo}&pageSize=${pageSize}";
    	}
    	//검색기 처리
    	function checkSearching() {
    		//let searchString = $(#searchString).val();
    		let searchString = "${searchString}";
    		let searchCondition;
    		if (""==searchString.trim()) {
    			searchForm.searchString.focus();
    		}
    		searchForm.submit();
    		
    	}
    </script>
</head>
<body>
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
	<h2 class="text-center">게 시 판 리 스 트</h2>
	<br>
	<div class="row m-2">
		<div class="col text-left">
			<a href="${ctxPath}/boardInput.bd" class="btn btn-secondary">글쓰기</a>
		</div>
		
		<div class="col text-right">
			(<font color="blue">${searchTitle}</font>)(으)로 
			<font color="blue">${searchString}(을)를 검색한 결과</font>
			<font color="blue">${searchCount}건이 검색됬습니다</font>
		</div>
		
		<!-- 페이징 처리 시작 -->
		<div class="col text-right">
<c:if test="${pageNo > 1}">
			<a href='boardList.bd?pageNo=1&pageSize=${pageSize}' title='first'>${First}</a>
				<a href='boardList.bd?pageNo=${pageNo - 1}&pageSize=${pageSize}' title='prev'>${Prev}</a>
</c:if>
				${pageNo}Page / ${totPage}Pages
<c:if test="${pageNo != totPage}">
				<a href='boardList.bd?pageNo=${pageNo + 1}&pageSize=${pageSize}' title='next'>${Next}</a>
</c:if>
<c:if test="${pageNo != totPage}">
			<a href='boardList.bd?pageNo=${totPage}&pageSize=${pageSize}' title='last'>${Last}</a>
</c:if>
		</div>
		<!-- 페이징 처리 끝 -->

		<div class="text-right p-0">
			<select name="pageSize" id="pageSize" onchange="checkPage()">
				<option value="5"  ${5==pageSize  ? 'selected' : ''} >5건</option>
				<option value="10" ${10==pageSize ? 'selected' : ''} >10건</option>
				<option value="15" ${15==pageSize ? 'selected' : ''} >15건</option>
				<option value="20" ${20==pageSize ? 'selected' : ''} >20건</option>
			</select>
		</div>	
	</div>

	<table class="table table-hover text-center">
		<tr class="table-dark">
			<th>글번호</th>
			<th class="text-left">글제목</th>
			<th>글쓴이</th>
			<th>글쓴날짜</th>
			<th>조회수</th>
			<th>추천수</th>
		</tr>
<c:forEach var="vo" items="${vos}" >
		<tr>
			<td><c:out value="${curScrStartNo}"/></td>
			<td><a href="${ctxPath}/boardDetail.bd?idx=${vo.idx}&pageNo=${pageNo}&pageSize=${pageSize}&searchCondition=${searchCondition}&searchString=${searchString}"><c:out value="${vo.title}"/></a>
				<c:if test="${vo.intWDate <= 24}"><font color="red"> new </font></c:if>
			</td>
			<td><c:out value="${vo.nickName}"/></td>
			<td>
				<c:if test="${vo.intWDate <= 24}"><c:out value="${fn:substring(vo.wDate, 11, 19)}"/></c:if>
				<c:if test="${vo.intWDate > 24}"><c:out value="${fn:substring(vo.wDate, 0, 10)}"/></c:if>
			</td>
			<td><c:out value="${vo.readNum}"/></td>
			<td><c:out value="${vo.recommendNum}"/></td>
		</tr>
		<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
</c:forEach>
	</table>
	
		<!-- 블럭페이징 처리 시작 -->
		<div class="text-center">
			<div class="pagination justify-content-center">
			
<c:if test="${pageNo > 1}">
				<li class="page-item"><a href='boardList.bd?pageNo=1&pageSize=${pageSize}' title='first' class="page-link text-secondary" >첫페이지</a></li>
</c:if>
<c:if test="${curBlock > 0}">
				<li class="page-item"><a href='boardList.bd?pageNo=${(curBlock-1)*blockSize+1}&pageSize=${pageSize}' title='prevBlock' class="page-link text-secondary" >이전블록</a>
</c:if>
<c:set var="isBreak" value="false"/>
				<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
			      <c:if test="${i <= totPage && i == pageNo}">
			        <li class="page-item active"><a href="boardList.bd?pageNo=${i}&pageSize=${pageSize}" class="page-link text-light bg-secondary border-secondary" >${i}</a>
			      </c:if>
			      <c:if test="${i <= totPage && i != pageNo}">
			        <li class="page-item"><a href="boardList.bd?pageNo=${i}&pageSize=${pageSize}" class="page-link text-secondary" >${i}</a>
			      </c:if>
			    </c:forEach>
<c:if test="${curBlock < lastBlock}">
				<li class="page-item"><a href='boardList.bd?pageNo=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}' title='nextBlock' class="page-link text-secondary" >다음블록</a>
</c:if>
<c:if test="${pageNo != totPage}">
			<li class="page-item"><a href='boardList.bd?pageNo=${totPage}&pageSize=${pageSize}' title='last' class="page-link text-secondary" >마지막페이지</a>
</c:if>
			</div>
		</div>
		<!-- 블럭페이징 처리 끝 -->
		
		<!-- 검색키 처리 시작 -->
	<div class="container text-center">
		<form name="searchForm" method="post" action="${ctxPath}/boardSearching.bd">
			<select name="searchCondition" id="searchCondition" onchange="changeSearchCondition()">
				<option value="title">글제목</option>
				<option value="nickName">글쓴이</option>
				<option value="content">글내용</option>
			</select>
			<input type="text" name="searchString" id="searchString"/>
			<input type="hidden" name="pageNo" value="${pageNo }"/>
			<input type="hidden" name="pageSize" value="${pageSize }"/>
			
			<input type="button" value="검색" onclick="checkSearching()"/>
			<input type="button" value="돌아가기" onclick="location.href='${ctxPath}/boardList.bd?pageNo=${pageNo}&pageSize=${pageSize}';"/>
		</form>
	</div>
		<!-- 검색키 처리 끝 -->
</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>