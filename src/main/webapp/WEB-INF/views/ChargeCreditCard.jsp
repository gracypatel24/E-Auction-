<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="charge" method="post">
    Amount: <input type="text" name="amount"/><br/>

    Card Number: <input type="text" name="cardNumber"/><br/>
	Expiry Month: <input type="text" name="expMonth" maxlength="2"/><br/>
	Expiry Year:  <input type="text" name="expYear" maxlength="2"/><br/>
    CVV: <input type="password" name="cvv"/><br/>

    <input type="submit" value="Pay Now"/>
</form>

</body>
</html>