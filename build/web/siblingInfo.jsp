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
<%@page import="java.util.Collection"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.Iterator"%>

<%@include file="header.jspf"%>

<%
//int no_attr =Integer.parseInt( request.getParameter("txtNo_Attr") );
DataHolder dataHolder = (DataHolder) request.getSession().getAttribute("dataHolder");

for(int perspId=0; perspId<dataHolder.getNumPersp(); perspId++){
    for(int attrId=0; attrId<dataHolder.numAttributes(); attrId++){
        TreeNode treeNode = dataHolder.getAttributeTreeNode(attrId);
        if(!treeNode.isQualitative()) continue;
       for(int techId=0; techId<dataHolder.getNumTechs(); techId++){
           for(int techId1=0; techId1<dataHolder.getNumTechs(); techId1++){
                if(techId1<techId){
                    if(request.getParameter("QUAL_"+treeNode.getSignature()+"_"+perspId+"_"+techId+"_"+techId1)==null) continue;
                    float val = Float.parseFloat(request.getParameter("QUAL_"+treeNode.getSignature()+"_"+perspId+"_"+techId+"_"+techId1));
                    dataHolder.setQualAttribPerspEntry(perspId, treeNode.getSignature(), techId, techId1, val);
                }
            }
       }
    }
}
%>

<%

String CIThresholdForSiblingInfoString = request.getParameter("CIThresholdForSiblingInfo");
if(CIThresholdForSiblingInfoString!=null){
    float CIThresholdForSiblingInfo = Float.parseFloat(CIThresholdForSiblingInfoString);
    dataHolder.setCIThresholdForSiblingInfo(CIThresholdForSiblingInfo);
}

for(int perspId=0; perspId< dataHolder.getNumPersp(); perspId++){
    TreeSet vertexCollection = dataHolder.getVertices();
    Iterator it = vertexCollection.iterator();
    while(it.hasNext()){
        TreeNode treeNode = (TreeNode) it.next();
        TreeSet childrenCollection = dataHolder.getSuccessors(treeNode);
        if(childrenCollection.size()==0) continue;
        Iterator itChildren = childrenCollection.iterator();
        while(itChildren.hasNext()){
            TreeNode childNode = (TreeNode) itChildren.next();
            Iterator itChildren1 = childrenCollection.iterator();
            while(itChildren1.hasNext()){
                TreeNode childNode1 = (TreeNode) itChildren1.next();
                int comparison = childNode.getSignature().compareTo(childNode1.getSignature());
                if(comparison < 0){
                    String param = request.getParameter("SIBLING#"+perspId+"#"+childNode.getSignature()+"#"+childNode1.getSignature());
                    if(param!=null){
                        dataHolder.setSiblingPairWeight(perspId, childNode.getSignature(), childNode1.getSignature(), Float.parseFloat(param));
                    }
                }
            }
        }
    }
}
ArrayList violatorNodes = dataHolder.getViolatorSiblingNodes();
boolean existViolators = false;
for(int i=0; i<violatorNodes.size();i=i+3){
    boolean isViolator = ((Boolean) violatorNodes.get(i)).booleanValue();
    existViolators = existViolators || isViolator;
}
if(!existViolators){
%>

        <form action="matrixProcessing.jsp" method="POST">  
        <tr>
<%
}
else{
%>

        <form action="siblingInfo.jsp" method="POST">  
        <tr>
        <td bgcolor="black"><font color="white">CI Threshold=</font></td>
        <td bgcolor="black"><font color="white"><input type="text" name="CIThresholdForSiblingInfo" value="<%=dataHolder.getCIThresholdForSiblingInfo()%>"></font></td>

<%
}
for(int i=0; i<violatorNodes.size();i=i+3){
    boolean isViolator = ((Boolean) violatorNodes.get(i)).booleanValue();
    int perspId = ((Integer) violatorNodes.get(i+1)).intValue();
    TreeNode treeNode = (TreeNode) violatorNodes.get(i+2);
    TreeSet childrenCollection = dataHolder.getSuccessors(treeNode);
    if(childrenCollection.size()==0) continue;
%>
  <tr>
  
  <%
  if(isViolator && dataHolder.get_visitedSiblingInfo()){
  %>
    <td bgcolor="red"><font color="white">PLEASE REVISE SO THAT CI<0.1</font></td>
  <%
  }
  else if(!dataHolder.get_visitedSiblingInfo()){
  %>
    <td bgcolor="orange"><font color="white">PLEASE ENTER VALUES SO THAT CI<0.1</font></td>
  <%
  }
  else{
  %>
    <td bgcolor="green"><font color="white">REVISION ACCEPTED</font></td>
  <%      
  }
  %>
  
  <font color="purple" size=7><td  bgcolor="yellow"><%=dataHolder.getPerspName(perspId)+" (Perspective "+perspId+")"%></td><td  bgcolor="yellow"><%="Parent attribute="+treeNode.getNodeName()+" ("+treeNode.getSignature()+")"+" Lambda_max="+dataHolder.getLambdaMaxForSiblingInfo(perspId,treeNode.getSignature())+" CI="+dataHolder.getCIForSiblingInfo(perspId,treeNode.getSignature())%></td></font></tr>  
  
  <tr>
  <td></td>
<%
    Iterator itChildren = childrenCollection.iterator();
    while(itChildren.hasNext()){
        TreeNode childNode = (TreeNode) itChildren.next();
%>
   <td  bgcolor="grey"><%=childNode.getNodeName()+" (A_"+childNode.getSignature()+") "%></td>
<%
    }   
%>
  </tr>
  <%
    itChildren = childrenCollection.iterator();
    while(itChildren.hasNext()){
        TreeNode childNode = (TreeNode) itChildren.next();
  %>
        <tr>
        <td  bgcolor="grey"><%=childNode.getNodeName()+" (A_"+childNode.getSignature()+") "%></td>
        <%
            Iterator itChildren1 = childrenCollection.iterator();
            while(itChildren1.hasNext()){
                TreeNode childNode1 = (TreeNode) itChildren1.next();
                int comparison = childNode.getSignature().compareTo(childNode1.getSignature());
                float value = dataHolder.getSiblingPairWeight(perspId,childNode.getSignature(),childNode1.getSignature());
                if(comparison < 0){
                    if(!isViolator){
        %>
                    <td  bgcolor="blue"><%=dataHolder.getSiblingPairWeight(perspId,childNode.getSignature(),childNode1.getSignature())%></td>
        <%
                    }
                    else{
        %>
                    <td  bgcolor="blue"><input type="text" name="<%="SIBLING#"+perspId+"#"+childNode.getSignature()+"#"+childNode1.getSignature()%>" value="<%=dataHolder.getSiblingPairWeight(perspId,childNode.getSignature(),childNode1.getSignature())%>"></td>
        <%
                    }
                }
                else if(comparison==0){
        %>
                    <td  bgcolor="blue"><%=dataHolder.getSiblingPairWeight(perspId,childNode.getSignature(),childNode1.getSignature())%></td>
        <%          
                }
                else{
                  if(!isViolator){
        %>
                    <td  bgcolor="blue"><%=dataHolder.getSiblingPairWeight(perspId,childNode.getSignature(),childNode1.getSignature())%></td>
        <%
                    }
                    else{
        %>
                    <td  bgcolor="blue">AUTO</td>
        <%     
                    }
                }
            }
        %>
        </tr>
    <%
    }
}
dataHolder.set_visitedSiblingInfo();
%>

</tr>
<tr></tr>
<tr></tr>
<tr></tr>
<tr></tr>

</tr>
<tr><td colspan="2" align="center"><input type="submit" value="Proceed & Rank Technological Alternatives"></td></tr>

</form>


<%@include file="footer.jspf"%>