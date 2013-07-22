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
dataHolder.printGraph();
ArrayList newNodeList  = new ArrayList();

for(int perspId=0; perspId<dataHolder.getNumTechs(); perspId++){
    for(int attrId=0; attrId<dataHolder.numAttributes(); attrId++){
        TreeNode treeNode = dataHolder.getAttributeTreeNode(attrId);
        if(!treeNode.isQualitative()) continue;
       for(int techId=0; techId<dataHolder.getNumTechs(); techId++){
           for(int techId1=0; techId1<dataHolder.getNumTechs(); techId1++){
                if(techId1>techId){
                    float val = Float.parseFloat(request.getParameter("QUAL_"+treeNode.getSignature()+"_"+perspId+"_"+techId+"_"+techId1));
                    dataHolder.setQualAttribPerspEntry(attrId,perspId,techId,techId1,val);
                }
            }
       }
    }
}
%>

        <form action="matrixProcessing.jsp" method="POST">
        
<tr>
<%
for(int perspId=0; perspId<dataHolder.getNumTechs(); perspId++){
%>
  <tr>
  <tr><td><%="Perspective"+perspId%></td></tr>  
  <tr>
  <%
    TreeSet vertexCollection = dataHolder.getVertices();
    Iterator it = vertexCollection.iterator();
    while(it.hasNext()){
        TreeNode treeNode = (TreeNode) it.next();
        TreeSet childrenCollection = dataHolder.getNeighbors(treeNode);
        if(childrenCollection.size()==0) continue;
  %>
      <tr>
      <tr><td><%="Parent="+treeNode.getNodeName()+" ("+treeNode.getSignature()+")"%></td></tr>  
      <tr>
      <td></td>
  <%
        Iterator itChildren = childrenCollection.iterator();
        while(itChildren.hasNext()){
            TreeNode childNode = (TreeNode) itChildren.next();
  %>
       <td><%=childNode.getNodeName()+" (A_"+childNode.getSignature()+") "%></td>
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
            <td><%=childNode.getNodeName()+" (A_"+childNode.getSignature()+") "%></td>
            <%
                Iterator itChildren1 = childrenCollection.iterator();
                while(itChildren1.hasNext()){
                    TreeNode childNode1 = (TreeNode) itChildren1.next();
                    int comparison = childNode.getSignature().compareTo(childNode1.getSignature());
                    if(comparison > 0){
            %>
                        <td><input type="text" name="<%="QUAL_"+childNode.getSignature()+"_"+childNode1.getSignature()%>" value="<%="0"%>"></td>
            <%
                    }
                    else if(comparison==0){
            %>
                        <td>1</td>
            <%          
                    }
                    else{
            %>
                        <td>AUTO</td>
            <%          
                    }

                }
            %>
            </tr>
        <%
           }
    }
        %>
    
    </tr>
    <tr></tr>
    <tr></tr>
    <tr></tr>
    <tr></tr>

<%
}
%>
</tr>
<tr><td colspan="2" align="center"><input type="submit" value="Proceed & Rank Technological Alternatives"></td></tr>

</form>


<%@include file="footer.jspf"%>