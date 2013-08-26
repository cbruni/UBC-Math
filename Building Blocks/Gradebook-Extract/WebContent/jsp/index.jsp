<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/bbNG" prefix="bbNG"%>

<bbNG:genericPage>
<bbNG:pageHeader>
<bbNG:pageTitleBar title="Welcome Page"></bbNG:pageTitleBar>
</bbNG:pageHeader>

	<!DOCTYPE html>
	<html>
	<head>

	</head>
	<body>
		<jsp:include page="grades.jsp"></jsp:include>
	
	<hr />
	<h1> Welcome Page Layout v1.0</h1>
	
<%-- 	<jsp:forward page="welcome_new.jsp"></jsp:forward> --%>
	
	</body>
	</html>
</bbNG:genericPage>

