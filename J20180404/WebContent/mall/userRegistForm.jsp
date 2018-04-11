<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cheap Mall</title>
<style type="text/css">
table {
	background-color: pink;
}
</style>
<style>
	h1{font-size:3em;}
	
</style>
<script src="../js/jquery.js"></script>
<script type="text/javascript">
	function chk() {
		if (frm.pw.value != frm.pw2.value) {
			alert("암호가 다릅니다");
			frm.passwd.focus();
			return false;
		}
		
		return true;
	}
	function winop() {
		var v_id = frm.id;
		if (!v_id.value) {
			alert("id를 입력하고 사용하세요");
			v_id.focus();
			return false;
		}
		if(!v_id.value.length < 4 || !v_id.value.length > 16){
			alert("4자이상 16미만으로 작성해주세요.");
			v_id.focus();
			return false;
		}
		
		for(var i=0 ; i<v_id.value.length ; i++){
			if(v_id.value.charAt(i) == v_id.value.charAt(i).toUpperCase()){
				alert("대문자가 포함되면 안됩니다.");
				v_id.focus();
				return false;
			}
		}
		
		// ajax
		$.ajax({
			type:"POST",
			url: "userIdCompareAjax.mall",
			data:{id:v_id.value},
			success: function(data){
				var json = JSON.parse(data);
				if(json.result == 'yes'){
					$('#idChk').html("");
					$('#idChk').html("이미 존재합니다.");
					$('#checkId').val("0"); // 0은 중복체크 미완료, 아이디변경됨
				} else {
					$('#idChk').html("");
					$('#idChk').html("사용 가능합니다.");
					$('#checkId').val("1"); // 1은 중복체크 완료
				}
			}
		});
	}
</script>
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
    function returnMyPage(){
    	location.href="UserMyPageForm.mall"
    }
</script>
</head>
<body>
  <form action="UserJoinPro.mall" name="frm" onsubmit="return chk()">
  	<input type="hidden" value="0" id="checkId">
	
	<div style="text-align:center">
	<h1><strong>JOIN US</strong></h1>
	<h2>회원가입</h2></div>
	
	<h3>기본 정보(<span style="color:orange">◎</span>)필수 입력사항</h3>
		<table border="1">
		<colgroup>
			<col style="background:#EDCE7A"></colgroup> 
			<tr>
				<td><span style="color:orange">◎</span>아이디</td>
				<td><input type="text" name="id" value="" placeholder="ID를 입력하세요" autofocus required="required">
				<input type="button" onclick="winop()" style="background-color:#EDCE7A" value="아이디 중복확인" <td><div id="idChk"></div>(영,&nbsp;소문자/숫자,&nbsp;4~16자)</td>></td>
			</tr>
			<tr>
				<td><span style="color:orange">◎</span>비밀번호</td>
				<td><input type="password" name="pw" value="" placeholder="비번을 입력하세요" maxlength="8" required="required" <td>(영문&nbsp;대소문자/숫자&nbsp;4~6자)</td> ></td>
				
			</tr>
			<tr>
				<td><span style="color:orange">◎</span>비밀번호 확인</td>
				<td><input type="password" name="pw2" value="" placeholder="비번을 재입력하세요" maxlength="8" required="required"></td>
			</tr>
			<tr>
				<td><span style="color:orange">◎</span>이름</td>
				<td><input type="text" name="nm" required="required"></td>
			</tr>
			<tr>
				<td><span style="color:orange">◎</span>주소</td>
				<td><input type="text" name="addtext1" id="zipcode">
					<input type="button" onclick="findZipcode()" style="background-color:#EDCE7A" value="우편번호&nbsp;조회"><p>
					<input type="text" name="addtext2" id="addr"><p>
					<input type="text" name="addtext3" id="addr_detail">
			</tr>
			<tr>
				<td><span style="color:orange">◎</span>휴대전화</td>
				<td><input type="tel" name="tel" required="required"
					pattern="\d{2,3}-\d{3,4}-\d{4}" placeholder="xxx-xxxx-xxxx"
					title="2,3자리-3,4자리-4자리"></td>
			</tr>
			<tr>
				<td><span style="color:orange">◎</span>이메일</td>
				<td><input type="text" name="mail" required></td> 
			</tr>
			<tr>
				<td><span style="color:orange">◎</span>이메일 수신 여부</td>
				<td><input type="checkbox" name="mail" onclick="chmail" required></td> 
			</tr>
			<tr>
				<td><span style="color:orange">◎</span>생년월일</td>
				<td>
					<input type="date" name="birth" value="YYYY-MM-DD" >
				</td>
			</tr>
			<tr>
				<td><span style="color:orange">◎</span>이용약관&nbsp;동의(필수)</td>
				<td><textarea name="notice" cols="50" rows="8">
								정보통신망법 규정에 따라 네이버에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.
				1. 수집하는 개인정보
				이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 네이버 서비스를 회원과 동일하게 이용할 수 있습니다. 이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, 네이버는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.
				
				회원가입 시점에 네이버가 이용자로부터 수집하는 개인정보는 아래와 같습니다.
				- 회원 가입 시에 ‘아이디, 비밀번호, 이름, 생년월일, 성별, 가입인증 휴대폰번호’를 필수항목으로 수집합니다. 만약 이용자가 입력하는 생년월일이 만14세 미만 아동일 경우에는 법정대리인 정보(법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(DI), 휴대폰번호)를 추가로 수집합니다. 그리고 선택항목으로 이메일 주소를 수집합니다.
				- 단체아이디로 회원가입 시 단체아이디, 비밀번호, 단체이름, 이메일주소, 가입인증 휴대폰번호를 필수항목으로 수집합니다. 그리고 단체 대표자명, 비밀번호 발급용 멤버 이름 및 이메일주소를 선택항목으로 수집합니다.
				서비스 이용 과정에서 이용자로부터 수집하는 개인정보는 아래와 같습니다.
				NAVER 내의 개별 서비스 이용, 이벤트 응모 및 경품 신청 과정에서 해당 서비스의 이용자에 한해 추가 개인정보 수집이 발생할 수 있습니다. 추가로 개인정보를 수집할 경우에는 해당 개인정보 수집 시점에서 이용자에게 ‘수집하는 개인정보 항목, 개인정보의 수집 및 이용목적, 개인정보의 보관기간’에 대해 안내 드리고 동의를 받습니다.
				</textarea>
				이용약관&nbsp;동의하십니까?<input type="checkbox" name="agree"/></td></tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="회원가입">
					<input type="reset" value="회원가입취소"></td>
			</tr>
		</table>
  </form>	
</body>
</html>