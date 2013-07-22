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
<%@page import="java.util.TreeMap"%>

<%@include file="header.jspf"%>

<%
//int no_attr =Integer.parseInt( request.getParameter("txtNo_Attr") );
DataHolder dataHolder = (DataHolder) request.getSession().getAttribute("dataHolder");
dataHolder.unsetToReadFromDisk();
ArrayList newNodeList  = new ArrayList();
for(int techId=0;techId<dataHolder.getNumTechs();techId++){
    String technologyName = request.getParameter("techName_"+techId);
    if(technologyName!=null){
        dataHolder.setTechnologyName(techId,technologyName);
    }
}
for(int perspId=0;perspId<dataHolder.getNumPersp();perspId++){
    String perspName = request.getParameter("perspName_"+perspId);
    if(perspName!=null){
        dataHolder.setPerspName(perspId,perspName);
    }
}
%>

<%
int numNodes2FurtherExpand = 0;
for(int n=0;n<dataHolder.numNodes2Expand();n++){
    TreeNode treeNode = dataHolder.getNode2Expand(n);
    //System.out.println("treeNode="+treeNode);
    String numChildrenString = request.getParameter("NA_"+treeNode.getSignature());
    int numChildren = 0;
    if(numChildrenString!=null){
        numChildren = Integer.parseInt(numChildrenString);
    }
    numNodes2FurtherExpand+= numChildren;
}
    if(numNodes2FurtherExpand>0){
%>
        <form action="page3.jsp" method="POST">
<%
//System.out.println(dataHolder.get_num_persp());
    }
    else{
%>
        <form action="quanMatrixInput.jsp" method="POST">
<%
    }
%>

<tr><td><%=numNodes2FurtherExpand%> Attributes at Depth <%=dataHolder.incrementDepth()%></td></tr>
 
<%
for(int n=0;n<dataHolder.numNodes2Expand();n++){
    TreeNode treeNode = dataHolder.getNode2Expand(n);
    //System.out.println("treeNode="+treeNode);
    String numChildrenString = request.getParameter("NA_"+treeNode.getSignature());
    int numChildren = 0;
    if(numChildrenString!=null){
        numChildren = Integer.parseInt(numChildrenString);
    }
    treeNode.setNumChildren(numChildren);
    
    String nodeName = request.getParameter("A_"+treeNode.getSignature());
    String attrType = request.getParameter("attrType_"+treeNode.getSignature());

    if(nodeName==null){
        nodeName = dataHolder.getObjectiveName();
    }
    
    if(attrType==null){
        attrType="quant";
    }
    
    treeNode.setNodeName(nodeName);
    treeNode.setAttrType(attrType);
    
    for(int x=0;x<numChildren;x++)
        {
        TreeNode newTreeNode = new TreeNode(treeNode,x);
        newNodeList.add(newTreeNode);
        dataHolder.addEdge(treeNode, newTreeNode);
%>

<tr>
<%
    if(treeNode.getNodeName().equals(dataHolder.getObjectiveName())){
%>
    <td bgcolor="#999999">Enter Name for attribute no. <%=x+1%> of <%=treeNode.getNodeName()%></td>
<%
    }
    else{
%>
    <td>Enter Name for child no. <%=x+1%> of <%=treeNode.getNodeName()%></td>
<%
    }
%>
    <td bgcolor="blue"><input type="text" name="<%="A_"+newTreeNode.getSignature()%>" value="<%="A:"+newTreeNode.getSignature()%>"></td>
    <td bgcolor="#999999">No. Of Attributes</td><td bgcolor="blue"><input type="text" name="<%="NA_"+newTreeNode.getSignature()%>" value="0"</td>
    <td bgcolor="orange"> <input type="radio" name="<%="attrType_"+newTreeNode.getSignature()%>" value="quant"  checked="checked" /> Quantitative
         <input type="radio" name="<%="attrType_"+newTreeNode.getSignature()%>" value="qual"/> Qualitative  </td>

</tr>

<%
        
    }
}

//if(newNodeList.size()>0)   
dataHolder.setNodeList2Expand(newNodeList);

if(numNodes2FurtherExpand>0){
%>
        <tr><td colspan="2" align="center"><input type="submit" value="Proceed & Further Refine the Hierarchy"></td></tr>
<%
//System.out.println(dataHolder.get_num_persp());
    }
    else{
%>
        <tr><td colspan="2" align="center"><input type="submit" value="Proceed & Fill up Description of Quantitative Attributes"></td></tr>

<%
    }
%>


</form>


<%@include file="footer.jspf"%>