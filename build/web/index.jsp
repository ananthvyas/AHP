<%-- 
    Document   : index
    Created on : Apr 28, 2009, 3:50:15 AM
    Author     : Ganesh
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@include file="header.jspf"%>
<%@page import="iitb.ctara.ahp.DataHolder"%>
<%@page import="iitb.ctara.ahp.TreeNode"%>

<%
DataHolder dataHolder = new DataHolder();
request.getSession().setAttribute("dataHolder",dataHolder);
//System.out.println(System.getProperty("user.dir")); System.out.println(System.getProperty("java.io.tmpdir"));
String dataPath = "/home/ahps/data/"; //"C:\downloads\";
%>

<form action="page2.jsp" method="POST">
<tr>
    <td bgcolor="red">Title of Objective</td><td bgcolor="blue"><input type="text" name="objectiveName" value=""></td>
</tr>
<tr>
    <td BGCOLOR="#999999">No. Of Technologies</td><td bgcolor="blue"><input type="text" name="txtNo_Tech" value=""></td><td bgcolor="0xx">Note that ultimately, you will be ranking different technologies for each perspective.</td>
</tr>
<tr>
    <td BGCOLOR="#999999">No. Of Perspectives</td><td bgcolor="blue"><input type="text" name="txtNo_Perspectives" value=""></td><td bgcolor="0xx">Note that a perspective is uniquely specified by the weightage assigned to the different attributes.</td>
</tr>
<tr>
    <td BGCOLOR="#999999">Workspace path on Disk</td><td bgcolor="blue"><input type="text" name="workSpace" value="<%=dataPath+(String)request.getSession().getAttribute("uname")%>" readonly></td><td bgcolor="0xx">Path on disk where the AHP data for this case must be saved.</td>
</tr>

<tr>
    <td><input type="reset"></td><td><input type="submit" name="proceed2" value="Proceed & Enter Attribute Data"></td>
</tr>
</form>

<tr></tr><tr></tr><tr></tr><tr></tr>
<tr></tr><tr></tr><tr></tr><tr></tr>
<td BGCOLOR="black" height="15"><font color="white">OR</font></td>
<tr></tr><tr></tr><tr></tr><tr></tr>
<tr></tr><tr></tr><tr></tr><tr></tr>



<form action="quanMatrixInput.jsp" method="POST">
<tr>
    <td bgcolor="red">Title of Objective</td><td color="blue"><input type="text" name="objectiveName" value=""></td>
</tr>
<tr>
    <td BGCOLOR="#999999">Workspace path on Disk</td><td bgcolor="blue"><input type="text" name="workSpace" value="<%=dataPath+(String)request.getSession().getAttribute("uname")%>" readonly></td><td bgcolor="0xx">Path on disk where the AHP data for this case has been saved.</td>
</tr>

<tr>
    <td><input type="reset"></td><td><input type="submit" name="loadFromDisk" value="Load Data from Disk for existing AHP case & Enter Numeric Values"></td>
</tr>
</form>

<tr></tr><tr></tr><tr></tr><tr></tr>
<tr></tr><tr></tr><tr></tr><tr></tr>
<td BGCOLOR="black" height="15"><font color="white">OR</font></td>
<tr></tr><tr></tr><tr></tr><tr></tr>
<tr></tr><tr></tr><tr></tr><tr></tr>



<form action="matrixProcessing.jsp" method="POST">
<tr>
    <td bgcolor="red">Title of Objective</td><td color="blue"><input type="text" name="objectiveName" value=""></td>
</tr>
<tr>
    <td BGCOLOR="#999999">Workspace path on Disk</td><td bgcolor="blue"><input type="text" name="workSpace" value="<%=(String)request.getSession().getAttribute("uname")%>" readonly></td><td bgcolor="0xx">Path on disk where the AHP data for this case has been saved.</td>
</tr>

<%
dataHolder.setToReadFromDisk();
%>

<tr>
    <td><input type="reset"></td><td><input type="submit" name="loadFromDisk" value="Load Data from Disk for existing AHP case & Directly Rank Technologies"></td>
</tr>
</form>

<%@include file="footer.jspf"%>
