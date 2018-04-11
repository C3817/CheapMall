<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<script src="../js/jquery.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function findZipcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('addr_detail').focus();
            }
        }).open();
    }
    
    function switchShow(payMethod){
    	alert(payMethod);
    	var method = document.getElementById(payMethod);
    	
    	if(payMethod == 'kakaopay'){
    		var list = method.classList;
    		
    		alert(list[0]);
    	} else if(payMethod == 'creditcard'){
    		
    	}
    	
    }
    
    function usePoint(){
    	var point = parseInt(document.getElementById('point').value);
    	if(isNaN(point) == true){
    		alert("숫자입니다.");
    	} else {
    		alert("아닙니다.");
    	}
    	alert(point);
    }
    
    function switchAddr(){
    	var select = document.getElementById('defaultAddr');
    	
    	//////////////////////
    }
</script>
<style type="text/css">
	.show{
		display: block;
	}
	.none{
		display: none;
	}
</style>
</head>
<body>
<h2> 주문 상세 Page</h2>
<!-- test varStatus는 index의 뜻입니다.-->
<c:forEach var="test" items="${orderBag.orders }" varStatus="totalRow">
	<c:set var="lastRow" value="${totalRow.count }"></c:set>
</c:forEach>

<form action="" method="post">
	<!-- hidden -->
	<input type="hidden" value="${delivery_fee }" name="delivery_fee">
	<input type="hidden" value="" name="total">
	<input type="hidden" value="${zipcode }" name="zipcode">
	<input type="hidden" value="${addr }" name="addr">
	<input type="hidden" value="${addr_detail }" name="addr_detail">
	<table border="1">
		<tr>
			<th colspan="2">상품정보</th>
			<th>브랜드</th>
			<th>배송비</th>
			<th>수량</th>
			<th>할인</th>
			<th>주문금액</th>
		</tr>
		<c:forEach var="goods" items="${orderBag.orders }" varStatus="test">
			<tr>
				<td><img src="../images/${goods.gender }/${goods.top_category}/${goods.middle_category}/thumbnail/${goods.path}.png"></td>
				<td>
					${goods.nm } <br>
					옵션 : ${goods.color } / size: ${goods.size_meaning }
				</td>
				<td>침몰</td>
				<!-- test -->
				<c:if test="${test.first }">
					<td rowspan="${lastRow }">
						<c:if test="${goods.delivery_fee == 0 }">
							0원
						</c:if>
						<c:if test="${goods.delivery_fee != 0 }">
							${goods.delivery_fee}원
						</c:if>
					</td>
				</c:if>
				<td>${goods.cnt }개</td>
				<td>${goods.origin_price }원</td>
				<td>
					${(goods.origin_price*goods.cnt)}원 <br>
					${(goods.origin_price*goods.cnt) - (goods.dc_price*goods.cnt) }원
				</td>
			</tr>
		</c:forEach>
	</table>
	
	<h2> 배송지 정보</h2>
	배송지 선택 : 
		<input type="radio" name="address" id="defaultAddr" checked="checked" value="defaultAddr" onclick="switchAddr('defaultAddr')">기본 배송지 
		<input type="radio" name="address" id="newAddr" value="newAddr" onclick="switchAddr('newAddr')"> 새로운 배송지
		
	<p>
		<div id="normalAddr">
			<%-- 받는분 성함 : ${orderBag.id }	<br /> --%>
			주소 : ${orderBag.zipcode } <br />
			상세주소 : ${orderBag.addr } ${orderBag.addr_detail }<br />
			전화번호 : ${orderBag.tel } <br />
		</div>
	<p>
	<div id="newAddr">
		<!-- <p> 받는분 성함 : <input type="text" name="nm" id="nm"> -->
		<p> 주소 : <input type="text" max="6" name="newZipcode" id="zipcode">
				  <input type="button" value="우편번호찾기" onclick="findZipcode()"> </p>
		<p>		  <input type="text" width="30" id="addr" name="newAddr">
		<p> 상세주소 : <input type="text" width="30" id="addr_detail" name="newAddr_detail">	  
		<!-- <p> 전화번호 : <select name="tel">
						<option value="010" selected="selected">010</option>
						<option value="016">016</option>
						<option value="017">017</option>
					</select> - 
					<input type="text" max="4" id="tel1" name="tel1"> - 
					<input type="text" max="4" id="tel2" name="tel2"> </p> -->
	</div>
	
	<h2> 포인트 사용</h2>
	<p>
		쇼핑몰 포인트 : <input type="text" value="0" id="point">
					<input type="button" value="포인트 전액 사용" onclick="usePoint()">
					[사용가능포인트 : ${orderBag.point }]
		</p>
	<p>
	<h2> 결재 정보 </h2>
	<input type="radio" name="payment" id="payment1" value="kakaopay" onclick="switchShow('kakaopay')" checked="checked">카카오 페이 
	<input type="radio" name="payment" id="payment2" value="creditcard" onclick="switchShow('creditcard')">신용카드 
	<input type="radio" name="payment" id="payment3" value="bankbook" onclick="switchShow('bankbook')">실시간 통장
	<div id="kakaopay" class="payment show">
		kakaopay
	</div>
	<div id="creditcard" class="payment none">
		creditcard
	</div>
	<div id="bankbook" class="payment none">
		bankbook
	</div>
	
</form>
</body>
</html>