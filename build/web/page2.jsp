<%-- 
    Document   : page2
    Created on : Apr 28, 2009, 4:01:24 AM
    Author     : Ganesh
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="iitb.ctara.ahp.DataHolder"%>
<%@page import="iitb.ctara.ahp.TreeNode"%>
<%@include file="header.jspf"%>
<%
DataHolder dataHolder = (DataHolder) request.getSession().getAttribute("dataHolder");
dataHolder.unsetToReadFromDisk();
dataHolder.set_num_techs(Integer.parseInt(request.getParameter("txtNo_Tech")));
dataHolder.set_num_persp(Integer.parseInt(request.getParameter("txtNo_Perspectives")));
dataHolder.setObjectiveName(request.getParameter("objectiveName"));
dataHolder.setWorkSpace(request.getParameter("workSpace"));
TreeNode treeNode = new TreeNode(0);
dataHolder.addNode2Expand(treeNode);
%>

<form action="page3.jsp" method="POST">
<tr><td bgcolor="#999999">No. Of Attributes/<br>Group Of Attributes (Criteria):</td><td bgcolor="blue"><input type="text" name="<%="NA_"+treeNode.getSignature()%>"</td><td>The attributes for the technological alternatives. The attributes will remain the same for the different perspectives. </tr>
<%
for(int techId=0;techId<dataHolder.getNumTechs();techId++){
    %>
    <tr><td bgcolor="#999999">Name of Technology No. <%=techId%></td><td bgcolor="blue"><input type="text" name="<%="techName_"+techId%>" value="<%="Technology "+techId%>"</td><td></tr>
    <%
}
%>
<%
for(int perspId=0;perspId<dataHolder.getNumPersp();perspId++){
    %>
    <tr><td bgcolor="#999999">Name of Perspective No. <%=perspId%></td><td bgcolor="blue"><input type="text" name="<%="perspName_"+perspId%>" value="<%="Perspective "+perspId%>"</td><td></tr>
    <%
}
%>

<tr><td colspan="2" align="center"><input type="submit" value="Proceed"></td></tr>
</form>

<%@include file="footer.jspf"%>