<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
</head>
<body>
	<h2>상품 상세정보 수정</h2>
	
	<form action="goodsAdminUpdateFormPro.admin" method="post">
		상품Id: 	<input type="text" 	name="sq" 			value="${sq }"	readonly><br>
		상품코드: <input type="text" 	name="cd" 			value="${dto.cd }" readonly><br>
		상품명: 	<input type="text" 	name="nm" 			value="${dto.nm }"><br>
		가격: 	<input type="text" 	name="price" 		value="${dto.price }"><br>
		성별: 	<input type="text" 	name="gender" 		value="${dto.gender }"><br>
		대분류: 	<input type="text" 	name="top_category" value="${dto.top_category }"><br>
		소분류: 	<input type="text" 	name="middle_category" value="${dto.middle_category }"><br>
		색상: 	<input type="text" 	name="color" 		value="${dto.color }"><br>
		사이즈: 	<input type="text" 	name="goods_size" 	value="${dto.goods_size }"><br>
		재고량: 	<input type="text" 	name="stock" 		value="${dto.stock }"><br>
		시작일: 	<input type="text" 	name="start_dt" 	value="${dto.start_dt }"><br>
		종료일: 	<input type="text" 	name="end_dt" 	value="${dto.end_dt }"><br>
		노출: 	<input type="text" 	name="display" 		value="${dto.display }"><br>
		
		<div style="float:right; padding: 10 10 10 10px!important!;">
			<input type="submit" value="수정">
			<input type="reset" value="취소"	>
		</div>
	</form>
</body>
</html>