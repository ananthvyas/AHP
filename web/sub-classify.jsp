<%-- 
    Document   : sub-classify
    Created on : Apr 28, 2009, 4:20:26 AM
    Author     : Ganesh
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@include file="header.jspf"%>
<%
int AID =Integer.parseInt( request.getParameter("Aid") );

%>
<form action="page3.jsp?aid=<%=AID%>" method="POST">
<tr><td>No. Of Attributes/<br>Group Of Attributes (Criteria):</td><td><input type="text" name="txtNo_Attr"></td></tr>
<tr><td colspan="2" align="center"><input type="submit" value="Proceed"></td></tr>
</form>


<%@include file="footer.jspf"%>
