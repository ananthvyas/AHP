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
dataHolder.printGraph();
ArrayList newNodeList  = new ArrayList();
%>

        <form action="matrixProcessing.jsp" method="POST">

<%
dataHolder.initializeQualMatrix();
for(int attrId=0; attrId<dataHolder.numAttributes(); attrId++){
    TreeNode treeNode = dataHolder.getAttributeTreeNode(attrId);
    if(!treeNode.isQuantitative()) continue;
    for(int techId=0; techId<dataHolder.getNumTechs(); techId++){
        String tempQuantTechMeasure = request.getParameter("QUAN_"+treeNode.getSignature()+"_T"+techId);
        int quantTechMeasure = 0;
        if(tempQuantTechMeasure!=null){
            quantTechMeasure = Integer.parseInt(tempQuantTechMeasure);
        }
        dataHolder.setQuantAttribForTech(attrId, techId, quantTechMeasure);
    }
    for(int perspId=0; perspId<dataHolder.getNumPersp(); perspId++){
        String tempQuantPerspMeasure = request.getParameter("QUAN_"+treeNode.getSignature()+"_P"+perspId);
        boolean isCost = false;
        if(tempQuantPerspMeasure!=null){
            if(tempQuantPerspMeasure.equals("cost")) isCost = true;
        }
        dataHolder.setQuantAttribForPersp(attrId, perspId, isCost);
    }
}
%>

        
<tr>
<%
for(int perspId=0; perspId<dataHolder.getNumTechs(); perspId++){
for(int techId=0; techId<dataHolder.getNumTechs(); techId++){
%>
  <tr>
  <tr><td><%="Technology"+techId%></td><td><%="Perspective"+perspId%></td></tr>  
  <tr>
  <td></td>
  <%
    for(int attrId=0; attrId<dataHolder.numAttributes(); attrId++){
        TreeNode treeNode = dataHolder.getAttributeTreeNode(attrId);
        if(!treeNode.isQualitative()) continue;
    
  %>
        <td><%=treeNode.getNodeName()+" (A_"+treeNode.getSignature()+") "%></td>
  <%
    }
  %>
  </tr>
   
  <%
    for(int attrId=0; attrId<dataHolder.numAttributes(); attrId++){
        TreeNode treeNode = dataHolder.getAttributeTreeNode(attrId);
        if(!treeNode.isQualitative()) continue;
  %>
        <tr>
        <td><%=treeNode.getNodeName()+" (A_"+treeNode.getSignature()+") "%></td>
        <%
            for(int attrId1=0; attrId1<dataHolder.numAttributes(); attrId1++){
                TreeNode treeNode1 = dataHolder.getAttributeTreeNode(attrId1);
                if(!treeNode1.isQualitative()) continue;
                if(attrId1>attrId){
        %>
                    <td><input type="text" name="<%="QUAL_"+treeNode.getSignature()+"_"+treeNode1.getSignature()%>" value="<%="0"%>"></td>
        <%
                }
                else if(attrId1==attrId){
        %>
                    <td>1</td>
        <%          
                }
                else{
        %>
                    <td>AUTO</td>
                    <!--<td>1/<%="Entry("+treeNode.getNodeName()+","+treeNode1.getNodeName()+")"%></td>-->
        <%          
                }

            }
        %>
        </tr>
    <%
       }
    %>
    
    </tr>
    <tr></tr>
    <tr></tr>
    <tr></tr>
    <tr></tr>

<%
}
}
%>
</tr>
<tr><td colspan="2" align="center"><input type="submit" value="Proceed & Rank Technological Alternatives"></td></tr>

</form>


<%@include file="footer.jspf"%>