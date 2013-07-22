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
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.Iterator"%>

<%@include file="header.jspf"%>

<form action="matrixProcessing.jsp" method="POST">

<tr></tr>
<tr>
<%
//int no_attr =Integer.parseInt( request.getParameter("txtNo_Attr") );
DataHolder dataHolder = (DataHolder) request.getSession().getAttribute("dataHolder");
//dataHolder.printGraph();
if(dataHolder.readFromDisk()){
    dataHolder.setObjectiveName(request.getParameter("objectiveName"));
    dataHolder.setWorkSpace(request.getParameter("workSpace"));   
    dataHolder.readData();
    dataHolder.unsetToReadFromDisk();
}
else{
    dataHolder.writeData();
}
for(int perspId=0; perspId<dataHolder.getNumPersp(); perspId++){
    TreeNode dummyTreeNode = null;
    dataHolder.setNodeWeights(dummyTreeNode,perspId);
    ArrayList resultList = dataHolder.rankTechnologies(perspId);
    /*TreeMap<String,Float>*/ TreeMap valueMap = (TreeMap) resultList.get(0);
    /*TreeMap<Integer,Float[]>*/ TreeMap tech2RankMap = (TreeMap)  resultList.get(1);

    %>
     <td bgcolor="violet"><font><%=dataHolder.getPerspName(perspId)+" (Perspective "+perspId+")"%></font></td>  
     <tr>
     <td></td>
    <%
    for(int techId=0; techId<dataHolder.getNumTechs(); techId++){
        %>
          <td bgcolor="grey"><%=dataHolder.getTechnologyName(techId)+" (Technology "+techId+")"%></td>  
        <%
    }
    %>
    <td bgcolor="pink">Attribute weight</td></tr>
    <%
    for(int attrId=0; attrId<dataHolder.numAttributes(); attrId++){
        TreeNode treeNode = dataHolder.getAttributeTreeNode(attrId);
        
        %>
        <tr>
        <td bgcolor="grey"><%=treeNode.getNodeName()+" ("+ treeNode.getSignature()+")"%></td> 
        <%
        for(int techId=0; techId<dataHolder.getNumTechs(); techId++){
        %>
            <td bgcolor="blue"><%=((Float) valueMap.get(treeNode.getSignature()+"#"+techId)).floatValue()%></td> 
        <%            
        }
    %>
        <td bgcolor="cyan"><%=dataHolder.getNodeWeight(perspId, treeNode)%></td>
        </tr>        
    <%
    }
    %>
    <tr>
    <td bgcolor="red"><font color="white">DEFAULT RANK</font></td> 
    <%
    for(int techId=0; techId<dataHolder.getNumTechs(); techId++){
        Float[] valueAndRank = ((Float[]) tech2RankMap.get(new Integer(techId)));
    %>
        <td bgcolor="red"><font color="white"><%=valueAndRank[1]+" (Score="+valueAndRank[0]+")"%></font></td> 
    <%            
    }
    %>
    </tr>
    <%
    TreeSet level1Set = dataHolder.getLevel1Vertices();
    Iterator it = level1Set.iterator();
    while(it.hasNext()){
        TreeNode treeNode = (TreeNode) it.next();
        dataHolder.setNodeWeights(treeNode,perspId);
        resultList = dataHolder.rankTechnologies(perspId);
        /*TreeMap<Integer,Float[]>*/ tech2RankMap = (TreeMap)  resultList.get(1);
        %>
        <tr>
        <td bgcolor="red"><font color="white">RANK WITHOUT SUBTREE AT <%=treeNode.getNodeName()%></font></td> 
        <%
        for(int techId=0; techId<dataHolder.getNumTechs(); techId++){
            Float[] valueAndRank = ((Float[]) tech2RankMap.get(new Integer(techId)));
        %>
            <td bgcolor="red"><font color="white"><%=valueAndRank[1]+" (Score="+valueAndRank[0]+")"%></font></td> 
        <%            
        }
        %>
        </tr>
        <%        
    }
}
dataHolder.printData();
%>


</form>


<%@include file="footer.jspf"%>