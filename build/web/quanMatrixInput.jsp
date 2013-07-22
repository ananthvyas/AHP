<%-- 
    Document   : page3
    Created on : Apr 28, 2009, 4:05:17 AM
    Author     : Ganesh
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="iitb.ctara.ahp.DataHolder"%>
<%@page import="iitb.ctara.ahp.TreeNode"%>
<%@page import="java.util.ArrayList"%>

<%@include file="header.jspf"%>

<%
//int no_attr =Integer.parseInt( request.getParameter("txtNo_Attr") );
DataHolder dataHolder = (DataHolder) request.getSession().getAttribute("dataHolder");
if(dataHolder.readFromDisk()){
    dataHolder.setObjectiveName(request.getParameter("objectiveName"));
    dataHolder.setWorkSpace(request.getParameter("workSpace"));   
    dataHolder.readData();
    dataHolder.unsetToReadFromDisk();
}
else{
    dataHolder.commitTree();
    //dataHolder.printGraph();
}
ArrayList newNodeList  = new ArrayList();
%>

        <form action="qualMatrixInput.jsp" method="POST">

<tr>
<td></td>
<%
for(int techId=0; techId<dataHolder.getNumTechs(); techId++){
%>
  <td bgcolor="yellow"><%=dataHolder.getTechnologyName(techId)+" (Technology "+techId+")"%></td>  
<%
}
%>
<%
for(int perspId=0; perspId<dataHolder.getNumPersp(); perspId++){
%>
  <td bgcolor="yellow"><%=dataHolder.getPerspName(perspId)+" (Perspective "+perspId+")"%></td>  
<%
}
%>

</tr>

<%
for(int attrId=0; attrId<dataHolder.numAttributes(); attrId++){
    TreeNode treeNode = dataHolder.getAttributeTreeNode(attrId);
    if(!treeNode.isQuantitative()) continue;
%>
<tr>
    <td bgcolor="grey"><%=treeNode.getNodeName()+" (A_"+treeNode.getSignature()+") "%></td>
<%
    for(int techId=0; techId<dataHolder.getNumTechs(); techId++){
%>
      <td bgcolor="blue"><input type="text" name="<%="QUAN_"+treeNode.getSignature()+"_T"+techId%>" value="<%=dataHolder.getQuantAttribForTech(treeNode.getSignature(), techId)%>"></td>
<%
    }
%>
<%
    for(int perspId=0; perspId<dataHolder.getNumPersp(); perspId++){
        boolean isCost = dataHolder.getQuantAttribForPersp(perspId, treeNode.getSignature());
        if(isCost){
%>
      <td  bgcolor="orange"> <input type="radio" name="<%="QUAN_"+treeNode.getSignature()+"_P"+perspId%>" value="cost"  checked="checked" /> Cost
           <input type="radio" name="<%="QUAN_"+treeNode.getSignature()+"_P"+perspId%>" value="benefit"/> Benefit  </td>

<%
        }
        else{
%>
      <td  bgcolor="orange"> <input type="radio" name="<%="QUAN_"+treeNode.getSignature()+"_P"+perspId%>" value="cost" /> Cost
           <input type="radio" name="<%="QUAN_"+treeNode.getSignature()+"_P"+perspId%>" value="benefit"  checked="checked"/> Benefit  </td>

<%
        }
    }
%>

</tr>

<%
}
%>

<tr><td colspan="2" align="center"><input type="submit" value="Proceed & Fill up Description of Qualitative Attributes"></td></tr>

</form>


<%@include file="footer.jspf"%>