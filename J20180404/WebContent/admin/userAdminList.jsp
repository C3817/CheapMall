<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>

<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	
		$(function(){
			$('input[type="checkbox"]').bind('click',function(){
				$('input[type="checkbox"]').not(this).prop("checked",false);
			});
		})

	</script>

</head>
<body>
	<div id="wrap">
		<jsp:include page="adminMenuList.jsp" />
	</div>

	<div id="main">

		<!-- 이 페이지는 관리자가 회원 삭제를 하기 위한 페이지 입니다.  -->
	
		<h2>회원삭제</h2>
	
			<form action="userAdminDeleteForm.admin?pageNum=${pageNum }" method="post">
				<input type="text" name="search" value="${search }"> 
				<input type="submit" value="검색">
			</form>
		
		<form action="userAdminDeletePro.admin?pageNum=${pageNum }" method="post">
			<table border="1" id="deleteMember">
				<tr>
					<th>회원ID</th>
					<th>성명</th>
					<th>생년월일</th>
					<th>연락처</th>
					<th>이메일</th>
					<th>등급</th>
					<th>삭제</th>
				</tr>
	
		       
				<c:if test="${count>0 }">
					<c:forEach var="user" items="${dto }">
						<tr>
							<td>
							<a href="#" 
							onclick="javascript:window.open('AdminUserModifyPopUp.admin?id=${user.id}&pageNum=${pageNum}&popup','회원수정', 'width=500, height=500')">
							${user.id }</a></td>
							<td>${ user.nm}</td>
							<td>${ user.birth}</td>
							<td>${ user.tel}</td>
							<td>${ user.email}</td>
							<td>${ user.grade}</td>
							<td><input type="checkbox" name="del" value="${user.id }"></td>
						</tr>
					</c:forEach>
				</c:if>
				
				<c:if test="${count==0 }">
					<tr>
						<td colspan=8>no data exists</td>
					</tr>
				</c:if>
				
				
				</table>
				
				<div style="text-align: center">
	
					<c:if test="${ currentPage>1 }">
						<a href='userAdminList.admin?pageNum=${currentPage-1 }'>
							[이전] </a>
					</c:if>
		
					<c:forEach var="i" begin="${startPage }" end="${endPage }">
						<a href='userAdminList.admin?pageNum=${i}&search=${search}'> [${i }] </a>
					</c:forEach>
		
					<c:if test="${endPage<pageCnt }">
						<a href='userAdminList.admin?pageNum=${startPage+blockSize }'>
							[다음] </a>
					</c:if>
	
				</div>
			
		
	
			<span style="float: right; padding: 10 10 10 10px!important;" /> 
			<input type="submit" value="삭제"> 
			<input type="reset" value="취소">
	
		</form>
	</div>
</body>
</html>