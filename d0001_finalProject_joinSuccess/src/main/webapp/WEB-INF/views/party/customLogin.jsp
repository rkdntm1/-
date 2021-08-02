<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<mete name="viewport" content="width=device-width", initial-scale=1.0">
<title>어서오세요 로그인페이지입니다</title>
<link rel="stylesheet" href="/resources/css/loginStyle.css">
</head> 
<body>
	<section>
		<div class="color"></div>
		<div class="color"></div>
		<div class="color"></div>
		<div class="box">
			<div class="square" style="--i:0;"></div>
			<div class="square" style="--i:1;"></div>
			<div class="square" style="--i:2;"></div>
			<div class="square" style="--i:3;"></div>
			<div class="square" style="--i:4;"></div>
				
			<div class="container">
				<div class="form">
					<h2>로그인</h2>
					<form method="post" action="/login" role="form">
						<div class="inputBox">
							<input type="text" name="username" placeholder="아이디" autofocus>
						</div>				
						<div class="inputBox">
							<input type="password" name="password" placeholder="비번">
						</div>				
						<div class="inputBox">
							<input type="submit" value="로그인">
						</div>				
						<p class="forget">아이디를 잊으셨나요?<a href="#"> 아이디 찾기</a></p>
						<p class="forget">회원이 아니신가요?<a href="/party/registerClassify"> 회원가입하기</a></p>
						<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>
						<br><h4>${error}</h4>
						<h4>${logout}</h4>
					</form>
				</div>		
			</div>
		</div>
	</section>
</body>
</html>