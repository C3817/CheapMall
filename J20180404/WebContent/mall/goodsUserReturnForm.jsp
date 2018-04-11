<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">


function getDetail(){
	
	var order_sq=$('#order_sq').val();
	
	 $.ajax({ 
		type:"post",
		url:'orderReturnDetailForm.mall?id=${id}', 
		data:{"order_sq":order_sq},
		success:function(detail){
			$('#detailOrder').html(detail);
			page();
		}	
	});
}


</script>
</head>
<body>

	<h2>상품반품</h2>
	<form action="goodsUserReturnPro.mall" method="post">
		<table border="1">
			<tr>
			<th>주문ID</th>
			<th>최종가격</th>
			<th>사용포인트</th>
			<th>결제수단</th>
			<th>주문상태</th>
			<th>주문일</th>
			<th>반품체크</th>
			</tr>
			
			<c:if test="${count>0 }">
			<c:forEach var="order" items="${list }">
			<tr>
			<td><a href="javascript:getDetail();" id="selectDetail" >
			<input type="hidden" id="order_sq" name="order_sq" value="${order.order_sq}">
			${order.order_sq }</a></td> 
			
			<td>${order.dc_price }</td>
			<td>${order.use_point }</td>
			<td>${order.pay_method }</td>
			<td>${order.order_cd }</td>
			<td>${order.order_dt }</td>
			<td><input type="checkbox" name="returnOrder_sq" value=${order.order_sq }></td>
			</tr>
			</c:forEach>
			</c:if>
			
			<c:if test="${count==0 }">
				<tr>
					<td colspan=7>no data exists</td>
				</tr>
			</c:if>
			
		</table>
		
		<div style="text-align: center">

				<c:if test="${ currentPage>1 }">
					<a href='goodsUserReturnForm.mall?pageNum=${currentPage-1 }&id=${id}'>
						[이전] </a>
				</c:if>
	
				<c:forEach var="i" begin="${startPage }" end="${endPage }">
					<a href='goodsUserReturnForm.mall?pageNum=${i}&id=${id}'> [${i }] </a>
				</c:forEach>
	
				<c:if test="${endPage<pageCnt }">
					<a href='goodsUserReturnForm.mall?pageNum=${startPage+blockSize }&id=${id}'>
						[다음] </a>
				</c:if>
			</div>
			<span style="float: right; padding: 10 10 10 10px!important;">
			<input type="submit" value="반품">
			<input type="reset" value="취소"></span>
	</form>
	
	<div id="detailOrder">
	
	</div>

</body>

</html>