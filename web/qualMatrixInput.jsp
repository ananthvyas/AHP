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
for(int perspId=0; perspId<dataHolder.getNumPersp(); perspId++){
    for(int attrId=0; attrId<dataHolder.numAttributes(); attrId++){
        TreeNode treeNode = dataHolder.getAttributeTreeNode(attrId);
        if(!treeNode.isQualitative()) continue;
       for(int techId=0; techId<dataHolder.getNumTechs(); techId++){
           for(int techId1=0; techId1<dataHolder.getNumTechs(); techId1++){
                if(techId1>techId){
                    if(request.getParameter("QUAL_"+treeNode.getSignature()+"_"+perspId+"_"+techId+"_"+techId1)==null) continue;
                    float val = Float.parseFloat(request.getParameter("QUAL_"+treeNode.getSignature()+"_"+perspId+"_"+techId+"_"+techId1));
                    dataHolder.setQualAttribPerspEntry(perspId, treeNode.getSignature(), techId, techId1, val);
                }
            }
       }
    }
}

String CIThresholdForQualMatrixString = request.getParameter("CIThresholdForQualMatrix");
if(CIThresholdForQualMatrixString!=null){
    float CIThresholdForQualMatrix = Float.parseFloat(CIThresholdForQualMatrixString);
    dataHolder.setCIThresholdForQualMatrix(CIThresholdForQualMatrix);
}

//dataHolder.initializeSiblingPairWeights();
for(int attrId=0; attrId<dataHolder.numAttributes(); attrId++){
    TreeNode treeNode = dataHolder.getAttributeTreeNode(attrId);
    if(!treeNode.isQuantitative()) continue;
    for(int techId=0; techId<dataHolder.getNumTechs(); techId++){
        String tempQuantTechMeasure = request.getParameter("QUAN_"+treeNode.getSignature()+"_T"+techId);
        if(tempQuantTechMeasure!=null){
            float quantTechMeasure = 0;
            quantTechMeasure = Float.parseFloat(tempQuantTechMeasure);
            dataHolder.setQuantAttribForTech(treeNode.getSignature(), techId, quantTechMeasure);
        }
        
    }
    for(int perspId=0; perspId<dataHolder.getNumPersp(); perspId++){
        String tempQuantPerspMeasure = request.getParameter("QUAN_"+treeNode.getSignature()+"_P"+perspId);
        if(tempQuantPerspMeasure!=null){
            boolean isCost = false;
            if(tempQuantPerspMeasure.equals("cost")) isCost = true;
            dataHolder.setQuantAttribForPersp(perspId, treeNode.getSignature(), isCost);
        }
        
    }
}
ArrayList violatorNodes = dataHolder.getViolatorQualMatrixNodes();
boolean existViolators = false;
for(int i=0; i<violatorNodes.size();i=i+3){
    boolean isViolator = ((Boolean) violatorNodes.get(i)).booleanValue();
    existViolators = existViolators || isViolator;
}
if(!existViolators){
%>

        <form action="siblingInfo.jsp" method="POST">  
        <tr>
<%
}
else{
%>

        <form action="qualMatrixInput.jsp" method="POST">  
        <td bgcolor="black"><font color="white">CI Threshold=</font></td>
        <td bgcolor="black"><font color="white"><input type="text" name="CIThresholdForQualMatrix" value="<%=dataHolder.getCIThresholdForQualMatrix()%>"></font></td>
  
<%
}
for(int i=0; i<violatorNodes.size();i=i+3){
    boolean isViolator = ((Boolean) violatorNodes.get(i)).booleanValue();
    int perspId = ((Integer) violatorNodes.get(i+1)).intValue();
    int attrId = ((Integer) violatorNodes.get(i+2)).intValue();
    TreeNode treeNode = dataHolder.getAttributeTreeNode(attrId);
    //if(!treeNode.isQualitative()) continue;
%>
  <tr>
  
  <%
  if(isViolator && dataHolder.get_visitedQualMatrixInputInfo()){
  %>
    <td bgcolor="red"><font color="white">PLEASE REVISE SO THAT CI<<%=dataHolder.getCIThresholdForQualMatrix()%></font></td>
  <%
  }
  else if(!dataHolder.get_visitedQualMatrixInputInfo()){
  %>
    <td bgcolor="orange"><font color="white">PLEASE ENTER VALUES SO THAT CI<<%=dataHolder.getCIThresholdForQualMatrix()%></font></td>
  <%
  }
  else{
  %>
    <td bgcolor="green"><font color="white">REVISION ACCEPTED</font></td>
  <%      
  }
  %>
  <font color="purple"><td><%=dataHolder.getPerspName(perspId)+" (Perspective "+perspId+")"%></td><td bgcolor="yellow"><%=treeNode.getNodeName()+" (A_"+treeNode.getSignature()+") Lambda_max="+dataHolder.getLambdaMaxForQualMatrix(perspId,treeNode.getSignature())+" CI="+dataHolder.getCIForQualMatrix(perspId,treeNode.getSignature())%></td></font></tr>
  <tr>
  <td></td>
      <%
      for(int techId=0; techId<dataHolder.getNumTechs(); techId++){
      %>
            <td bgcolor="#999877"><%=dataHolder.getTechnologyName(techId)+" (Technology "+techId+")"%></td>
       <%
       }
       %>
       </tr>
       <%
       for(int techId=0; techId<dataHolder.getNumTechs(); techId++){
       %>
           <tr>
           <td bgcolor="grey"><%=dataHolder.getTechnologyName(techId)+" (Technology "+techId+")"%></td>
           <%
           for(int techId1=0; techId1<dataHolder.getNumTechs(); techId1++){
                if(techId1>techId){
                    if(!isViolator){
        %>
                    <td bgcolor="blue"><%=dataHolder.getQualAttribPerspEntry(perspId, treeNode.getSignature(), techId, techId1)%></td>
        <%
                    }
                    else{
         %>
                     <td bgcolor="blue"><input type="text" name="<%="QUAL_"+treeNode.getSignature()+"_"+perspId+"_"+techId+"_"+techId1%>" value="<%=dataHolder.getQualAttribPerspEntry(perspId, treeNode.getSignature(), techId, techId1)%>"></td>
        <%
                    }
                }

                else if(techId1==techId){
        %>
                    <td bgcolor="blue"><%=dataHolder.getQualAttribPerspEntry(perspId, treeNode.getSignature(), techId, techId1)%></td>
        <%          
                }
                else{
                    if(!isViolator){
        %>
                        <td bgcolor="blue"><%=dataHolder.getQualAttribPerspEntry(perspId, treeNode.getSignature(), techId, techId1)%></td>
        <%       
                    }
                    else{
         %>
                      <td bgcolor="blue">AUTO</td>
        <%
                    }
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
dataHolder.set_visitedQualMatrixInputInfo();
%>
</tr>
<tr><td colspan="2" align="center"><input type="submit" value="Enter attribute sibling info"></td></tr>

</form>


<%@include file="footer.jspf"%>