<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <%@ include file="/include/bs4.jsp" %>
    <style></style>
    <script>
    	'use strict';
    	function checkHomepage() {
    		let homepage = document.getElementById("homepage").value;
    		let editHomepage = homepage;
    		if (7 <= homepage.length) {
    			editHomepage = homepage.substring(0, homepage.indexOf(':'));
    			if (editHomepage == 'https' || editHomepage == 'http' ) {
    				editHomepage = homepage.substring(homepage.indexOf('://')+3);
    				homepage = editHomepage;
    			}
    		}
    		document.getElementById("homepage").value = homepage;
    		document.getElementById("content").focus();
    	}
    	function checkInput() {
    		if (confirm('등록하겠습니까?')) myForm.submit();
    	}
    </script>
</head>
<body>
    <%@ include file="/include/header_home.jsp" %>
    <%@ include file="/include/nav.jsp" %>
<p><br></p>
<div class="container">
  <form name="myForm" method="post" action="${ctxPath}/boardInputOk.bd" class="was-validated">
    <h2>게시판 글쓰기</h2>
    <div class="form-group">
      <label for="title">제목</label>
      <input type="text" class="form-control" name="title" id="title"  placeholder="제목을 입력하세요." required autofocus/>
      <div class="valid-feedback"></div>
      <div class="invalid-feedback">제목은 필수 입력사항입니다.</div>
    </div>
    <div class="form-group">
      <label for="email">E-mail</label>
      <input type="text" class="form-control" name="email" id="email" <c:if test="${!empty email}"> value="${email}" </c:if> placeholder="E-mail을 입력하세요."/>
      <div class="invalid-feedback">이메일은 선택 입력사항입니다.</div>
    </div>
    <div class="form-group">
      <label for="homepage">Homepage</label>
      <input type="text" class="form-control" name="homepage" id="homepage" <c:if test="${!empty homepage}"> value="${homepage}" </c:if> placeholder="http://는 빼고 Homepage를 입력하세요." onblur="checkHomepage()"/>
      <div class="invalid-feedback">홈페이지는 선택 입력사항입니다.</div>
    </div>
    <div class="form-group">
      <label for="content">내용</label>
      <textarea rows="5" class="form-control" name="content" id="content" placeholder="내용을 입력하세요." required ></textarea>
      <div class="valid-feedback"></div>
      <div class="invalid-feedback">내용은 필수 입력사항입니다.</div>
    </div>
    <input type="hidden" name="hostIp"  value="${pageContext.request.remoteAddr}"/>
    <div class="form-group">
	    <button type="button" class="btn btn-secondary" onclick="checkInput()">게시글 등록</button> &nbsp;
	    <button type="reset" class="btn btn-secondary">게시글 다시작성</button> &nbsp;
	    <button type="button" class="btn btn-secondary" onclick="location.href='${ctxPath}/boardList.bd';">돌아가기</button>
    </div>
  </form>
</div>
    <%@ include file="/include/footer.jsp" %>
</body>
</html>