
<%@page import="com.cheapmall.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>


<c:if test="${result >0 }">
	<script type="text/javascript">
	alert("관리자 등록 완료");
	location.href="AdminForm.admin?pageNum=${pageNum}";
	
	</script>
</c:if>
<c:if test="${result == 0 }">
	<script type="text/javascript">
	alert("정확한 정보를 입력해주세요"); history.back();
	</script>
</c:if>
</body>
</html>