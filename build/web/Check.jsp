<%-- 
    Document   : check
    Created on : 3 Mar, 2011, 4:30:37 PM
    Author     : aditya
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@page language="java" import="java.sql.*,java.util.*,javax.naming.*,javax.naming.directory.*,java.util.Hashtable,javax.naming.directory.DirContext.*;"%>
<%
try
{


  String uname=request.getParameter("text1");
  String pswd=request.getParameter("text2");
  String dept=request.getParameter("department");
  String cat=request.getParameter("category");

  //System.out.println(uname+" "+pswd);
  Hashtable authEnv = new Hashtable();
  String base = "ou=people,dc=iitb,dc=ac,dc=in";
  //String dn = "uid=" + uname + "," + base;
  String dn="";
  if(cat.equalsIgnoreCase("Sysads"))
  {
      dn=dn+"uid="+uname+",cn="+cat+",ou="+dept+","+base;
  }
  else
  {
      dn="uid="+uname+",ou="+cat+",ou="+dept+","+base;
  }
  System.out.println(dn);
  String ldapURL = "ldap://ldap.iitb.ac.in:389";
  authEnv.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory");
  authEnv.put(Context.PROVIDER_URL, ldapURL);
  System.out.println("Vach");
  authEnv.put(Context.SECURITY_AUTHENTICATION, "simple");
  authEnv.put(Context.SECURITY_PRINCIPAL, dn);
  authEnv.put(Context.SECURITY_CREDENTIALS,pswd);
  request.getSession().setAttribute("uname",request.getParameter("text1"));

  DirContext authContext = new InitialDirContext(authEnv);
  System.out.println("Authentication Success!");
  session.setAttribute("username",request.getParameter("uname"));
  session.setAttribute("password",request.getParameter("pswd"));
  session.setMaxInactiveInterval(33382700);
  response.sendRedirect("index.jsp");
}
catch (AuthenticationException authEx)
{
  System.out.println("Authentication failed!");


  response.sendRedirect("restricted.html");
}
catch (NamingException namEx)
{
  System.out.println("Something went wrong!");
  namEx.printStackTrace();


 response.sendRedirect("restricted.html");

}
catch(Exception e)
{
     e.printStackTrace();


       response.sendRedirect("restricted.html");


}
%>


